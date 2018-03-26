//
//  ADGoodsIntroduceCell.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/16.
//  Copyright © 2018年 Adel. All rights reserved.
//  限时秒杀-抢购商品详情-商品介绍

#import "ADGoodsIntroduceCell.h"
#import "EdgeInsetsLabel.h"

@interface ADGoodsIntroduceCell()
@property (nonatomic, strong) UIView* bgView;
/** 横线 */
@property(nonatomic,strong)UIView *lineView;
/** 商品名称 */
@property (strong , nonatomic)UILabel *goodsNameLabel;
/** 发货说明 */
@property (strong , nonatomic)UILabel *explainLabel;
/** 限购 */
@property (strong , nonatomic)EdgeInsetsLabel *tipLabel;
@end

@implementation ADGoodsIntroduceCell

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
    [self.bgView addSubview:self.goodsNameLabel];
    [self.bgView addSubview:self.explainLabel];
    [self.bgView addSubview:self.tipLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self makeConstraints];
}

#pragma mark - 填充数据
-(void)setUpData{
    self.goodsNameLabel.text = @"3398型 智能门锁家庭酒店专用指纹智能门锁";
    self.explainLabel.text = @"当天可发货,指纹门锁,防盗锁";
    self.tipLabel.text = @"仅限100件,每用户限2件";
}

- (void)makeConstraints {
    WEAKSELF
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.top.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf.mas_bottom);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.bgView.mas_left);
        make.top.equalTo(weakSelf.bgView.mas_top).with.offset(1);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 1));
    }];

    [self.goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(40);
        make.top.equalTo(weakSelf.bgView.mas_top).with.offset(10);
    }];
    
    [self.explainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(40);
        make.top.equalTo(weakSelf.goodsNameLabel.mas_bottom).with.offset(10);
    }];
    
//    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(40);
//        make.top.equalTo(weakSelf.explainLabel.mas_bottom).with.offset(10);
//    }];
    
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectZero];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectZero];
        _lineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineView;
}

- (UILabel *)goodsNameLabel {
    if (!_goodsNameLabel) {
        _goodsNameLabel = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _goodsNameLabel;
}

- (UILabel *)explainLabel {
    if (!_explainLabel) {
        _explainLabel = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor lightGrayColor]];
    }
    return _explainLabel;
}

- (EdgeInsetsLabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[EdgeInsetsLabel alloc] initWithFrame:CGRectMake(40, 55, 140, 20)];
        _tipLabel.font = [UIFont systemFontOfSize:kFontNum12];
        _tipLabel.textColor = [UIColor whiteColor];
        _tipLabel.backgroundColor = [UIColor redColor];
        _tipLabel.contentInset = UIEdgeInsetsMake(5, 5, 5, 5);//分别为上、左、下、右
        // 设置圆角的大小
        _tipLabel.layer.cornerRadius = 5;
        [_tipLabel.layer setMasksToBounds:YES];
    }
    return _tipLabel;
}

@end
