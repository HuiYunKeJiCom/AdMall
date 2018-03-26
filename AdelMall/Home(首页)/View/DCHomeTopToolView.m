//
//  DCHomeTopToolView.m
//  CDDStoreDemo
//
//  Created by dashen on 2017/11/28.
//Copyright © 2017年 RocketsChen. All rights reserved.
//  首页-导航栏

#import "DCHomeTopToolView.h"

@interface DCHomeTopToolView ()
/** 底部图片 */
@property(nonatomic,strong)UIImageView *bgIV;
/** 标题标签 */
@property(nonatomic,strong)UILabel *titleLab;
@end

@implementation DCHomeTopToolView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}


- (void)setUpUI
{
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.bgIV];
    [self addSubview:self.titleLab];
    
    CAGradientLayer * layer = [[CAGradientLayer alloc] init];
    layer.frame = self.bounds;
    layer.colors = @[(id)[UIColor colorWithWhite:0 alpha:0.2].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.15].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.1].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.05].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.03].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.01].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.0].CGColor];
    [self.layer addSublayer:layer];
}
#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    WEAKSELF
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    
    [self.bgIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.top.equalTo(weakSelf.mas_top);
        make.height.mas_equalTo(64);
    }];
}

-(UIImageView *)bgIV{
    if (!_bgIV) {
        _bgIV = [[UIImageView alloc] init];
        _bgIV.image = [UIImage imageNamed:@"top"];;
        [_bgIV setContentMode:UIViewContentModeScaleAspectFill];
    }
    return _bgIV;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum17 TextColor:[UIColor whiteColor]];
        _titleLab.textColor = [UIColor whiteColor];
    }
    return _titleLab;
}

-(void)setTopTitleWithNSString:(NSString *)string{
    self.titleLab.text = string;
}

@end
