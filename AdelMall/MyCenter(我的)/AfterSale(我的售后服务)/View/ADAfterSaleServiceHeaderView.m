//
//  ADAfterSaleServiceHeaderView.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/2.
//  Copyright © 2018年 Adel. All rights reserved.
//  我的售后服务headerView

#import "ADAfterSaleServiceHeaderView.h"

@interface ADAfterSaleServiceHeaderView()
/** 服务单号标题 */
@property(nonatomic,strong)UILabel *serviceNumTitLab;
/** 服务单号 */
@property(nonatomic,strong)UILabel *serviceNumLab;
/** 服务状态 */
@property(nonatomic,strong)UILabel *serviceStateLab;
@end

@implementation ADAfterSaleServiceHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initViews];
        [self setUpData];
    }
    
    return self;
}

- (void)setUpData {
    self.serviceNumTitLab.text = @"售后服务单号：";
    self.serviceNumLab.text = @"13245865";
    self.serviceStateLab.text = @"退款处理中";
}

- (void)initViews {
    [self addSubview:self.serviceNumTitLab];
    [self addSubview:self.serviceNumLab];
    [self addSubview:self.serviceStateLab];
    [self makeConstraints];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)makeConstraints {
    WEAKSELF
    [self.serviceNumTitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(30);
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    
    [self.serviceNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.serviceNumTitLab.mas_right);
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    
    [self.serviceStateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).with.offset(-30);
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    
}

- (UILabel *)serviceNumTitLab {
    if (!_serviceNumTitLab) {
        _serviceNumTitLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
        _serviceNumTitLab.textAlignment = NSTextAlignmentLeft;
    }
    return _serviceNumTitLab;
}

- (UILabel *)serviceNumLab {
    if (!_serviceNumLab) {
        _serviceNumLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
        _serviceNumLab.textAlignment = NSTextAlignmentLeft;
    }
    return _serviceNumLab;
}

- (UILabel *)serviceStateLab {
    if (!_serviceStateLab) {
        _serviceStateLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor redColor]];
        _serviceStateLab.textAlignment = NSTextAlignmentLeft;
    }
    return _serviceStateLab;
}

@end
