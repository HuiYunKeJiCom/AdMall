//
//  ADReceivingAddressViewController.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/9.
//  Copyright © 2018年 Adel. All rights reserved.
//  收货地址

#import "ADReceivingAddressViewController.h"
//#import "ADCouponModel.h"
//#import "ADNotUsedCouponCell.h"
#import "ADOrderTopToolView.h"//自定义导航栏
#import "ADPaymentOrderBottonView.h"//自定义底部按钮
#import "ADReceivingAddressModel.h"
#import "ADReceivingAddressCell.h"

#import "YWAddressViewController.h"//新增地址
#import "YWAddressDataTool.h"


@interface ADReceivingAddressViewController ()<UITableViewDelegate,UITableViewDataSource,BaseTableViewDelegate>
@property (nonatomic, strong) BaseTableView         *goodsTable;
/* 顶部Nva */
@property (strong , nonatomic)ADOrderTopToolView *topToolView;
/* 底部View */
@property (strong , nonatomic)ADPaymentOrderBottonView *bottomView;

@end

@implementation ADReceivingAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kBACKGROUNDCOLOR;
    [self.view addSubview:self.goodsTable];
    [self setUpNavTopView];
    
    // 开启异步线程初始化数据
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 预加载地区信息到本地数据库（避免UI卡顿）
        [[YWAddressDataTool sharedManager] requestGetData];
    });
    
    [self setupCustomBottomView];
    [self makeConstraints];
    [self requestAllOrder:NO];
    
}

#pragma mark - 导航栏处理
- (void)setUpNavTopView
{
    _topToolView = [[ADOrderTopToolView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    _topToolView.hidden = NO;
    _topToolView.backgroundColor = [UIColor whiteColor];
    [_topToolView setTopTitleWithNSString:KLocalizableStr(@"管理收货地址")];
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

#pragma mark -- 自定义底部视图
- (void)setupCustomBottomView {
        WEAKSELF
    _bottomView = [[ADPaymentOrderBottonView alloc] initWithFrame:CGRectMake(0, kScreenHeight -  50, kScreenWidth, 50)];
    [_bottomView setTopTitleWithNSString:@"新增收货地址"];
    _bottomView.payBtnClickBlock = ^{
        NSLog(@"跳转到新增收货地址页面");
                //新增收货地址页面
        [weakSelf addBtnAction];
        //        ADPaymentOrderViewController *placeOrderVC = [[ADPaymentOrderViewController alloc] init];
        //        [weakSelf.navigationController pushViewController:placeOrderVC animated:YES];
    };
    
    [self.view addSubview:_bottomView];
}

#pragma mark - Constraints
- (void)makeConstraints {
    
    [self.goodsTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).with.offset(64);
        make.top.equalTo(self.view.mas_top).with.offset(64);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-50);
    }];
    
}

- (void)requestAllOrder:(BOOL)more {
    [self.goodsTable updateLoadState:more];
    
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
    
    NSArray *dataArr = @[@{@"id":@"123456",@"receiverName":@"王先生",@"phone":@"137 0000 0000",@"homeLabelName":@"家",@"address":@"广东省 深圳市 宝安区 松柏路南岗第二工业区"},@{@"id":@"123456",@"receiverName":@"王先生",@"phone":@"137 0000 0000",@"homeLabelName":@"公司",@"address":@"广东省 深圳市 宝安区 松柏路南岗第二工业区"},@{@"id":@"123456",@"receiverName":@"王先生",@"phone":@"137 0000 0000",@"homeLabelName":@"公司",@"address":@"广东省 深圳市 宝安区 松柏路南岗第二工业区"}];
    //    if ([result isKindOfClass:[NSDictionary class]]) {
    //        NSArray *dataInfo = result[@"data"];
    //        if ([dataInfo isKindOfClass:[NSArray class]]) {
    //            dataArr = dataInfo;
    //        }
    //    }
    
    [self.goodsTable.data removeAllObjects];
    for (NSDictionary *dic in dataArr) {
        
        ADReceivingAddressModel *model = [ADReceivingAddressModel mj_objectWithKeyValues:dic];
        [self.goodsTable.data addObject:model];
    }
    
    [self.goodsTable updatePage:more];
    //    self.allOrderTable.isLoadMore = dataArr.count >= k_RequestPageSize ? YES : NO;
    self.goodsTable.noDataView.hidden = self.goodsTable.data.count;
    
    [self.goodsTable reloadData];
}

- (BaseTableView *)goodsTable {
    if (!_goodsTable) {
        _goodsTable = [[BaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _goodsTable.delegate = self;
        _goodsTable.dataSource = self;
        _goodsTable.isLoadMore = YES;
        _goodsTable.isRefresh = YES;
        _goodsTable.delegateBase = self;
        [_goodsTable registerClass:[ADReceivingAddressCell class] forCellReuseIdentifier:@"ADReceivingAddressCell"];
        
    }
    return _goodsTable;
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
    return sectionView;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.goodsTable.data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kScreenWidth == 320 ? 100 : GetScaleWidth(100);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ADReceivingAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ADReceivingAddressCell"];
    if (self.goodsTable.data.count > indexPath.section) {
        ADReceivingAddressModel *model = self.goodsTable.data[indexPath.section];
//        NSLog(@"model.homeLabelName = %@",model.homeLabelName);
        cell.model = model;
    }
    cell.editBtnClickBlock = ^{
        [self editBtnAction];
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

#pragma mark - action
- (void)addBtnAction{
    
    YWAddressViewController *addressVC = [[YWAddressViewController alloc] init];
    // 保存后的地址回调
    addressVC.addressBlock = ^(YWAddressInfoModel *model) {
        NSLog(@"用户地址信息填写回调：");
        NSLog(@"姓名：%@", model.nameStr);
        NSLog(@"电话：%@", model.phoneStr);
        NSLog(@"地区：%@", model.areaAddress);
        NSLog(@"详细地址：%@", model.detailAddress);
        NSLog(@"是否设为默认：%@", model.isDefaultAddress ? @"是" : @"不是");
    };
    [self.navigationController pushViewController:addressVC animated:YES];
}

- (void)editBtnAction {
    
    // 这里传入需要编辑的地址信息，例如:
    YWAddressViewController *addressVC = [[YWAddressViewController alloc] init];
    YWAddressInfoModel *model = [YWAddressInfoModel alloc];
    model.phoneStr = @"18888888888";
    model.nameStr = @"袁伟";
    model.areaAddress = @"四川省成都市武侯区";
    model.detailAddress = @"下一站都市B座406";
    model.isDefaultAddress = NO; // 如果是默认地址则传入YES
    addressVC.model = model;
    // 保存后的地址回调
    addressVC.addressBlock = ^(YWAddressInfoModel *model) {
        NSLog(@"用户地址信息填写回调：");
        NSLog(@"姓名：%@", model.nameStr);
        NSLog(@"电话：%@", model.phoneStr);
        NSLog(@"地区：%@", model.areaAddress);
        NSLog(@"详细地址：%@", model.detailAddress);
        NSLog(@"是否设为默认：%@", model.isDefaultAddress ? @"是" : @"不是");
    };
    
    [self.navigationController pushViewController:addressVC animated:YES];
}


@end
