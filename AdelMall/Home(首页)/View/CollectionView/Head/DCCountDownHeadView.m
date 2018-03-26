//
//  DCCountDownHeadView.m
//  CDDMall
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCCountDownHeadView.h"
#import "DCZuoWenRightButton.h"

@interface DCCountDownHeadView ()

///* 红色块 */
//@property (strong , nonatomic)UIView *redView;
/** 背景图片 */
@property(nonatomic,strong)UIImageView *bgIV;
/* 时间 */
@property (strong , nonatomic)UILabel *timeLabel;
/* 倒计时 */
@property (strong , nonatomic)UILabel *countDownLabel;
/** 时 */
@property (strong , nonatomic)UILabel *hourLabel;
/** 冒号1 */
@property (strong , nonatomic)UILabel *colonLabel1;
/** 分 */
@property (strong , nonatomic)UILabel *minuteLabel;
/** 冒号2 */
@property (strong , nonatomic)UILabel *colonLabel2;
/** 秒 */
@property (strong , nonatomic)UILabel *secondLabel;
/* 提示语 */
@property (strong , nonatomic)UILabel *tipLabel;

/* 好货秒抢 */
@property (strong , nonatomic)DCZuoWenRightButton *quickButton;
@end

@implementation DCCountDownHeadView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
        [self setUpData];
    }
    return self;
}

- (void)setUpUI
{
    [self addSubview:self.bgIV];
    [self addSubview:self.timeLabel];
    [self addSubview:self.countDownLabel];
    [self addSubview:self.hourLabel];
    [self addSubview:self.colonLabel2];
    [self addSubview:self.minuteLabel];
    [self addSubview:self.colonLabel1];
    [self addSubview:self.secondLabel];
    [self addSubview:self.tipLabel];
    [self addSubview:self.quickButton];

}

-(void)setUpData{
    self.timeLabel.text = @"限时秒杀";
//    self.countDownLabel.text = @"05 : 58 : 33";
    self.hourLabel.text = @"00";
    self.colonLabel2.text = @":";
    self.minuteLabel.text = @"00";
    self.colonLabel1.text = @":";
    self.secondLabel.text = @"00";
    self.tipLabel.text = @"后结束抢购";
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self makeConstraints];
    
//    _redView.frame = CGRectMake(0, 10, 8, 20);
    _timeLabel.frame = CGRectMake(20, 0, 80, self.dc_height);
//    _countDownLabel.frame = CGRectMake(CGRectGetMaxX(_timeLabel.frame), 0, 80, self.dc_height);
    
    self.hourLabel.frame = CGRectMake(CGRectGetMaxX(self.timeLabel.frame), 10, 18, self.dc_height-20);
    self.colonLabel1.frame = CGRectMake(CGRectGetMaxX(self.hourLabel.frame)+2, 0, 5, self.dc_height);
    self.minuteLabel.frame = CGRectMake(CGRectGetMaxX(self.colonLabel1.frame), 10, 18, self.dc_height-20);
    self.colonLabel2.frame = CGRectMake(CGRectGetMaxX(self.minuteLabel.frame)+2, 0, 5, self.dc_height);
    self.secondLabel.frame = CGRectMake(CGRectGetMaxX(self.colonLabel2.frame), 10, 18, self.dc_height-20);
    _tipLabel.frame = CGRectMake(CGRectGetMaxX(self.secondLabel.frame)+5, 0, 100, self.dc_height);
    _quickButton.frame = CGRectMake(self.dc_width - 30, 0, 30, self.dc_height);
}

- (void)makeConstraints {
    WEAKSELF
    [self.bgIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.top.equalTo(weakSelf.mas_top);
    }];
}

-(UIImageView *)bgIV{
    if (!_bgIV) {
        _bgIV = [[UIImageView alloc] init];
        _bgIV.image = [UIImage imageNamed:@"home_title_bg"];;
        [_bgIV setContentMode:UIViewContentModeScaleAspectFill];
    }
    return _bgIV;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum16 TextColor:[UIColor whiteColor]];
    }
    return _timeLabel;
}

//- (UILabel *)countDownLabel {
//    if (!_countDownLabel) {
//        _countDownLabel = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor blackColor]];
//    }
//    return _countDownLabel;
//}

- (UILabel *)hourLabel {
    if (!_hourLabel) {
        _hourLabel = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
        _hourLabel.backgroundColor = [UIColor whiteColor];
        _hourLabel.textAlignment = NSTextAlignmentCenter;
        // 设置圆角的大小
        _hourLabel.layer.cornerRadius = 5;
        [_hourLabel.layer setMasksToBounds:YES];
    }
    return _hourLabel;
}

- (UILabel *)colonLabel1 {
    if (!_colonLabel1) {
        _colonLabel1 = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor whiteColor]];
    }
    return _colonLabel1;
}

- (UILabel *)minuteLabel {
    if (!_minuteLabel) {
        _minuteLabel = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
        _minuteLabel.backgroundColor = [UIColor whiteColor];
        _minuteLabel.textAlignment = NSTextAlignmentCenter;
        // 设置圆角的大小
        _minuteLabel.layer.cornerRadius = 5;
        [_minuteLabel.layer setMasksToBounds:YES];
    }
    return _minuteLabel;
}

- (UILabel *)colonLabel2 {
    if (!_colonLabel2) {
        _colonLabel2 = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor whiteColor]];
    }
    return _colonLabel2;
}

- (UILabel *)secondLabel {
    if (!_secondLabel) {
        _secondLabel = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
        _secondLabel.backgroundColor = [UIColor whiteColor];
        _secondLabel.textAlignment = NSTextAlignmentCenter;
        // 设置圆角的大小
        _secondLabel.layer.cornerRadius = 5;
        [_secondLabel.layer setMasksToBounds:YES];
    }
    return _secondLabel;
}


- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor whiteColor]];
    }
    return _tipLabel;
}

- (DCZuoWenRightButton *)quickButton {
    if (!_quickButton) {
        _quickButton = [DCZuoWenRightButton buttonWithType:UIButtonTypeCustom];
        _quickButton.titleLabel.font = [UIFont systemFontOfSize:kFontNum12];
        [_quickButton setImage:[UIImage imageNamed:@"home_title_white_arrow"] forState:UIControlStateNormal];
        [_quickButton addTarget:self action:@selector(lookForAllGoods) forControlEvents:UIControlEventTouchUpInside];
    }
    return _quickButton;
}

#pragma mark - 点击事件
- (void)lookForAllGoods
{
    !_lookAllBlock ? : _lookAllBlock();
}
#pragma mark - Setter Getter Methods


@end
