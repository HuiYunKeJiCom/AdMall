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
#import "ADAfterSaleServiceDetailViewController.h"//售后服务单详情

@interface ADApplyAfterSaleViewController ()<UITableViewDelegate,UITableViewDataSource,BaseTableViewDelegate>
@property (nonatomic, strong) BaseTableView         *allOrderTable;
/* 顶部Nva */
@property (strong , nonatomic)ADOrderTopToolView *topToolView;
/** 当前页数 */
@property(nonatomic)NSInteger currentPage;
@end

@implementation ADApplyAfterSaleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kBACKGROUNDCOLOR;
    [self setUpNavTopView];
    [self.view addSubview:self.allOrderTable];
    [self makeConstraints];
}

-(void)viewWillAppear:(BOOL)animated{
    self.currentPage = 1;
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
    NSLog(@"获取订单售后商品self.orderID = %@",self.orderID);
    WEAKSELF
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [RequestTool getOrderGoodsList:@{@"orderId":self.orderID,@"currentPage":[NSNumber numberWithInteger:self.currentPage]} withSuccessBlock:^(NSDictionary *result) {
        NSLog(@"获取订单售后商品result = %@",result);
        if([result[@"code"] integerValue] == 1){
            [hud hide:YES];
            [weakSelf handleTransferResult:result more:more];
        }else if([result[@"code"] integerValue] == -2){
            [self cutCurrentPag];
            hud.detailsLabelText = @"登录失效";
            hud.mode = MBProgressHUDModeText;
            [hud hide:YES afterDelay:1.0];
        }else if([result[@"code"] integerValue] == -1){
            [self cutCurrentPag];
            hud.detailsLabelText = @"未登录";
            hud.mode = MBProgressHUDModeText;
            [hud hide:YES afterDelay:1.0];
        }else if([result[@"code"] integerValue] == 0){
            [self cutCurrentPag];
            hud.detailsLabelText = @"失败";
            hud.mode = MBProgressHUDModeText;
            [hud hide:YES afterDelay:1.0];
        }else if([result[@"code"] integerValue] == 2){
            [self cutCurrentPag];
            hud.detailsLabelText = @"无返回数据";
            hud.mode = MBProgressHUDModeText;
            [hud hide:YES afterDelay:1.0];
            [self.allOrderTable reloadData];
        }
    } withFailBlock:^(NSString *msg) {
        [self cutCurrentPag];
        NSLog(@"获取订单售后商品msg = %@",msg);
        hud.detailsLabelText = msg;
        hud.mode = MBProgressHUDModeText;
        [hud hide:YES afterDelay:1.0];
    }];
}

-(void)cutCurrentPag{
    if(self.currentPage != 1){
        self.currentPage -= 1;
    }
}

- (void)handleTransferResult:(NSDictionary *)result more:(BOOL)more{
    
    NSArray *dataArr = result[@"data"][@"resultList"];
    
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
        cell.applyAfterSaleBtnClickBlock = ^{
            //申请售后
            ADAfterSaleServiceDetailViewController *ASSDetailVC = [[ADAfterSaleServiceDetailViewController alloc]init];
            ASSDetailVC.model = model;
            [self.navigationController pushViewController:ASSDetailVC animated:YES];
        };
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (void)baseTableVIew:(BaseTableView *)tableView refresh:(BOOL)flag {
    [self requestAllOrder:NO];
}

- (void)baseTableView:(BaseTableView *)tableView loadMore:(BOOL)flag {
    self.currentPage += 1;
    [self requestAllOrder:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
