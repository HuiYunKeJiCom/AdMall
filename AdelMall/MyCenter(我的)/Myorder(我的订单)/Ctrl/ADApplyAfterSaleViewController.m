//
//  ADApplyAfterSaleViewController.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/13.
//  Copyright © 2018年 Adel. All rights reserved.
//  我的订单-选择订单中的商品

#import "ADApplyAfterSaleViewController.h"
#import "ADOrderTopToolView.h"//自定义导航栏
#import "ADApplyAfterSaleModel.h"
#import "ADApplyAfterSaleCell.h"

@interface ADApplyAfterSaleViewController ()<UITableViewDelegate,UITableViewDataSource,BaseTableViewDelegate>
@property (nonatomic, strong) BaseTableView         *allOrderTable;
/* 顶部Nva */
@property (strong , nonatomic)ADOrderTopToolView *topToolView;

@end

@implementation ADApplyAfterSaleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kBACKGROUNDCOLOR;
    [self setUpNavTopView];
    [self.view addSubview:self.allOrderTable];
    [self makeConstraints];
    [self requestAllOrder:NO];
}

#pragma mark - 导航栏处理
- (void)setUpNavTopView
{
    _topToolView = [[ADOrderTopToolView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    _topToolView.hidden = NO;
    _topToolView.backgroundColor = k_UIColorFromRGB(0xffffff);
    [_topToolView setTopTitleWithNSString:KLocalizableStr(@"选择订单中的商品")];
    WEAKSELF
    _topToolView.leftItemClickBlock = ^{
        NSLog(@"点击了返回");
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    //    _topToolView.rightItemClickBlock = ^{
    //        NSLog(@"点击设置");
    //    };
    
    [self.view addSubview:_topToolView];
    
}

#pragma mark - Constraints
- (void)makeConstraints {
    
    [self.allOrderTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).with.offset(65);
    }];
    
}

- (void)requestAllOrder:(BOOL)more {
    [self.allOrderTable updateLoadState:more];
    
    WEAKSELF
    //    NSLog(@"类型type = %ld",(long)weak_self.type);
    //    [RequestTool appTransferList:@{k_Type:@(self.type),
    //                                   k_NowPage:[NSNumber numberWithInteger:self.accountTable.currentPage],
    //                                   k_PageSize:@(k_RequestPageSize)} success:^(NSDictionary *result) {
    //
    //                                       [weak_self showHUD:NO];
    //                                       [weak_self handleTransferResult:result type:weak_self.type more:more];
    //                                   } fail:^(NSString *msg) {
    //                                       [weak_self showHUD:NO];
    //                                       [NSError showHudWithView:weak_self.view Text:msg delayTime:0.5];
    [weakSelf handleTransferResult:nil more:more];
    //                                   }];
    
}

- (void)handleTransferResult:(NSDictionary *)result more:(BOOL)more{
    
    NSArray *dataArr = @[@{@"id":@"123456",@"address":@"ADEL爱迪尔US3-7智能指纹锁小区",@"goodsType":@"家用木门防盗门锁密码锁感应锁",@"price":@"1888.00"},@{@"id":@"123456",@"address":@"ADEL爱迪尔US3-7智能指纹锁小区",@"goodsType":@"家用木门防盗门锁密码锁感应锁",@"price":@"1888.00"},@{@"id":@"123456",@"address":@"ADEL爱迪尔US3-7智能指纹锁小区",@"goodsType":@"家用木门防盗门锁密码锁感应锁",@"price":@"1888.00"}];
    //    if ([result isKindOfClass:[NSDictionary class]]) {
    //        NSArray *dataInfo = result[@"data"];
    //        if ([dataInfo isKindOfClass:[NSArray class]]) {
    //            dataArr = dataInfo;
    //        }
    //    }
    
    [self.allOrderTable.data removeAllObjects];
    for (NSDictionary *dic in dataArr) {
        
        ADApplyAfterSaleModel *model = [ADApplyAfterSaleModel mj_objectWithKeyValues:dic];
        [self.allOrderTable.data addObject:model];
    }
    
    [self.allOrderTable updatePage:more];
    //    self.allOrderTable.isLoadMore = dataArr.count >= k_RequestPageSize ? YES : NO;
    self.allOrderTable.noDataView.hidden = self.allOrderTable.data.count;
    
    [self.allOrderTable reloadData];
}

- (BaseTableView *)allOrderTable {
    if (!_allOrderTable) {
        _allOrderTable = [[BaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _allOrderTable.delegate = self;
        _allOrderTable.dataSource = self;
        _allOrderTable.isLoadMore = YES;
        _allOrderTable.isRefresh = YES;
        _allOrderTable.delegateBase = self;
        _allOrderTable.backgroundColor = kBACKGROUNDCOLOR;
        [_allOrderTable registerClass:[ADApplyAfterSaleCell class] forCellReuseIdentifier:@"ADApplyAfterSaleCell"];
        
    }
    return _allOrderTable;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section == 0){
        return 1;
    }else{
        return GetScaleWidth(10);
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, GetScaleWidth(10))];
    sectionView.backgroundColor = kBACKGROUNDCOLOR;
    return sectionView;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.allOrderTable.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kScreenWidth == 320 ? 110 : GetScaleWidth(110);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ADApplyAfterSaleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ADApplyAfterSaleCell"];
    if (self.allOrderTable.data.count > indexPath.row) {
        ADApplyAfterSaleModel *model = self.allOrderTable.data[indexPath.row];
        cell.model = model;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    if (self.allOrderTable.data.count > indexPath.row) {
    //        WLTransferAccountModel *model = self.accountTable.data[indexPath.row];
    //        NSLog(@"查看的信息model = %@",model.mj_keyValues);
    //        WLInformDetailCtrl *ctrl = [[WLInformDetailCtrl alloc] init];
    //        ctrl.accountModel = model;
    //        ctrl.messageDetail = NO;
    //        [self.navigationController pushViewController:ctrl animated:YES];
    //    }
}

- (void)baseTableVIew:(BaseTableView *)tableView refresh:(BOOL)flag {
    [self requestAllOrder:NO];
}

- (void)baseTableView:(BaseTableView *)tableView loadMore:(BOOL)flag {
    [self requestAllOrder:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
