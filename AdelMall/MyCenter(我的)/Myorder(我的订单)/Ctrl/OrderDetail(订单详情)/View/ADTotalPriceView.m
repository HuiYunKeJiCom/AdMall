//
//  ADTotalPriceView.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/2/25.
//  Copyright © 2018年 Adel. All rights reserved.
//  订单详情-商品总价

#import "ADTotalPriceView.h"

@interface ADTotalPriceView()

/** 商品总价标题 */
@property(nonatomic,strong)UILabel *totalGoodsPriceTitLab;
/** 商品总价 */
@property(nonatomic,strong)UILabel *totalGoodsPriceLab;
/** 运费标题 */
@property(nonatomic,strong)UILabel *freightTitLab;
/** 运费 */
@property(nonatomic,strong)UILabel *freightLab;
/** 优惠券标题 */
@property(nonatomic,strong)UILabel *couponTitLab;
/** 优惠券 */
@property(nonatomic,strong)UILabel *couponLab;
/** 横线 */
@property(nonatomic,strong)UIView *lineView;
/** 总价格标题 */
@property(nonatomic,strong)UILabel *totalPriceTitLab;
/** 总价格 */
@property(nonatomic,strong)UILabel *totalPriceLab;
/** 单位 */
@property(nonatomic,strong)UILabel *unitLab;
@end

@implementation ADTotalPriceView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kBACKGROUNDCOLOR;
        [self initViews];
        [self setUpData];
    }
    
    return self;
}

- (void)setUpData {
    self.totalGoodsPriceTitLab.text = @"商品总价：";
    self.freightTitLab.text = @"运费：";
    self.couponTitLab.text = @"优惠券：";
    self.totalPriceTitLab.text = @"共计：";
    self.unitLab.text = @"元";
    
    self.totalGoodsPriceLab.text = @"10400.00元";
    self.freightLab.text = @"50.00元";
    self.couponLab.text = @"-10.00元";
    self.totalPriceLab.text = @"10440.00";
}

- (void)initViews {
    [self addSubview:self.totalGoodsPriceTitLab];
    [self addSubview:self.totalGoodsPriceLab];
    [self addSubview:self.freightTitLab];
    [self addSubview:self.freightLab];
    [self addSubview:self.couponTitLab];
    [self addSubview:self.couponLab];
    [self addSubview:self.lineView];
    [self addSubview:self.totalPriceTitLab];
    [self addSubview:self.totalPriceLab];
    [self addSubview:self.unitLab];
    [self makeConstraints];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)makeConstraints {
    WEAKSELF
    
    [self.totalGoodsPriceTitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(25);
        make.top.equalTo(weakSelf).with.offset(10);
    }];
    
    [self.totalGoodsPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.totalGoodsPriceTitLab.mas_right);
        make.top.equalTo(weakSelf).with.offset(10);
    }];
    
    [self.freightTitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(25);
        make.top.equalTo(weakSelf.totalGoodsPriceTitLab.mas_bottom).with.offset(5);
    }];
    
    [self.freightLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.freightTitLab.mas_right);
        make.top.equalTo(weakSelf.totalGoodsPriceTitLab.mas_bottom).with.offset(5);
    }];
    
    [self.couponTitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(25);
        make.top.equalTo(weakSelf.freightTitLab.mas_bottom).with.offset(5);
    }];
    
    [self.couponLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.couponTitLab.mas_right);
        make.top.equalTo(weakSelf.freightTitLab.mas_bottom).with.offset(5);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
        make.top.equalTo(weakSelf.couponTitLab.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth-50, 1));
    }];
    
    [self.unitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).with.offset(-25);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-10);
    }];
    
    [self.totalPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.unitLab.mas_left).with.offset(-5);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-10);
    }];
    
    [self.totalPriceTitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.totalPriceLab.mas_left);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-10);
    }];
    
}

- (UILabel *)totalGoodsPriceTitLab {
    if (!_totalGoodsPriceTitLab) {
        _totalGoodsPriceTitLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _totalGoodsPriceTitLab;
}

- (UILabel *)totalGoodsPriceLab {
    if (!_totalGoodsPriceLab) {
        _totalGoodsPriceLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _totalGoodsPriceLab;
}

- (UILabel *)freightTitLab {
    if (!_freightTitLab) {
        _freightTitLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _freightTitLab;
}

- (UILabel *)freightLab {
    if (!_freightLab) {
        _freightLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _freightLab;
}

- (UILabel *)couponTitLab {
    if (!_couponTitLab) {
        _couponTitLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _couponTitLab;
}

- (UILabel *)couponLab {
    if (!_couponLab) {
        _couponLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _couponLab;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectZero];
        _lineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineView;
}

- (UILabel *)totalPriceTitLab {
    if (!_totalPriceTitLab) {
        _totalPriceTitLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _totalPriceTitLab;
}

- (UILabel *)totalPriceLab {
    if (!_totalPriceLab) {
        _totalPriceLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum16 TextColor:[UIColor redColor]];
    }
    return _totalPriceLab;
}

- (UILabel *)unitLab {
    if (!_unitLab) {
        _unitLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _unitLab;
}

@end
