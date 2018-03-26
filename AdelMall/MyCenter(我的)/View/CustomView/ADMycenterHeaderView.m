//
//  ADMycenterHeaderView.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/1/29.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import "ADMycenterHeaderView.h"

@interface ADMycenterHeaderView()
/** 背景图片 */
@property(nonatomic,strong)UIImageView *bgIV;
/** 头像 */
@property(nonatomic,strong)UIButton *iconButton;
/** 电话号码 */
@property(nonatomic,strong)UILabel *phoneNumLab;
/** 用户名 */
@property(nonatomic,strong)UILabel *userNameLab;
/** 用户类型 */
@property(nonatomic,strong)UILabel *userTypeLab;

@end

@implementation ADMycenterHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
//        //圆角
//        [DCSpeedy dc_chageControlCircularWith:self.iconButton AndSetCornerRadius:self.iconButton.dc_width * 0.5 SetBorderWidth:1 SetBorderColor:[UIColor whiteColor] canMasksToBounds:YES];
       
    }
    
    return self;
}

- (void)initViews {
    
    self.userTypeLab.text = KLocalizableStr(@" 家庭用户 ");
    self.userNameLab.text = @"User_01233";
    self.phoneNumLab.text = @"13800138000";
    
    [self addSubview:self.bgIV];
    [self addSubview:self.iconButton];
    [self addSubview:self.phoneNumLab];
    [self addSubview:self.userNameLab];
    [self addSubview:self.userTypeLab];
    

    [self makeConstraints];
}

- (void)makeConstraints {
    WEAKSELF
    [self.bgIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(weakSelf);
    }];
    
    [self.iconButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(42);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(95, 95));
    }];
    
    [self.userTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.iconButton.mas_bottom);
        make.centerX.equalTo(weakSelf.iconButton.mas_centerX);
    }];
    
    [self.userNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.iconButton.mas_right).with.offset(18);
        make.centerY.equalTo(weakSelf.iconButton.mas_centerY);
    }];
    
    [self.phoneNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.iconButton.mas_right).with.offset(18);
        make.bottom.equalTo(weakSelf.iconButton.mas_bottom);
    }];
}

-(UIImageView *)bgIV{
    if (!_bgIV) {
        _bgIV = [[UIImageView alloc] init];
        [_bgIV setImage:[UIImage imageNamed:@"my_banner"]];
        [_bgIV setContentMode:UIViewContentModeScaleAspectFill];
    }
    return _bgIV;
}

- (UIButton *)iconButton {
    if (!_iconButton) {
        _iconButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_iconButton setImage:[UIImage imageNamed:@"icon"] forState:UIControlStateNormal];
        [DCSpeedy dc_chageControlCircularWith:_iconButton AndSetCornerRadius:95*0.5 SetBorderWidth:1 SetBorderColor:k_UIColorFromRGB(0xffffff) canMasksToBounds:YES];
        [_iconButton addTarget:self action:@selector(headButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _iconButton;
}

- (UILabel *)phoneNumLab {
    if (!_phoneNumLab) {
        _phoneNumLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:k_UIColorFromRGB(0xffffff)];
    }
    return _phoneNumLab;
}

- (UILabel *)userNameLab {
    if (!_userNameLab) {
        _userNameLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum17 TextColor:k_UIColorFromRGB(0xffffff)];
    }
    return _userNameLab;
}

- (UILabel *)userTypeLab {
    if (!_userTypeLab) {
        _userTypeLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum11 TextColor:k_UIColorFromRGB(0xFF3030)];
        [_userTypeLab setRadiusSize:3];
        _userTypeLab.backgroundColor = [UIColor whiteColor];
    }
    return _userTypeLab;
}

#pragma mark - 头像点击
- (void)headButtonClick {
    !_headClickBlock ? : _headClickBlock();
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
