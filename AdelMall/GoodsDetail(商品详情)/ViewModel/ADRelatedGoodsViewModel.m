//
//  ADRelatedGoodsViewModel.m
//  AdelMall
//
//  Created by apple on 2018/4/11.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import "ADRelatedGoodsViewModel.h"
#import "ADGoodsModel.h"
//#import "ADGoodsCell.h"
#import "ADRelatedGoodsLayout.h"
#import "ADRelatedGoodsCell.h"

@interface ADRelatedGoodsViewModel()<UITableViewDelegate,UITableViewDataSource,BaseTableViewDelegate>

@property (nonatomic,strong)NSMutableArray<DCClassGoodsItem *> *goodsItem;//数据源
@property (nonatomic,strong)NSMutableArray<ADRelatedGoodsLayout *> *layouts;//布局数据源

@end

@implementation ADRelatedGoodsViewModel
@synthesize goodsListView = _goodsListView;

- (void)loadGoodsData:(NSArray<DCClassGoodsItem *> *)goodsItem{
    _goodsItem = goodsItem.mutableCopy;
    [self.layouts removeAllObjects];
    for (ADGoodsModel *item in _goodsItem) {
        ADRelatedGoodsLayout *layout = [ADRelatedGoodsLayout layoutWithGoodsItem:item];
        [self.layouts addObject:layout];
    }
    [_goodsListView reloadData];
}

- (NSMutableArray *)layouts{
    if (!_layouts) {
        _layouts = [NSMutableArray array];
    }
    return _layouts;
}

- (UITableView *)goodsListView{
    if (!_goodsListView) {
        _goodsListView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _goodsListView.delegate = self;
        _goodsListView.dataSource = self;
        _goodsListView.showsVerticalScrollIndicator = NO;
        _goodsListView.showsHorizontalScrollIndicator = NO;
    }
    return _goodsListView;
}

#pragma mark - -- UITableView Datasource Function

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.goodsTable.data.count;
    return _layouts.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ((ADRelatedGoodsLayout *)_layouts[indexPath.row]).height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ADRelatedGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:ADRelatedGoodsCellID];
    if (!cell) {
        cell = [[ADRelatedGoodsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ADRelatedGoodsCellID];
    }
    cell.layout = _layouts[indexPath.row];
    return cell;
}

@end
