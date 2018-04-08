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
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [RequestTool getAddress:nil withSuccessBlock:^(NSDictionary *result) {
        NSLog(@"获取收货地址result = %@",result);
        if([result[@"code"] integerValue] == 1){
            NSLog(@"获取收货地址成功");
            [hud hide:YES];
            [weakSelf handleTransferResult:result more:more];
        }else if([result[@"code"] integerValue] == -2){
            hud.detailsLabelText = @"登录失效";
            hud.mode = MBProgressHUDModeText;
            [hud hide:YES afterDelay:1.0];
        }else if([result[@"code"] integerValue] == -1){
            hud.detailsLabelText = @"未登录";
            hud.mode = MBProgressHUDModeText;
            [hud hide:YES afterDelay:1.0];
        }else if([result[@"code"] integerValue] == 0){
            hud.detailsLabelText = @"失败";
            hud.mode = MBProgressHUDModeText;
            [hud hide:YES afterDelay:1.0];
        }else if([result[@"code"] integerValue] == 2){
            hud.detailsLabelText = @"无返回数据";
            hud.mode = MBProgressHUDModeText;
            [hud hide:YES afterDelay:1.0];
        }
    } withFailBlock:^(NSString *msg) {
        hud.detailsLabelText = msg;
        hud.mode = MBProgressHUDModeText;
        [hud hide:YES afterDelay:1.0];
    }];

}

- (void)handleTransferResult:(NSDictionary *)result more:(BOOL)more{

    NSArray *dataArr = result[@"data"][@"addressList"];
    [self.goodsTable.data removeAllObjects];
    for (NSDictionary *dic in dataArr) {
        ADReceivingAddressModel *model = [ADReceivingAddressModel mj_objectWithKeyValues:dic];
        NSLog(@"model.address_Id = %@",model.address_id);
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
        cell.setDefaultBtnClickBlock = ^{
            [self setDefaultAddressWithID:model.address_id];
        };
        cell.deleteBtnClickBlock = ^{
            [self deleteAddressWithID:model.address_id];
        };
        cell.editBtnClickBlock = ^{
            [self editBtnAction:model];
        };
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

#pragma mark - action
- (void)addBtnAction{
    
    YWAddressViewController *addressVC = [[YWAddressViewController alloc] init];
//    // 保存后的地址回调
//    addressVC.addressBlock = ^(YWAddressInfoModel *model) {
//        NSLog(@"用户地址信息填写回调：");
//    };
    [self.navigationController pushViewController:addressVC animated:YES];
}

- (void)editBtnAction:(ADReceivingAddressModel *)addressModel {
    
    // 这里传入需要编辑的地址信息，例如:
    YWAddressViewController *addressVC = [[YWAddressViewController alloc] init];
    YWAddressInfoModel *model = [YWAddressInfoModel alloc];
    model.mobile = addressModel.mobile;
    model.trueName = addressModel.trueName;
    model.areaId = addressModel.area_id;
    model.detailAddress = addressModel.detail_address;
    model.addressId = addressModel.address_id;
    model.isDefault = 0; // 如果是默认地址则传入YES
    addressVC.model = model;
    // 保存后的地址回调
//    addressVC.addressBlock = ^(YWAddressInfoModel *model) {
//        NSLog(@"用户地址信息填写回调：");
//    };
    
    [self.navigationController pushViewController:addressVC animated:YES];
}

//设置默认收货地址
-(void)setDefaultAddressWithID:(NSString *)addressId{
    NSLog(@"addressId = %@",addressId);
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [RequestTool setDefaultAddress:@{@"addressId":addressId} withSuccessBlock:^(NSDictionary *result) {
        NSLog(@"设置默认收货地址result = %@",result);
        if([result[@"code"] integerValue] == 1){
            NSLog(@"设置默认收货地址成功");
            hud.hidden = YES;
            [self.goodsTable reloadData];
            [self requestAllOrder:NO];
        }else if([result[@"code"] integerValue] == -2){
            hud.detailsLabelText = @"登录失效";
            hud.mode = MBProgressHUDModeText;
            [hud hide:YES afterDelay:1.0];
        }else if([result[@"code"] integerValue] == -1){
            hud.detailsLabelText = @"未登录";
            hud.mode = MBProgressHUDModeText;
            [hud hide:YES afterDelay:1.0];
        }else if([result[@"code"] integerValue] == 0){
            hud.detailsLabelText = @"失败";
            hud.mode = MBProgressHUDModeText;
            [hud hide:YES afterDelay:1.0];
        }
    } withFailBlock:^(NSString *msg) {
        hud.detailsLabelText = msg;
        hud.mode = MBProgressHUDModeText;
        [hud hide:YES afterDelay:1.0];
    }];
}

//设置默认收货地址
-(void)deleteAddressWithID:(NSString *)addressId{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [RequestTool delAddress:@{@"addressId":addressId} withSuccessBlock:^(NSDictionary *result) {
        NSLog(@"删除收货地址result = %@",result);
        if([result[@"code"] integerValue] == 1){
            NSLog(@"删除收货地址成功");
            hud.hidden = YES;
            [self.goodsTable reloadData];
            [self requestAllOrder:NO];
        }else if([result[@"code"] integerValue] == -2){
            hud.detailsLabelText = @"登录失效";
            hud.mode = MBProgressHUDModeText;
            [hud hide:YES afterDelay:1.0];
        }else if([result[@"code"] integerValue] == -1){
            hud.detailsLabelText = @"未登录";
            hud.mode = MBProgressHUDModeText;
            [hud hide:YES afterDelay:1.0];
        }else if([result[@"code"] integerValue] == 0){
            hud.detailsLabelText = @"失败";
            hud.mode = MBProgressHUDModeText;
            [hud hide:YES afterDelay:1.0];
        }
    } withFailBlock:^(NSString *msg) {
        hud.detailsLabelText = msg;
        hud.mode = MBProgressHUDModeText;
        [hud hide:YES afterDelay:1.0];
    }];
}

@end
