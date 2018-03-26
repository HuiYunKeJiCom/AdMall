//
//  ADWaitingEvaluatedViewController.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/10.
//  Copyright © 2018年 Adel. All rights reserved.
//  评价中心-待评价

#import "ADWaitingEvaluatedViewController.h"
//#import "ADCouponModel.h"
//#import "ADNotUsedCouponCell.h"
#import "ADEvaluateModel.h"
#import "ADEvaluateCell.h"
#import "ADEvaluatedExposureViewController.h"//评价晒单

@interface ADWaitingEvaluatedViewController ()<UITableViewDelegate,UITableViewDataSource,BaseTableViewDelegate>
@property (nonatomic, strong) BaseTableView         *goodsTable;

@end

@implementation ADWaitingEvaluatedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.goodsTable];
    [self makeConstraints];
    [self requestAllOrder:NO];
}

#pragma mark - Constraints
- (void)makeConstraints {
    
    [self.goodsTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
        //        make.top.equalTo(self.view.mas_bottom).with.offset(GetScaleWidth(10));
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
    
    NSArray *dataArr = @[@{@"id":@"123456",@"goodsName":@"ADEL爱迪尔4920B",@"goodsPrice":@"1968.00",@"goodsType":@"智能指纹锁",@"evaluationNumber":@"618"},@{@"id":@"123456",@"goodsName":@"ADEL爱迪尔4920B",@"goodsPrice":@"1968.00",@"goodsType":@"智能指纹锁",@"evaluationNumber":@"618"},@{@"id":@"123456",@"goodsName":@"ADEL爱迪尔4920B",@"goodsPrice":@"1968.00",@"goodsType":@"智能指纹锁",@"evaluationNumber":@"618"}];
    //    if ([result isKindOfClass:[NSDictionary class]]) {
    //        NSArray *dataInfo = result[@"data"];
    //        if ([dataInfo isKindOfClass:[NSArray class]]) {
    //            dataArr = dataInfo;
    //        }
    //    }
    
    [self.goodsTable.data removeAllObjects];
    for (NSDictionary *dic in dataArr) {
        
        ADEvaluateModel *model = [ADEvaluateModel mj_objectWithKeyValues:dic];
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
        [_goodsTable registerClass:[ADEvaluateCell class] forCellReuseIdentifier:@"ADEvaluateCell"];
        
    }
    return _goodsTable;
}

#pragma mark - UITableViewDelegate

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 10.0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.goodsTable.data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kScreenWidth == 320 ? 150 : GetScaleWidth(150);
}

//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return self.goodsTable.data.count;
//}

//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    //设置间隔高度
//    return 0.001;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 0.001;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ADEvaluateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ADEvaluateCell"];
    if (self.goodsTable.data.count > indexPath.row) {
        ADEvaluateModel *model = self.goodsTable.data[indexPath.row];

        cell.model = model;
    }
    cell.evaluateBtnClickBlock = ^{
        NSLog(@"点击了去评论");
        //跳转到评价晒单
        ADEvaluatedExposureViewController *evaluateExposureVC = [[ADEvaluatedExposureViewController alloc] init];
        [self.navigationController pushViewController:evaluateExposureVC animated:YES];
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
