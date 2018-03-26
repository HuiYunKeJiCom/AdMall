//
//  ADServiceStateView.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/2.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import "ADServiceStateView.h"

@interface ADServiceStateView()
/** 服务单号标题 */
@property(nonatomic,strong)UILabel *serviceNumTitLab;
/** 服务单号 */
@property(nonatomic,strong)UILabel *serviceNumLab;
/** 状态 */
@property(nonatomic,strong)UILabel *stateLab;
@end

@implementation ADServiceStateView

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
    self.serviceNumTitLab.text = @"售后服务单号：";
    self.serviceNumLab.text = @"312801751";
    self.stateLab.text = @"(退款处理中)";
}

- (void)initViews {
    [self addSubview:self.serviceNumTitLab];
    [self addSubview:self.serviceNumLab];
    [self addSubview:self.stateLab];
    
    [self makeConstraints];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)makeConstraints {
    WEAKSELF
    
    [self.serviceNumTitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(100);
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    
    [self.serviceNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.serviceNumTitLab.mas_right);
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    
    [self.stateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.serviceNumLab.mas_right);
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    
}

- (UILabel *)serviceNumTitLab {
    if (!_serviceNumTitLab) {
        _serviceNumTitLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _serviceNumTitLab;
}

- (UILabel *)serviceNumLab {
    if (!_serviceNumLab) {
        _serviceNumLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _serviceNumLab;
}

- (UILabel *)stateLab {
    if (!_stateLab) {
        _stateLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _stateLab;
}


@end
