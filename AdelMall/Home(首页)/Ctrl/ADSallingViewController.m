//
//  ADSallingViewController.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/6.
//  Copyright © 2018年 Adel. All rights reserved.
//  限时抢购-正在抢购

#import "ADSallingViewController.h"
#import "ADSallGoodsDetailViewController.h"//抢购商品详情
//#import "ADSallingModel.h"
#import "ADSallingCell.h"
#import "ADCountDownGoodsModel.h"

@interface ADSallingViewController ()<UITableViewDelegate,UITableViewDataSource,BaseTableViewDelegate>
@property (nonatomic, strong) BaseTableView         *goodsTable;
/** 当前页数 */
@property(nonatomic)NSInteger currentPage;
@end

@implementation ADSallingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.goodsTable];
    [self makeConstraints];
//    [self requestAllOrder:NO];
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
    [RequestTool getGoodsForFlashSale:@{@"type":@"start",@"currentPage":[NSNumber numberWithInteger:self.currentPage]} withSuccessBlock:^(NSDictionary *result) {
        NSLog(@"正在抢购result = %@",result);
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
        }
    } withFailBlock:^(NSString *msg) {
        [self cutCurrentPag];
        NSLog(@"正在抢购msg = %@",msg);
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
    
//    NSArray *dataArr = @[@{@"id":@"123456",@"goodsName":@"ADEL爱迪尔4920B",@"type":@"智能指纹锁",@"salePrice":@"1268.00",@"soldNum":@"12",@"saleNum":@"20"},@{@"id":@"123456",@"goodsName":@"ADEL爱迪尔4920B",@"type":@"智能指纹锁",@"salePrice":@"1268.00",@"soldNum":@"12",@"saleNum":@"20"},@{@"id":@"123456",@"goodsName":@"ADEL爱迪尔4920B",@"type":@"智能指纹锁",@"salePrice":@"1268.00",@"soldNum":@"12",@"saleNum":@"20"}];
    NSArray *dataArr = [NSArray array];
        if ([result isKindOfClass:[NSDictionary class]]) {
            NSArray *dataInfo = result[@"data"][@"group_goodsList"][@"resultList"];
            if ([dataInfo isKindOfClass:[NSArray class]]) {
                dataArr = dataInfo;
            }
        }
    [self.goodsTable.data removeAllObjects];
    for (NSDictionary *dic in dataArr) {
        
        ADCountDownGoodsModel *model = [ADCountDownGoodsModel mj_objectWithKeyValues:dic];
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
        [_goodsTable registerClass:[ADSallingCell class] forCellReuseIdentifier:@"ADSallingCell"];
        
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
    return kScreenWidth == 320 ? 110 : GetScaleWidth(110);
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
    ADSallingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ADSallingCell"];
    if (self.goodsTable.data.count > indexPath.row) {
        ADCountDownGoodsModel *model = self.goodsTable.data[indexPath.row];
        cell.model = model;
    }
    __weak NSString *goodsID = cell.model.idx;
    cell.imageViewBtnClickBlock = ^{
        //进入抢购商品详情页面
        ADSallGoodsDetailViewController *sallGoodsDetailVC = [[ADSallGoodsDetailViewController alloc] init];
        [sallGoodsDetailVC loadDataWithGoodsID:goodsID];
        [self.navigationController pushViewController:sallGoodsDetailVC animated:YES];
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
