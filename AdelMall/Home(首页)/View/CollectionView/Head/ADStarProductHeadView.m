//
//  ADStarProductHeadView.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/2/28.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import "ADStarProductHeadView.h"
#import "DCZuoWenRightButton.h"

@interface ADStarProductHeadView ()
/* 主题 */
@property (strong , nonatomic)UILabel *timeLabel;

/* 右侧箭头 */
@property (strong , nonatomic)DCZuoWenRightButton *quickButton;
@end

@implementation ADStarProductHeadView

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
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.timeLabel];
    [self addSubview:self.quickButton];
    
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _timeLabel.frame = CGRectMake(20, 0, 260, self.dc_height);
    _quickButton.frame = CGRectMake(self.dc_width - 30, 0, 30, self.dc_height);
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum16 TextColor:[UIColor blackColor]];
    }
    return _timeLabel;
}

- (DCZuoWenRightButton *)quickButton {
    if (!_quickButton) {
        _quickButton = [DCZuoWenRightButton buttonWithType:UIButtonTypeCustom];
        _quickButton.titleLabel.font = [UIFont systemFontOfSize:kFontNum12];
        [_quickButton setImage:[UIImage imageNamed:@"ico_home_back_black"] forState:UIControlStateNormal];
        [_quickButton addTarget:self action:@selector(lookForAllGoods) forControlEvents:UIControlEventTouchUpInside];
    }
    return _quickButton;
}

-(void)setTopTitleWithNSString:(NSString *)string{
    self.timeLabel.text = string;
}

#pragma mark - 点击事件
- (void)lookForAllGoods
{
    !_lookAllBlock ? : _lookAllBlock();
}

#pragma mark - Setter Getter Methods


@end
