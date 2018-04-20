//
//  ADOrderClosedViewController.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/2/6.
//  Copyright © 2018年 Adel. All rights reserved.
//  我的订单-已关闭

#import "ADOrderClosedViewController.h"
#import "ADOrderDetailViewController.h"
#import "ADOrderCell.h"
#import "ADApplyAfterSaleViewController.h"//选择订单中的商品 申请售后
#import "ADPlaceOrderViewController.h"//下单页面

#import "ADGoodsOrderModel.h"//订单模型

@interface ADOrderClosedViewController ()<UITableViewDelegate,UITableViewDataSource,BaseTableViewDelegate>
@property (nonatomic, strong) BaseTableView         *allOrderTable;
/* 待收货数据数组 */
@property (strong , nonatomic)NSMutableArray<ADGoodsOrderModel *> *goodsOrderArray;
/** 当前页数 */
@property(nonatomic)NSInteger currentPage;
@end

@implementation ADOrderClosedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.allOrderTable];
    [self makeConstraints];
}

-(void)viewWillAppear:(BOOL)animated{
    self.currentPage = 1;
    [self requestAllOrder:NO];
}

#pragma mark - Constraints
- (void)makeConstraints {
    
    [self.allOrderTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
        //        make.top.equalTo(self.view.mas_bottom).with.offset(GetScaleWidth(10));
    }];
    
}

- (void)requestAllOrder:(BOOL)more {
    [self.allOrderTable updateLoadState:more];
    
    WEAKSELF
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [RequestTool getOrderList:@{@"orderStatus":@"50",@"currentPage":[NSNumber numberWithInteger:self.currentPage]} withSuccessBlock:^(NSDictionary *result) {
        NSLog(@"订单列表已完成result = %@",result);
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
        NSLog(@"订单列表已完成msg = %@",msg);
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
    
    NSArray *dataArr = result[@"data"][@"orderList"];
    
    [self.allOrderTable.data removeAllObjects];
    
    for (NSDictionary *dic in dataArr) {
        
        ADGoodsOrderModel *model = [ADGoodsOrderModel mj_objectWithKeyValues:dic];
        [self.allOrderTable.data addObject:model];
    }
    
    [self.allOrderTable updatePage:more];
    self.allOrderTable.noDataView.hidden = self.allOrderTable.data.count;
    
    [self.allOrderTable reloadData];
}

- (BaseTableView *)allOrderTable {
    if (!_allOrderTable) {
        _allOrderTable = [[BaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _allOrderTable.delegate = self;
        _allOrderTable.dataSource = self;
        _allOrderTable.isLoadMore = YES;
        _allOrderTable.isRefresh = YES;
        _allOrderTable.delegateBase = self;
        
        [_allOrderTable registerClass:[ADOrderCell class] forCellReuseIdentifier:@"ADOrderCell"];
        
    }
    return _allOrderTable;
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.allOrderTable.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, GetScaleWidth(10))];
    sectionView.backgroundColor = kBACKGROUNDCOLOR;
    return sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section == 0){
        return 1;
    }else{
        return GetScaleWidth(10);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kScreenWidth == 320 ? 120 : GetScaleWidth(120);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ADOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ADOrderCell"];
    if (self.allOrderTable.data.count > indexPath.section) {
        ADGoodsOrderModel *model = self.allOrderTable.data[indexPath.section];
        cell.model = model;
        cell.detailBtnClickBlock = ^{
            //订单详情
            ADOrderDetailViewController *orderDetailVC = [[ADOrderDetailViewController alloc]init];
            [orderDetailVC loadDataWithOrderID:model.order_id];
            [self.navigationController pushViewController:orderDetailVC animated:YES];
        };
        cell.afterSaleBtnClickBlock = ^{
            //申请售后
            ADApplyAfterSaleViewController *applyAfterSaleVC = [[ADApplyAfterSaleViewController alloc]init];
            applyAfterSaleVC.orderID = model.order_id;
            [self.navigationController pushViewController:applyAfterSaleVC animated:YES];
        };
        cell.toPayBtnClickBlock = ^{
            //支付页面
            //            ADPlaceOrderViewController *placeOrderVC = [[ADPlaceOrderViewController alloc] init];
            //            [self.navigationController pushViewController:placeOrderVC animated:YES];
        };
    };
    
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
