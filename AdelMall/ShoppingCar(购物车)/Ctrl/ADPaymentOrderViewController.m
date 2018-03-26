//
//  ADPaymentOrderViewController.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/5.
//  Copyright © 2018年 Adel. All rights reserved.
//  购物车-下单页面-支付订单

#import "ADPaymentOrderViewController.h"
#import "ADOrderTopToolView.h"
#import "ADPaymentOrderView.h"
#import "ADPaymentOrderBottonView.h"
#import "ADPaymentViewCell.h"
#import "ADPaymentSuccessViewController.h"//支付成功
#import "ADPaymentGoodsModel.h"
#import "ADPaymentGoodsCell.h"

typedef NS_ENUM(NSInteger, TDMainTableViewType) {
    TDMainTableViewTypePaymentTable, // 支付方式的tableView
    TDMainTableViewTypeGoodsTable, // 商品的tableView
};

@interface ADPaymentOrderViewController ()<UITableViewDelegate,UITableViewDataSource,BaseTableViewDelegate>
/* 顶部Nva */
@property (strong , nonatomic)ADOrderTopToolView *topToolView;
/* 内容View */
@property (strong , nonatomic)ADPaymentOrderView *contentView;
/* 支付方式 */
@property (nonatomic, strong) BaseTableView         *paymentTable;
/* 商品tableview */
@property (nonatomic, strong) BaseTableView         *goodsTable;
/* 底部View */
@property (strong , nonatomic)ADPaymentOrderBottonView *bottomView;
@end



@implementation ADPaymentOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self setUpNavTopView];
    [self setUpContentView];
    [self setupCustomBottomView];
    [self.view addSubview:self.paymentTable];
    [self.view addSubview:self.goodsTable];
    [self requestAllOrder:NO];
    
    [self makeConstraints];
}

#pragma mark - 导航栏处理
- (void)setUpNavTopView
{
    _topToolView = [[ADOrderTopToolView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    _topToolView.hidden = NO;
    _topToolView.backgroundColor = [UIColor whiteColor];
    [_topToolView setTopTitleWithNSString:KLocalizableStr(@"购物车")];
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
    WEAKSELF
    
    [self.paymentTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left);
        make.top.equalTo(weakSelf.contentView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 120));
    }];
    
    [self.goodsTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.top.equalTo(weakSelf.view.mas_top).with.offset(200);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth-130, 130));
    }];
    
}

#pragma mark - contentView
- (void)setUpContentView
{
    _contentView = [[ADPaymentOrderView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 380)];
//    _contentView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_contentView];
    
}

#pragma mark -- 自定义底部视图
- (void)setupCustomBottomView {
    WEAKSELF
    _bottomView = [[ADPaymentOrderBottonView alloc] initWithFrame:CGRectMake(0, kScreenHeight -  50, kScreenWidth, 50)];
    [_bottomView setTopTitleWithNSString:@"支付"];
    _bottomView.payBtnClickBlock = ^{
        //跳转到支付成功页面
        ADPaymentSuccessViewController *paymentSuccessVC = [[ADPaymentSuccessViewController alloc] init];
        [weakSelf.navigationController pushViewController:paymentSuccessVC animated:YES];
    };
    
    [self.view addSubview:_bottomView];
}

- (void)requestAllOrder:(BOOL)more {
    [self.goodsTable updateLoadState:more];
    
    WEAKSELF
 
    [weakSelf handleTransferResult:nil more:more];
    //                                   }];
    
}

- (void)handleTransferResult:(NSDictionary *)result more:(BOOL)more{
    
    NSArray *dataArr = @[@{@"id":@"123456",@"goodsName":@"ADEL爱迪尔4920B",@"type":@"智能指纹锁",@"detail1":@"三合一(咖啡铜色)",@"detail2":@"左侧开"}];

    [self.goodsTable.data removeAllObjects];
    for (NSDictionary *dic in dataArr) {
        ADPaymentGoodsModel *model = [ADPaymentGoodsModel mj_objectWithKeyValues:dic];
        [self.goodsTable.data addObject:model];
    }
    
    [self.goodsTable updatePage:more];
    //    self.allOrderTable.isLoadMore = dataArr.count >= k_RequestPageSize ? YES : NO;
    self.goodsTable.noDataView.hidden = self.goodsTable.data.count;
    
    [self.goodsTable reloadData];
}


- (BaseTableView *)paymentTable {
    if (!_paymentTable) {
        _paymentTable = [[BaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _paymentTable.delegate = self;
        _paymentTable.dataSource = self;
        _paymentTable.isLoadMore = NO;
        _paymentTable.isRefresh = NO;
        _paymentTable.tag = TDMainTableViewTypePaymentTable;
        _paymentTable.scrollEnabled = NO;
        _paymentTable.delegateBase = self;
        _paymentTable.backgroundColor = [UIColor whiteColor];
        [_paymentTable registerClass:[ADPaymentViewCell class] forCellReuseIdentifier:@"ADPaymentViewCell"];
        
    }
    return _paymentTable;
}

- (BaseTableView *)goodsTable {
    if (!_goodsTable) {
        _goodsTable = [[BaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _goodsTable.delegate = self;
        _goodsTable.dataSource = self;
        _goodsTable.isLoadMore = NO;
        _goodsTable.isRefresh = NO;
        _goodsTable.tag = TDMainTableViewTypeGoodsTable;
        _goodsTable.scrollEnabled = NO;
        _goodsTable.delegateBase = self;
//        _goodsTable.backgroundColor = [UIColor greenColor];
        [_goodsTable registerClass:[ADPaymentGoodsCell class] forCellReuseIdentifier:@"ADPaymentGoodsCell"];
        
    }
    return _goodsTable;
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(tableView.tag == TDMainTableViewTypePaymentTable){
        return 2;
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return kScreenWidth == 320 ? 40 : GetScaleWidth(40);
    if(tableView.tag == TDMainTableViewTypePaymentTable){
        return 40;
    }else{
        return 130;
    }
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = nil;
    if(tableView.tag == TDMainTableViewTypePaymentTable){
    headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
//    headerView.backgroundColor = [UIColor redColor];
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 10,kScreenWidth, 20)];
    titleLab.text = @"请选择支付方式";
//    titleLab.backgroundColor = [UIColor greenColor];
    titleLab.font = [UIFont systemFontOfSize:14];
    titleLab.textColor = [UIColor blackColor];
    titleLab.textAlignment = NSTextAlignmentLeft;
    [headerView addSubview:titleLab];
    headerView.backgroundColor = [UIColor whiteColor];
    }
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return kScreenWidth == 320 ? 40 : GetScaleWidth(40);
    if(tableView.tag == TDMainTableViewTypePaymentTable){
        return 40;
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(tableView.tag == TDMainTableViewTypePaymentTable){
    ADPaymentViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ADPaymentViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(indexPath.row == 0){
        [cell setUpPaymentWith:@"微信支付"];
    }else{
        [cell setUpPaymentWith:@"支付宝支付"];
    }
    return cell;
    }else{
        ADPaymentGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ADPaymentGoodsCell"];
        if (self.goodsTable.data.count > indexPath.row) {
            ADPaymentGoodsModel *model = self.goodsTable.data[indexPath.row];
            cell.model = model;
        }
        cell.backgroundColor = [UIColor redColor];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)baseTableVIew:(BaseTableView *)tableView refresh:(BOOL)flag {
    [self requestAllOrder:NO];
}

- (void)baseTableView:(BaseTableView *)tableView loadMore:(BOOL)flag {
    [self requestAllOrder:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
