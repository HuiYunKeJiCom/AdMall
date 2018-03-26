//
//  ADOrderStateView.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/2/9.
//  Copyright © 2018年 Adel. All rights reserved.
//  取消订单页面

#import "ADOrderStateView.h"

@interface ADOrderStateView()
/** 状态标签 */
@property(nonatomic,strong)UILabel *stateNameLab;
/** 状态 */
@property(nonatomic,strong)UILabel *stateLab;
/** 取消按钮 */
@property(nonatomic,strong)UIButton *cancelOrderBtn;
@end

@implementation ADOrderStateView

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
    self.stateNameLab.text = @"状态：";
    self.stateLab.text = @"待支付";
    [self.cancelOrderBtn setTitle:@"取消订单" forState:UIControlStateNormal];
}

- (void)initViews {
    [self addSubview:self.stateNameLab];
    [self addSubview:self.stateLab];
    [self addSubview:self.cancelOrderBtn];
    
    [self makeConstraints];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)makeConstraints {
    WEAKSELF
    
    [self.stateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_centerX).with.offset(-3);
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    
    [self.stateNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.stateLab.mas_left);
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    
    [self.cancelOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_centerX).with.offset(3);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(70, 20));
    }];
}

- (UILabel *)stateNameLab {
    if (!_stateNameLab) {
        _stateNameLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor blackColor]];
    }
    return _stateNameLab;
}

- (UILabel *)stateLab {
    if (!_stateLab) {
        _stateLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor blackColor]];
    }
    return _stateLab;
}

- (UIButton *)cancelOrderBtn  {
    if (!_cancelOrderBtn) {
        _cancelOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelOrderBtn.titleLabel.font = [UIFont systemFontOfSize:kFontNum14];
        _cancelOrderBtn.backgroundColor = [UIColor redColor];
        [_cancelOrderBtn.layer setMasksToBounds:YES];
        [_cancelOrderBtn.layer  setCornerRadius:5.0];
        [_cancelOrderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_cancelOrderBtn addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelOrderBtn;
}


#pragma mark - 取消订单 点击
- (void)cancelButtonClick {
    !_cancelClickBlock ? : _cancelClickBlock();
}

@end
