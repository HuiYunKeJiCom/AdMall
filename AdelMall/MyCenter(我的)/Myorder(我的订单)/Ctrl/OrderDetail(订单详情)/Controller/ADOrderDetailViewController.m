//
//  ADOrderDetailViewController.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/2/6.
//  Copyright © 2018年 Adel. All rights reserved.
//  订单详情

#import "ADOrderDetailViewController.h"
#import "ADOrderTopToolView.h"
#import "DCHomeRefreshGifHeader.h"
#import "ADOrderStateView.h"
#import "ADOrderBasicViewCell.h"
#import "ADInvoiceViewCell.h"
#import "ADDeliveryViewCell.h"
#import "ADPolicyViewCell.h"
#import "ADOrderListViewCell.h"

#import "ADOrderModel.h"//商品数据模型
#import "ADOrderBasicModel.h"//订单信息模型

@interface ADOrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource,BaseTableViewDelegate>
@property (nonatomic, strong) BaseTableView         *allOrderTable;
/* 商品数据数组 */
@property (strong , nonatomic)NSMutableArray<ADOrderModel *> *goodsOrderArray;
/** 订单模型 */
@property(nonatomic,strong)ADOrderBasicModel *orderBasicModel;
/* 顶部Nva */
@property (strong , nonatomic)ADOrderTopToolView *topToolView;
/** 订单号 */
@property(nonatomic,strong)NSString *orderID;
/** 去支付 按钮 */
@property(nonatomic,strong)UIButton *toPayButton;
@end

static NSString *const ADOrderStateViewID = @"ADOrderStateView";
static NSString *const ADOrderBasicViewCellID = @"ADOrderBasicViewCell";
static NSString *const ADInvoiceViewCellID = @"ADInvoiceViewCell";
static NSString *const ADDeliveryViewCellID = @"ADDeliveryViewCell";
static NSString *const ADPolicyViewCellID = @"ADPolicyViewCell";
static NSString *const ADOrderListViewCellID = @"ADOrderListViewCell";

@implementation ADOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = k_UIColorFromRGB(0xffffff);
    [self.view addSubview:self.allOrderTable];
    [self makeConstraints];
    
    [self setUpBase];
    [self setUpNavTopView];
    
}

#pragma mark - 导航栏处理
- (void)setUpNavTopView
{
    _topToolView = [[ADOrderTopToolView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    _topToolView.hidden = NO;
    [_topToolView setTopTitleWithNSString:KLocalizableStr(@"订单详情")];
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
    
//    WEAKSELF
    [self.allOrderTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).with.offset(65);
    }];
    
}

#pragma mark - LazyLoad

-(void)loadDataWithOrderID:(NSString *)orderID{
    self.orderID = orderID;
    WEAKSELF
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [RequestTool getOrderDetail:@{@"orderId":self.orderID} withSuccessBlock:^(NSDictionary *result) {
        NSLog(@"订单详情result = %@",result);
        if([result[@"code"] integerValue] == 1){
            [hud hide:YES];
            [weakSelf handleTransferResult:result more:NO];
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
        NSLog(@"订单详情msg = %@",msg);
        hud.detailsLabelText = msg;
        hud.mode = MBProgressHUDModeText;
        [hud hide:YES afterDelay:1.0];
    }];
}

- (void)requestAllOrder:(BOOL)more {
    [self.allOrderTable updateLoadState:more];
    
    WEAKSELF
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [RequestTool getOrderDetail:@{@"orderId":self.orderID} withSuccessBlock:^(NSDictionary *result) {
        NSLog(@"订单详情result = %@",result);
        if([result[@"code"] integerValue] == 1){
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
        NSLog(@"订单详情msg = %@",msg);
        hud.detailsLabelText = msg;
        hud.mode = MBProgressHUDModeText;
        [hud hide:YES afterDelay:1.0];
    }];
}

- (void)handleTransferResult:(NSDictionary *)result more:(BOOL)more{
    
    self.orderBasicModel = [ADOrderBasicModel mj_objectWithKeyValues:result[@"data"]];
    
    switch ([self.orderBasicModel.order_status intValue]) {
        case 0:
            break;
        case 10:
            [self setUpToPayButton];
            break;
        case 20:
            break;
        case 30:
            break;
        case 40:
            break;
        case 50:
            break;
        default:
            break;
    }
    
    NSArray *dataArr = result[@"data"][@"goodsList"];
    
    [self.goodsOrderArray removeAllObjects];
    
    for (NSDictionary *dic in dataArr) {
        
        ADOrderModel *model = [ADOrderModel mj_objectWithKeyValues:dic];
        [self.goodsOrderArray addObject:model];
    }
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
        
        //注册
//        [_allOrderTable registerClass:[ADOrderBasicViewCell class] forCellReuseIdentifier:@"ADOrderBasicViewCell"];
//        [_allOrderTable registerClass:[ADInvoiceViewCell class] forCellReuseIdentifier:@"ADInvoiceViewCell"];
        
        [_allOrderTable registerClass:[ADOrderBasicViewCell class] forCellReuseIdentifier:ADOrderBasicViewCellID];
        [_allOrderTable registerClass:[ADInvoiceViewCell class] forCellReuseIdentifier:ADInvoiceViewCellID];
        [_allOrderTable registerClass:[ADDeliveryViewCell class] forCellReuseIdentifier:ADDeliveryViewCellID];
        [_allOrderTable registerClass:[ADPolicyViewCell class] forCellReuseIdentifier:ADPolicyViewCellID];
        [_allOrderTable registerClass:[ADOrderListViewCell class] forCellReuseIdentifier:ADOrderListViewCellID];
        
//        [_allOrderTable registerClass:[ADOrderStateView @"ADOrderStateView"] forHeaderFooterViewReuseIdentifier:ADOrderStateViewID];
        
    }
    return _allOrderTable;
}


#pragma mark - initialize
- (void)setUpBase
{
    self.allOrderTable.backgroundColor = kBACKGROUNDCOLOR;
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

#pragma mark - 去支付
- (void)setUpToPayButton
{
//    NSArray *imagesNor = @[@"tabr_08gouwuche"];
    //    NSArray *imagesSel = @[@"tabr_08gouwuche"];
    CGFloat buttonW = kScreenWidth;
    CGFloat buttonH = 50;
    CGFloat buttonY = kScreenHeight - buttonH;
    
//    for (NSInteger i = 0; i < imagesNor.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor redColor];
//        button.tag = i;
//        [button addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//        CGFloat buttonX = (buttonW * i);
        [button setTitle:@"去支付" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.frame = CGRectMake(0, buttonY, buttonW, buttonH);
        button.layer.borderWidth=0.5;
        button.layer.borderColor=[UIColor grayColor].CGColor;
        self.toPayButton = button;
        [self.view addSubview:self.toPayButton];
//    }
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 0){
        ADOrderStateView *sectionView = [[ADOrderStateView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        sectionView.orderBasicModel = self.orderBasicModel;
        __weak typeof(sectionView) sectionview = sectionView;
        sectionView.cancelClickBlock = ^{
            //取消订单
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [RequestTool cancelOrder:@{@"orderId":self.orderID} withSuccessBlock:^(NSDictionary *result) {
                NSLog(@"取消订单result = %@",result);
                if([result[@"code"] integerValue] == 1){
                    hud.detailsLabelText = @"订单取消成功";
                    sectionview.cancelOrderBtn.backgroundColor = [UIColor lightGrayColor];
                    sectionview.cancelOrderBtn.userInteractionEnabled = NO;
                    [sectionview.cancelOrderBtn setTitle:@"已取消" forState:UIControlStateNormal];
                    self.toPayButton.alpha = 0.0;
                    hud.mode = MBProgressHUDModeText;
                    [hud hide:YES afterDelay:1.0];
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
                NSLog(@"取消订单msg = %@",msg);
                hud.detailsLabelText = msg;
                hud.mode = MBProgressHUDModeText;
                [hud hide:YES afterDelay:1.0];
            }];
        };
        sectionView.backgroundColor = kBACKGROUNDCOLOR;
        return sectionView;
    }else{
        UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, GetScaleWidth(5))];
        sectionView.backgroundColor = kBACKGROUNDCOLOR;
        return sectionView;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section == 0){
        return 40;
    }else{
        return GetScaleWidth(5);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {//基本信息
        return 150;
    }
    if (indexPath.section == 1) {//发票信息
        return 90;
    }
    if (indexPath.section == 2) {//发货信息
        return 110;
    }
    if (indexPath.section == 3) {//保险单信息
        return 40;
    }
    if (indexPath.section == 4) {//商品清单
        return 50+109*2+110;
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseTableCell *gridcell = nil;
    if (indexPath.section == 0) {
        ADOrderBasicViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ADOrderBasicViewCellID forIndexPath:indexPath];
        //            cell.gridItem = _gridItem[indexPath.row];
        cell.orderBasicModel = self.orderBasicModel;
        cell.backgroundColor = [UIColor whiteColor];
        gridcell = cell;
    
    }else if (indexPath.section == 1) {//发票信息
        ADInvoiceViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ADInvoiceViewCellID];
        //            cell.gridItem = _gridItem[indexPath.row];
        cell.orderBasicModel = self.orderBasicModel;
        cell.backgroundColor = [UIColor whiteColor];
        gridcell = cell;
    }else if (indexPath.section == 2) {//发货信息
        ADDeliveryViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ADDeliveryViewCellID forIndexPath:indexPath];
        //            cell.gridItem = _gridItem[indexPath.row];
        cell.orderBasicModel = self.orderBasicModel;
        cell.backgroundColor = [UIColor whiteColor];
        gridcell = cell;
    }else if (indexPath.section == 3) {//保险单信息
        ADPolicyViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ADPolicyViewCellID forIndexPath:indexPath];
        //            cell.gridItem = _gridItem[indexPath.row];
        cell.backgroundColor = [UIColor whiteColor];
        gridcell = cell;
    }else if (indexPath.section == 4) {//商品清单
        ADOrderListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ADOrderListViewCellID forIndexPath:indexPath];
        //            cell.gridItem = _gridItem[indexPath.row];
        cell.orderBasicModel = self.orderBasicModel;
        cell.goodsOrderArray = self.goodsOrderArray;
        cell.backgroundColor = [UIColor whiteColor];
        gridcell = cell;
    }
    return gridcell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
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
