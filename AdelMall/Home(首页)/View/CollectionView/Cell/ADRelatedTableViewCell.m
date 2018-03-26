//
//  ADRelatedTableViewCell.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/20.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import "ADRelatedTableViewCell.h"
#import "ADGoodsModel.h"
#import "ADGoodsCell.h"

// 筛选框 上下的图片
#define kDownImg [UIImage imageNamed:@"arrow_down.png"]
#define kUpImg [UIImage imageNamed:@"arrow_up.png"]

@interface ADRelatedTableViewCell()<UITableViewDelegate,UITableViewDataSource,BaseTableViewDelegate>
@property (nonatomic, strong) UIView* bgView;
/** 商品table列表 */
@property (nonatomic, strong) BaseTableView         *goodsTable;
/** 相关商品 标题 */
@property (strong , nonatomic)UILabel *chosenTitLabel;
/** 展开选择页面 按钮 */
@property(nonatomic,strong)UIButton *openSpecViewBtn;
@end

@implementation ADRelatedTableViewCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        //        self.userInteractionEnabled = YES;
        [self setUpUI];
        [self setUpData];
    }
    return self;
}

- (void)setUpUI{
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.chosenTitLabel];
    [self.bgView addSubview:self.openSpecViewBtn];
    [self.bgView addSubview:self.goodsTable];
    [self requestAllOrder:NO];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self makeConstraints];
}

#pragma mark - 填充数据
-(void)setUpData{
    self.chosenTitLabel.text = @"相关商品";
    [self.openSpecViewBtn setImage:kUpImg forState:UIControlStateNormal];
}

- (void)makeConstraints {
    WEAKSELF
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.top.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf.mas_bottom);
        //        make.height.mas_equalTo(40);
    }];
    
    [self.chosenTitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(40);
        make.top.equalTo(weakSelf.bgView.mas_top).with.offset(10);
    }];
    
    [self.openSpecViewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.bgView.mas_right).with.offset(-16);
        make.top.equalTo(weakSelf.bgView.mas_top).with.offset(10);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(20);
    }];
    
    [self.goodsTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(weakSelf.bgView);
        make.top.equalTo(weakSelf.bgView.mas_top).with.offset(40);
    }];
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectZero];
        _bgView.backgroundColor = [UIColor whiteColor];
        //        _bgView.userInteractionEnabled = YES;
    }
    return _bgView;
}

- (UILabel *)chosenTitLabel {
    if (!_chosenTitLabel) {
        _chosenTitLabel = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor blackColor]];
    }
    return _chosenTitLabel;
}

- (UIButton *)openSpecViewBtn {
    if (!_openSpecViewBtn) {
        _openSpecViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _openSpecViewBtn.titleLabel.font = [UIFont systemFontOfSize:kFontNum11];
        _openSpecViewBtn.backgroundColor = [UIColor clearColor];
        [_openSpecViewBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_openSpecViewBtn addTarget:self action:@selector(openSpecViewBtnButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _openSpecViewBtn;
}

#pragma mark - 展开选择页面 点击
- (void)openSpecViewBtnButtonClick {
    !_openSpecViewClickBlock ? : _openSpecViewClickBlock();
}

#pragma mark - 图片 点击
- (void)imageViewBtnButtonClick {
    !_imageViewBtnClickBlock ? : _imageViewBtnClickBlock();
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
    
    NSArray *dataArr = @[@{@"id":@"123456",@"goodsName":@"ADEL爱迪尔4920B",@"type":@"智能指纹锁",@"price":@"1968.00"},@{@"id":@"123456",@"goodsName":@"ADEL爱迪尔4920B",@"type":@"智能指纹锁",@"price":@"1968.00"},@{@"id":@"123456",@"goodsName":@"ADEL爱迪尔4920B",@"type":@"智能指纹锁",@"price":@"1968.00"}];
    //    if ([result isKindOfClass:[NSDictionary class]]) {
    //        NSArray *dataInfo = result[@"data"];
    //        if ([dataInfo isKindOfClass:[NSArray class]]) {
    //            dataArr = dataInfo;
    //        }
    //    }
    
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

- (BaseTableView *)goodsTable {
    if (!_goodsTable) {
        _goodsTable = [[BaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _goodsTable.delegate = self;
        _goodsTable.dataSource = self;
        _goodsTable.isLoadMore = YES;
        _goodsTable.isRefresh = YES;
        _goodsTable.delegateBase = self;
        _goodsTable.backgroundColor = kBACKGROUNDCOLOR;
        [_goodsTable registerClass:[ADGoodsCell class] forCellReuseIdentifier:@"ADGoodsCell"];
        
    }
    return _goodsTable;
}

#pragma mark - UITableViewDelegate

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
        [self imageViewBtnButtonClick];
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

@end
