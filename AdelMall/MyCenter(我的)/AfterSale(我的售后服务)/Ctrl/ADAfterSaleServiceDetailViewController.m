//
//  ADAfterSaleServiceDetailViewController.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/2.
//  Copyright © 2018年 Adel. All rights reserved.
//  售后服务单详情

#import "ADAfterSaleServiceDetailViewController.h"
#import "ADOrderTopToolView.h"
#import "DCHomeRefreshGifHeader.h"
#import "ADServiceStateView.h"
#import "ADServiceFlowViewCell.h" //售后流程
#import "ADOrderBasicViewCell.h"  //订单基本信息
#import "ADExpressInformationViewCell.h"//快递单信息
#import "ADShipAddressViewCell.h"//发货地址
#import "ADApplicationRecordViewCell.h"//售后申请记录
#import "ADApplyAfterSaleModel.h"
#import "ADAfterSaleServiceViewModel.h"

@interface ADAfterSaleServiceDetailViewController ()<UITableViewDelegate,UITableViewDataSource,BaseTableViewDelegate>
@property (nonatomic, strong) BaseTableView         *allOrderTable;

/* 顶部Nva */
@property (strong , nonatomic)ADOrderTopToolView *topToolView;
/** 售后服务详情模型 */
@property(nonatomic,strong)ADAfterSaleServiceViewModel *serviceViewModel;
@end

static NSString *const ADServiceStateViewID = @"ADServiceStateView";
static NSString *const ADServiceFlowViewCellID = @"ADServiceFlowViewCell";
static NSString *const ADOrderBasicViewCellID = @"ADOrderBasicViewCell";
static NSString *const ADExpressInformationViewCellID = @"ADExpressInformationViewCell";
static NSString *const ADShipAddressViewCellID = @"ADShipAddressViewCell";
static NSString *const ADApplicationRecordViewCellID = @"ADApplicationRecordViewCell";


@implementation ADAfterSaleServiceDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = k_UIColorFromRGB(0xffffff);
    [self.view addSubview:self.allOrderTable];
    [self setUpBase];
    [self setUpNavTopView];
    [self makeConstraints];
}

- (void)requestAllOrder:(BOOL)more {
    
    NSMutableDictionary *paraDict = [NSMutableDictionary dictionary];
    [paraDict setValue:self.model.goods_id forKey:@"goodsId"];
    if(self.model.apply_no){
        [paraDict setValue:self.model.apply_no forKey:@"applyNo"];
    }
    NSLog(@"售后服务订单详情paraDict = %@",paraDict);
    [self.allOrderTable updateLoadState:more];
    WEAKSELF
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [RequestTool getAfterSalesDetail:paraDict withSuccessBlock:^(NSDictionary *result) {
        NSLog(@"售后服务订单详情result = %@",result);
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
            [self.allOrderTable reloadData];
        }
        
    } withFailBlock:^(NSString *msg) {
        NSLog(@"售后服务订单详情msg = %@",msg);
        hud.detailsLabelText = msg;
        hud.mode = MBProgressHUDModeText;
        [hud hide:YES afterDelay:1.0];
    }];
}

- (void)handleTransferResult:(NSDictionary *)result more:(BOOL)more{
    
    NSDictionary *dataArr = result[@"data"];
    self.serviceViewModel = [ADAfterSaleServiceViewModel mj_objectWithKeyValues:dataArr];
    [self.allOrderTable reloadData];
}


#pragma mark - 导航栏处理
- (void)setUpNavTopView
{
    _topToolView = [[ADOrderTopToolView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    _topToolView.hidden = NO;
    [_topToolView setTopTitleWithNSString:KLocalizableStr(@"售后服务单详情")];
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

- (BaseTableView *)allOrderTable {
    if (!_allOrderTable) {
        _allOrderTable = [[BaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _allOrderTable.delegate = self;
        _allOrderTable.dataSource = self;
        _allOrderTable.isLoadMore = YES;
        _allOrderTable.isRefresh = YES;
        _allOrderTable.delegateBase = self;
        
        //注册
        [_allOrderTable registerClass:[ADOrderBasicViewCell class] forCellReuseIdentifier:ADOrderBasicViewCellID];
        
        //注册
        [_allOrderTable registerClass:[ADServiceFlowViewCell class] forCellReuseIdentifier:ADServiceFlowViewCellID];
        [_allOrderTable registerClass:[ADOrderBasicViewCell class] forCellReuseIdentifier:ADOrderBasicViewCellID];
        [_allOrderTable registerClass:[ADExpressInformationViewCell class] forCellReuseIdentifier:ADExpressInformationViewCellID];
        [_allOrderTable registerClass:[ADShipAddressViewCell class] forCellReuseIdentifier:ADShipAddressViewCellID];
        [_allOrderTable registerClass:[ADApplicationRecordViewCell class] forCellReuseIdentifier:ADApplicationRecordViewCellID];
    }
    return _allOrderTable;
}

#pragma mark - 刷新
- (void)setUpRecData
{
//    WEAKSELF
    if (@available(iOS 10.0, *)) {
        UIImpactFeedbackGenerator *generator = [[UIImpactFeedbackGenerator alloc] initWithStyle: UIImpactFeedbackStyleHeavy];
        [generator prepare];
        [generator impactOccurred];
    }
}

#pragma mark - initialize
- (void)setUpBase
{
    self.allOrderTable.backgroundColor = kBACKGROUNDCOLOR;
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *gridcell = nil;
    if (indexPath.section == 0) {
        ADServiceFlowViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ADServiceFlowViewCellID];
        //            cell.gridItem = _gridItem[indexPath.row];
        gridcell = cell;

    }else if (indexPath.section == 1) {//订单基本信息
        ADOrderBasicViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ADOrderBasicViewCellID];
        //            cell.gridItem = _gridItem[indexPath.row];
        cell.backgroundColor = [UIColor whiteColor];
        gridcell = cell;
    }
    else if (indexPath.section == 2) {//快递单信息
        ADExpressInformationViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ADExpressInformationViewCellID];
        //            cell.gridItem = _gridItem[indexPath.row];
        cell.backgroundColor = [UIColor whiteColor];
        gridcell = cell;
    }else if (indexPath.section == 3) {//发货地址
        ADShipAddressViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ADShipAddressViewCellID];
        //            cell.gridItem = _gridItem[indexPath.row];
        cell.backgroundColor = [UIColor whiteColor];
        gridcell = cell;
    }else if (indexPath.section == 4) {//售后申请记录
        ADApplicationRecordViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ADApplicationRecordViewCellID];
        //            cell.gridItem = _gridItem[indexPath.row];
        cell.backgroundColor = [UIColor whiteColor];
        gridcell = cell;
    }
    return gridcell;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        ADServiceStateView *headerView = [[ADServiceStateView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        headerView.backgroundColor = kBACKGROUNDCOLOR;
        return headerView;
    }else{
        UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, GetScaleWidth(10))];
        sectionView.backgroundColor = kBACKGROUNDCOLOR;
        return sectionView;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section == 0){
        return 40;
    }else{
        return GetScaleWidth(10);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {//售后流程
        return 150;
    }
    if (indexPath.section == 1) {//基本信息
        return 150;
    }
    if (indexPath.section == 2) {//快递单信息
        return 190;
    }
    if (indexPath.section == 3) {//发货地址
        return 145;
    }
    if (indexPath.section == 4) {//售后申请记录
        return 185;
    }
    return 0;
}

- (void)baseTableVIew:(BaseTableView *)tableView refresh:(BOOL)flag {
    [self requestAllOrder:NO];
}

- (void)baseTableView:(BaseTableView *)tableView loadMore:(BOOL)flag {
    [self requestAllOrder:YES];
}

-(void)setModel:(ADApplyAfterSaleModel *)model{
    _model = model;
    [self requestAllOrder:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
