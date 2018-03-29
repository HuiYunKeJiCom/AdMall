//
//  ADOriginalPriceView.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/6.
//  Copyright © 2018年 Adel. All rights reserved.
//  抢购页面的原价格

#import "ADOriginalPriceView.h"

@interface ADOriginalPriceView()

/** 原价格 */
@property(nonatomic,strong)UILabel *originalPriceLab;
/** 单位 */
@property(nonatomic,strong)UILabel *unitLab;
/** 横线 */
@property(nonatomic,strong)UIView *lineView;

@end

@implementation ADOriginalPriceView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    
    return self;
}

- (void)initViews {
    
    [self addSubview:self.originalPriceLab];
    [self addSubview:self.unitLab];
    [self addSubview:self.lineView];
    
    [self makeConstraints];
    [self setUpData];

}

-(void)setUpData{
    self.unitLab.text = @"元";
}

-(void)setOldPriceWithNSString:(NSString *)string{
    self.originalPriceLab.text = [NSString stringWithFormat:@"%.2f",[string floatValue]];
}

- (void)makeConstraints {
    WEAKSELF
    
    [self.unitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right);
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
    }];
    
    [self.originalPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.unitLab.mas_left).with.offset(-5);
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.originalPriceLab.mas_left);
        make.right.equalTo(weakSelf.unitLab.mas_right);
        make.height.mas_equalTo(1);
    }];
    
}

- (UILabel *)originalPriceLab {
    if (!_originalPriceLab) {
        _originalPriceLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor lightGrayColor]];
    }
    return _originalPriceLab;
}

- (UILabel *)unitLab {
    if (!_unitLab) {
        _unitLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor lightGrayColor]];
    }
    return _unitLab;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectZero];
        _lineView.backgroundColor = [UIColor redColor];
        _lineView.transform = CGAffineTransformMakeRotation(0.45/M_PI);
    }
    return _lineView;
}

@end
