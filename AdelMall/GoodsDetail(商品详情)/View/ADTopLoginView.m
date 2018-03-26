//
//  ADTopLoginView.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/2/7.
//  Copyright © 2018年 Adel. All rights reserved.
//  商品详情-去登录页面

#import "ADTopLoginView.h"

@interface ADTopLoginView()
/** 提示语 */
@property(nonatomic,strong)UILabel *tipLab;
/** 跳转到登录页面 按钮 */
@property(nonatomic,strong)UIButton *toLoginBtn;
/** 关闭 按钮 */
@property(nonatomic,strong)UIButton *closeBtn;
@end

@implementation ADTopLoginView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
        [self setUpData];
    }
    
    return self;
}

- (void)initViews {
    
    self.userInteractionEnabled = YES;
    
    [self addSubview:self.tipLab];
    [self addSubview:self.toLoginBtn];
    [self addSubview:self.closeBtn];
    
    [self makeConstraints];
}

- (void)setUpData {
    self.tipLab.text = @"为方便您购买，请提前登录。";
    [self.toLoginBtn setTitle:@"立即登录" forState:UIControlStateNormal];
    [self.closeBtn setTitle:@"X" forState:UIControlStateNormal];
}

- (void)makeConstraints {
    WEAKSELF
    
    [self.tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weakSelf).with.offset(100);
        make.centerX.equalTo(weakSelf.mas_centerX).with.offset(-30);
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).with.offset(-15);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.width.mas_equalTo(GetScaleWidth(20));
        make.height.mas_equalTo(weakSelf.height);
    }];
    
    [self.toLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.closeBtn.mas_left).with.offset(-15);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.width.mas_equalTo(GetScaleWidth(70));
        make.height.mas_equalTo(weakSelf.height);
    }];
    
}

- (UILabel *)tipLab {
    if (!_tipLab) {
        _tipLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor blackColor]];
    }
    return _tipLab;
}

- (UIButton *)toLoginBtn {
    if (!_toLoginBtn) {
        _toLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _toLoginBtn.titleLabel.font = [UIFont systemFontOfSize:kFontNum14];
//        _toLoginBtn.backgroundColor = [UIColor blueColor];
        [_toLoginBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_toLoginBtn addTarget:self action:@selector(toLoginButtonClick) forControlEvents:UIControlEventTouchUpInside];

    }
    return _toLoginBtn;
}

- (UIButton *)closeBtn  {
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeBtn.titleLabel.font = [UIFont systemFontOfSize:kFontNum14];
//        _closeBtn.backgroundColor = [UIColor redColor];
        [_closeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(closeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

#pragma mark - 去登录 点击
- (void)toLoginButtonClick {
    NSLog(@"去登录 点击");
    !_toLoginClickBlock ? : _toLoginClickBlock();
}

#pragma mark - 关闭 点击
- (void)closeButtonClick {
    !_closeClickBlock ? : _closeClickBlock();
}

@end
