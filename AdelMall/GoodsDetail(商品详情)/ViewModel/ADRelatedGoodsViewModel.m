//
//  ADRelatedGoodsViewModel.m
//  AdelMall
//
//  Created by apple on 2018/4/11.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import "ADRelatedGoodsViewModel.h"
#import "ADGoodsModel.h"
#import "ADGoodsCell.h"

@interface ADRelatedGoodsViewModel()<UITableViewDelegate,UITableViewDataSource,BaseTableViewDelegate>



@end

@implementation ADRelatedGoodsViewModel
@synthesize goodsTable = _goodsTable;

- (BaseTableView *)goodsTable{
    if (!_goodsTable) {
        _goodsTable = [[BaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _goodsTable.delegate = self;
        _goodsTable.dataSource = self;
        _goodsTable.isLoadMore = YES;
        _goodsTable.isRefresh = YES;
        _goodsTable.delegateBase = self;
        _goodsTable.showsVerticalScrollIndicator = NO;
        _goodsTable.showsHorizontalScrollIndicator = NO;
        [_goodsTable registerClass:[ADGoodsCell class] forCellReuseIdentifier:@"ADGoodsCell"];
    }
    return _goodsTable;
}

#pragma mark - -- UITableView Datasource Function

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.goodsTable.data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kScreenWidth == 320 ? 140 : GetScaleWidth(140);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ADGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ADGoodsCell"];
    if (self.goodsTable.data.count > indexPath.row) {
        ADGoodsModel *model = self.goodsTable.data[indexPath.row];
        cell.model = model;
    }
    cell.imageViewBtnClickBlock = ^{
        //进入商品详情
//        ADGoodsDetailViewController *detailVC = [[ADGoodsDetailViewController alloc] init];
//        [self.navigationController pushViewController:detailVC animated:YES];
    };
    
    return cell;
}

#pragma mark - -- BaseTableView Delegate Function
- (void)baseTableVIew:(BaseTableView *)tableView refresh:(BOOL)flag {
    [self requestAllOrder:NO];
}

- (void)baseTableView:(BaseTableView *)tableView loadMore:(BOOL)flag {
    [self requestAllOrder:YES];
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
    
    NSArray *dataArr = @[@{@"id":@"123456",@"goodsName":@"ADEL爱迪尔4920B",@"type":@"智能指纹锁",@"price":@"1968.00"},@{@"id":@"123456",@"goodsName":@"ADEL爱迪尔4920B",@"type":@"智能指纹锁",@"price":@"1968.00"},@{@"id":@"123456",@"goodsName":@"ADEL爱迪尔4920B",@"type":@"智能指纹锁",@"price":@"1968.00"},@{@"id":@"123456",@"goodsName":@"ADEL爱迪尔4920B",@"type":@"智能指纹锁",@"price":@"1968.00"}];

    NSMutableArray *doubleDataArr = dataArr.mutableCopy;
    [doubleDataArr addObjectsFromArray:dataArr];
    [doubleDataArr addObjectsFromArray:doubleDataArr];
    dataArr = doubleDataArr.copy;
    
    
    [self.goodsTable.data removeAllObjects];
    for (NSDictionary *dic in dataArr) {
        
        ADGoodsModel *model = [ADGoodsModel mj_objectWithKeyValues:dic];
        [self.goodsTable.data addObject:model];
    }
    
    [self.goodsTable updatePage:more];
    //    self.allOrderTable.isLoadMore = dataArr.count >= k_RequestPageSize ? YES : NO;
    self.goodsTable.noDataView.hidden = self.goodsTable.data.count;
    
    [self.goodsTable reloadData];
}

@end
