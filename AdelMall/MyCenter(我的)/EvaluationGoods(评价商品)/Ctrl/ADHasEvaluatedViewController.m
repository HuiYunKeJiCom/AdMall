//
//  ADHasEvaluatedViewController.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/10.
//  Copyright © 2018年 Adel. All rights reserved.
//  评价晒单-已评价

#import "ADHasEvaluatedViewController.h"
#import "ADEvaluateModel.h"
#import "ADEvaluateCell.h"
#import "ADEvaluatedExposureViewController.h"//评价晒单

@interface ADHasEvaluatedViewController ()<UITableViewDelegate,UITableViewDataSource,BaseTableViewDelegate>
@property (nonatomic, strong) BaseTableView         *goodsTable;
/** 当前页数 */
@property(nonatomic)NSInteger currentPage;

@end

@implementation ADHasEvaluatedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.goodsTable];
    [self makeConstraints];
}

-(void)viewWillAppear:(BOOL)animated{
    self.currentPage = 1;
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
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [RequestTool getEvaluationList:@{@"evaluateStatus":@"1",@"currentPage":[NSNumber numberWithInteger:self.currentPage]} withSuccessBlock:^(NSDictionary *result) {
        NSLog(@"评价列表已评价result = %@",result);
        if([result[@"code"] integerValue] == 1){
            [hud hide:YES];
            [weakSelf handleTransferResult:result more:more];
        }else if([result[@"code"] integerValue] == -2){
            self.currentPage -= 1;
            hud.detailsLabelText = @"登录失效";
            hud.mode = MBProgressHUDModeText;
            [hud hide:YES afterDelay:1.0];
        }else if([result[@"code"] integerValue] == -1){
            self.currentPage -= 1;
            hud.detailsLabelText = @"未登录";
            hud.mode = MBProgressHUDModeText;
            [hud hide:YES afterDelay:1.0];
        }else if([result[@"code"] integerValue] == 0){
            self.currentPage -= 1;
            hud.detailsLabelText = @"失败";
            hud.mode = MBProgressHUDModeText;
            [hud hide:YES afterDelay:1.0];
        }else if([result[@"code"] integerValue] == 2){
            self.currentPage -= 1;
            hud.detailsLabelText = @"无返回数据";
            hud.mode = MBProgressHUDModeText;
            [hud hide:YES afterDelay:1.0];
            [self.goodsTable reloadData];
        }
        
    } withFailBlock:^(NSString *msg) {
        self.currentPage -= 1;
        NSLog(@"评价列表已评价msg = %@",msg);
        hud.detailsLabelText = msg;
        hud.mode = MBProgressHUDModeText;
        [hud hide:YES afterDelay:1.0];
    }];
    
}

- (void)handleTransferResult:(NSDictionary *)result more:(BOOL)more{
    
    NSArray *dataArr = result[@"data"][@"goodsList"];
    
    [self.goodsTable.data removeAllObjects];
    
    for (NSDictionary *dic in dataArr) {
        
        ADEvaluateModel *model = [ADEvaluateModel mj_objectWithKeyValues:dic];
        [self.goodsTable.data addObject:model];
    }
    
    [self.goodsTable updatePage:more];
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
    self.currentPage += 1;
    [self requestAllOrder:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
