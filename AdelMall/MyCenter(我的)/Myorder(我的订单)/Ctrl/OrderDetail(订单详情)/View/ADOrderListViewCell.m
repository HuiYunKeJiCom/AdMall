//
//  ADOrderListViewCell.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/2/9.
//  Copyright © 2018年 Adel. All rights reserved.
//  商品清单

#import "ADOrderListViewCell.h"
#import "ADGoodsView.h"
#import "ADTotalPriceView.h"

@interface ADOrderListViewCell()
@property (nonatomic, strong) UIView  *bgView;
/** 标题 */
@property(nonatomic,strong)UILabel *titleLab;
/** 横线 */
@property(nonatomic,strong)UIView *lineView;
///** 商品 */
//@property(nonatomic,strong)ADGoodsView *goodsView;
/** 总体价格页面 */
@property(nonatomic,strong)ADTotalPriceView *totalPriceView;
@end

@implementation ADOrderListViewCell

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
    [self.bgView addSubview:self.lineView];
    [self.bgView addSubview:self.titleLab];
    [self createGoodsViewsWithNSInteger:2];
    [self.bgView addSubview:self.totalPriceView];
}

- (void)createGoodsViewsWithNSInteger:(NSInteger)temp{
    for(int i=0;i<temp;i++){
        ADGoodsView *goodsView = [[ADGoodsView alloc] initWithFrame:CGRectMake(0, 38+i*109, kScreenWidth, 109)];
        goodsView.backgroundColor = [UIColor whiteColor];
        [self.bgView addSubview:goodsView];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self makeConstraints];
}

#pragma mark - 填充数据
-(void)setUpData{
    self.titleLab.text = @"商品清单";
}

#pragma mark - Constraints
- (void)makeConstraints {
    WEAKSELF
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.top.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf.mas_bottom);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(10);
        make.top.equalTo(weakSelf.bgView.mas_top).with.offset(10);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.bgView.mas_centerX);
        make.top.equalTo(weakSelf.titleLab.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 1));
    }];
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectZero];
        _bgView.backgroundColor = k_UIColorFromRGB(0xffffff);
    }
    return _bgView;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor blackColor]];
    }
    return _titleLab;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectZero];
        _lineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineView;
}

- (ADTotalPriceView *)totalPriceView {
    if (!_totalPriceView) {
        _totalPriceView = [[ADTotalPriceView alloc] initWithFrame:CGRectMake(0, 40+109*2, kScreenWidth, 110)];
        _totalPriceView.backgroundColor = [UIColor whiteColor];
    }
    return _totalPriceView;
}

@end
