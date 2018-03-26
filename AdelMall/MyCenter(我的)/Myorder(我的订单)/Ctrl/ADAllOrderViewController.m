//
//  ADAllOrderViewController.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/2/6.
//  Copyright © 2018年 Adel. All rights reserved.
//  我的订单-全部

#import "ADAllOrderViewController.h"
#import "ADOrderDetailViewController.h"
#import "ADOrderModel.h"
#import "ADOrderCell.h"
#import "ADApplyAfterSaleViewController.h"//选择订单中的商品 申请售后
#import "ADPlaceOrderViewController.h"//下单页面

@interface ADAllOrderViewController ()<UITableViewDelegate,UITableViewDataSource,BaseTableViewDelegate>
@property (nonatomic, strong) BaseTableView         *allOrderTable;

@end

@implementation ADAllOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.allOrderTable];
    [self makeConstraints];
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

    NSArray *dataArr = @[@{@"id":@"123456",@"orderNo":@"1314520",@"goodsName":@"商品名AA-01",@"date":@"2017-08-09 12:03",@"price":@"1968",@"state":@"未支付"}];
//    if ([result isKindOfClass:[NSDictionary class]]) {
//        NSArray *dataInfo = result[@"data"];
//        if ([dataInfo isKindOfClass:[NSArray class]]) {
//            dataArr = dataInfo;
//        }
//    }

    [self.allOrderTable.data removeAllObjects];
    for (NSDictionary *dic in dataArr) {
    
        ADOrderModel *model = [ADOrderModel mj_objectWithKeyValues:dic];
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
        
        [_allOrderTable registerClass:[ADOrderCell class] forCellReuseIdentifier:@"ADOrderCell"];
        
    }
    return _allOrderTable;
}

#pragma mark - UITableViewDelegate

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 30.0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allOrderTable.data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kScreenWidth == 320 ? 120 : GetScaleWidth(120);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ADOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ADOrderCell"];
    if (self.allOrderTable.data.count > indexPath.row) {
        ADOrderModel *model = self.allOrderTable.data[indexPath.row];
        cell.model = model;
        cell.detailBtnClickBlock = ^{
            //订单详情
            ADOrderDetailViewController *orderDetailVC = [[ADOrderDetailViewController alloc]init];
            [self.navigationController pushViewController:orderDetailVC animated:YES];
        };
        cell.afterSaleBtnClickBlock = ^{
            //申请售后
            ADApplyAfterSaleViewController *applyAfterSaleVC = [[ADApplyAfterSaleViewController alloc]init];
            [self.navigationController pushViewController:applyAfterSaleVC animated:YES];
        };
        cell.toPayBtnClickBlock = ^{
            //下单页面
            ADPlaceOrderViewController *placeOrderVC = [[ADPlaceOrderViewController alloc] init];
            [self.navigationController pushViewController:placeOrderVC animated:YES];
        };
    };
    
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
