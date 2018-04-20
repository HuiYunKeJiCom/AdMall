//
//  ADAfterSaleServiceViewController.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/2.
//  Copyright © 2018年 Adel. All rights reserved.
//  我的售后服务

#import "ADAfterSaleServiceViewController.h"
#import "ADAfterSaleServiceViewModel.h"
#import "ADAfterSaleServiceViewCell.h"
#import "ADOrderTopToolView.h"
#import "ADAfterSaleServiceHeaderView.h"
#import "ADAfterSaleServiceDetailViewController.h"

@interface ADAfterSaleServiceViewController ()<UITableViewDelegate,UITableViewDataSource,BaseTableViewDelegate>
@property (nonatomic, strong) BaseTableView         *allOrderTable;
/* 顶部Nva */
@property (strong , nonatomic)ADOrderTopToolView *topToolView;
/** 当前页数 */
@property(nonatomic)NSInteger currentPage;
@end

@implementation ADAfterSaleServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kBACKGROUNDCOLOR;
    [self.view addSubview:self.allOrderTable];
    [self setUpNavTopView];
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
    _topToolView.backgroundColor = [UIColor whiteColor];
    [_topToolView setTopTitleWithNSString:KLocalizableStr(@"我的售后服务")];
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
        make.top.equalTo(self.view.mas_top).with.offset(64);
    }];
    
}

- (void)requestAllOrder:(BOOL)more {
    [self.allOrderTable updateLoadState:more];
    
    WEAKSELF
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [RequestTool getAfterServiceList:@{@"currentPage":[NSNumber numberWithInteger:self.currentPage]} withSuccessBlock:^(NSDictionary *result) {
        NSLog(@"售后服务列表result = %@",result);
        if([result[@"code"] integerValue] == 1){
            [hud hide:YES];
//            [weakSelf handleTransferResult:result more:more];
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
        NSLog(@"售后服务列表msg = %@",msg);
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
    
    NSArray *dataArr = @[@{@"id":@"123456",@"goodsName":@"ADEL爱迪尔4920B",@"goodsStyle":@"智能指纹锁"},@{@"id":@"123456",@"goodsName":@"ADEL爱迪尔4920B",@"goodsStyle":@"智能指纹锁"},@{@"id":@"123456",@"goodsName":@"ADEL爱迪尔4920B",@"goodsStyle":@"智能指纹锁"}];
    
    [self.allOrderTable.data removeAllObjects];
    for (NSDictionary *dic in dataArr) {

        ADAfterSaleServiceViewModel *model = [ADAfterSaleServiceViewModel mj_objectWithKeyValues:dic];
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
        
        [_allOrderTable registerClass:[ADAfterSaleServiceViewCell class] forCellReuseIdentifier:@"ADAfterSaleServiceViewCell"];
        
    }
    return _allOrderTable;
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.allOrderTable.data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kScreenWidth == 320 ? 120 : GetScaleWidth(120);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- ( UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    ADAfterSaleServiceHeaderView *headerView= [[ADAfterSaleServiceHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    ADAfterSaleServiceViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ADAfterSaleServiceViewCell"];
    if (self.allOrderTable.data.count > indexPath.row) {
        ADAfterSaleServiceViewModel *model = self.allOrderTable.data[indexPath.row];
        cell.model = model;
        cell.backgroundColor = [UIColor clearColor];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ADAfterSaleServiceDetailViewController *serviceDetail=[[ADAfterSaleServiceDetailViewController alloc]init];
    [self.navigationController pushViewController:serviceDetail animated:YES];
    
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
    self.currentPage += 1;
    [self requestAllOrder:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
