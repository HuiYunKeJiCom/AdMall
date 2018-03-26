//
//  ADEvaluateListViewCell.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/8.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import "ADEvaluateListViewCell.h"
//#import "ADCouponModel.h"
//#import "ADNotUsedCouponCell.h"
#import "ADEvaluateListModel.h"
#import "ADEvaluateListTableViewCell.h"

@interface ADEvaluateListViewCell()<UITableViewDelegate,UITableViewDataSource,BaseTableViewDelegate>
@property (nonatomic, strong) BaseTableView         *goodsTable;
@property (nonatomic, strong) UIView           *bgView;
@end

@implementation ADEvaluateListViewCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
        [self setUpData];
    }
    return self;
}

- (void)setUpUI{
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.goodsTable];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self makeConstraints];
}

#pragma mark - 填充数据
-(void)setUpData{
    [self requestAllOrder:NO];
}

- (void)makeConstraints {
    WEAKSELF
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.top.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf.mas_bottom);
    }];
    
    [self.goodsTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(weakSelf.bgView);
        //        make.top.equalTo(self.view.mas_bottom).with.offset(GetScaleWidth(10));
    }];
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectZero];
        _bgView.backgroundColor = k_UIColorFromRGB(0xffffff);
    }
    return _bgView;
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
    
    NSArray *dataArr = @[@{@"id":@"123456",@"userName":@"Pakho",@"evaluateTime":@"2017-01-01",@"evaluateContent":@"第一次购买爱迪尔门锁，质量好的没的说，期望平台能有更多的活动优惠。"},@{@"id":@"123456",@"userName":@"Pakho",@"evaluateTime":@"2017-01-01",@"evaluateContent":@"第一次购买爱迪尔门锁，质量好的没的说，期望平台能有更多的活动优惠。"},@{@"id":@"123456",@"userName":@"Pakho",@"evaluateTime":@"2017-01-01",@"evaluateContent":@"第一次购买爱迪尔门锁，质量好的没的说，期望平台能有更多的活动优惠。"}];
    //    if ([result isKindOfClass:[NSDictionary class]]) {
    //        NSArray *dataInfo = result[@"data"];
    //        if ([dataInfo isKindOfClass:[NSArray class]]) {
    //            dataArr = dataInfo;
    //        }
    //    }
    
    [self.goodsTable.data removeAllObjects];
    for (NSDictionary *dic in dataArr) {
        
        ADEvaluateListModel *model = [ADEvaluateListModel mj_objectWithKeyValues:dic];
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
        [_goodsTable registerClass:[ADEvaluateListTableViewCell class] forCellReuseIdentifier:@"ADEvaluateListTableViewCell"];
        
    }
    return _goodsTable;
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.goodsTable.data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kScreenWidth == 320 ? 100 : GetScaleWidth(100);
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    //    headerView.backgroundColor = [UIColor redColor];
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 10,kScreenWidth, 20)];
    titleLab.text = @"可选类型";
    //    titleLab.backgroundColor = [UIColor greenColor];
    titleLab.font = [UIFont systemFontOfSize:14];
    titleLab.textColor = [UIColor blackColor];
    titleLab.textAlignment = NSTextAlignmentLeft;
    [headerView addSubview:titleLab];
    headerView.backgroundColor = [UIColor whiteColor];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    //    return kScreenWidth == 320 ? 40 : GetScaleWidth(40);
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ADEvaluateListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ADEvaluateListTableViewCell"];
    if (self.goodsTable.data.count > indexPath.row) {
        ADEvaluateListModel *model = self.goodsTable.data[indexPath.row];
        cell.model = model;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (void)baseTableVIew:(BaseTableView *)tableView refresh:(BOOL)flag {
    [self requestAllOrder:NO];
}

- (void)baseTableView:(BaseTableView *)tableView loadMore:(BOOL)flag {
    [self requestAllOrder:YES];
}

@end
