//
//  ADOnSallDetailHeadView.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/16.
//  Copyright © 2018年 Adel. All rights reserved.
//  限时秒杀-抢购商品详情

#import "ADOnSallDetailHeadView.h"

@interface ADOnSallDetailHeadView()
/** 人民币 符号 */
@property(nonatomic,strong)UILabel *symbolLabel;
/** 最低价 */
@property(nonatomic,strong)UILabel *lowPriceLabel;
/** 横杠 */
@property(nonatomic,strong)UIView *lineView;
/** 最高价 */
@property(nonatomic,strong)UILabel *highPriceLabel;
/** 抢购中 */
@property (strong , nonatomic)UILabel *onSaleLabel;
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
/** 后结束 提示语 */
@property (strong , nonatomic)UILabel *tipLabel;
@end

@implementation ADOnSallDetailHeadView

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
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.symbolLabel];
    [self addSubview:self.lowPriceLabel];
    [self addSubview:self.lineView];
    [self addSubview:self.highPriceLabel];
    [self addSubview:self.onSaleLabel];
    [self addSubview:self.hourLabel];
    [self addSubview:self.colonLabel2];
    [self addSubview:self.minuteLabel];
    [self addSubview:self.colonLabel1];
    [self addSubview:self.secondLabel];
    [self addSubview:self.tipLabel];
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.symbolLabel.frame = CGRectMake(20, 0, 10, self.dc_height);
    self.lowPriceLabel.frame = CGRectMake(CGRectGetMaxX(self.symbolLabel.frame), 0, 60, self.dc_height);
    self.lineView.frame = CGRectMake(CGRectGetMaxX(self.lowPriceLabel.frame), 20, 5, 1);
    self.highPriceLabel.frame = CGRectMake(CGRectGetMaxX(self.lineView.frame), 0, 60, self.dc_height);
    self.tipLabel.frame = CGRectMake(self.dc_width-20-40, 0, 40, self.dc_height);
    self.secondLabel.frame = CGRectMake(CGRectGetMinX(self.tipLabel.frame)-5-20, 10, 18, self.dc_height-20);
    self.colonLabel2.frame = CGRectMake(CGRectGetMinX(self.secondLabel.frame)-5, 0, 5, self.dc_height);
    self.minuteLabel.frame = CGRectMake(CGRectGetMinX(self.colonLabel2.frame)-20, 10, 18, self.dc_height-20);
    self.colonLabel1.frame = CGRectMake(CGRectGetMinX(self.minuteLabel.frame)-5, 0, 5, self.dc_height);
    self.hourLabel.frame = CGRectMake(CGRectGetMinX(self.colonLabel1.frame)-20, 10, 18, self.dc_height-20);
    self.onSaleLabel.frame = CGRectMake(CGRectGetMinX(self.hourLabel.frame)-50-5, 10, 50, self.dc_height-20);
    
    
//    [self makeConstraints];
}

#pragma mark - 填充数据
-(void)setUpData{
    self.symbolLabel.text = @"¥";
    self.lowPriceLabel.text = @"1680.00";
    self.highPriceLabel.text = @"1980.00";
    self.onSaleLabel.text = @"抢购中";
    self.hourLabel.text = @"00";
    self.colonLabel2.text = @":";
    self.minuteLabel.text = @"00";
    self.colonLabel1.text = @":";
    self.secondLabel.text = @"00";
    self.tipLabel.text = @"后结束";
}

- (UILabel *)symbolLabel {
    if (!_symbolLabel) {
        _symbolLabel = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor redColor]];
    }
    return _symbolLabel;
}

- (UILabel *)lowPriceLabel {
    if (!_lowPriceLabel) {
        _lowPriceLabel = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor redColor]];
        _lowPriceLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _lowPriceLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectZero];
        _lineView.backgroundColor = [UIColor redColor];
    }
    return _lineView;
}

- (UILabel *)highPriceLabel {
    if (!_highPriceLabel) {
        _highPriceLabel = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor redColor]];
        _highPriceLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _highPriceLabel;
}

- (UILabel *)onSaleLabel {
    if (!_onSaleLabel) {
        _onSaleLabel = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor whiteColor]];
        _onSaleLabel.backgroundColor = [UIColor redColor];
        _onSaleLabel.textAlignment = NSTextAlignmentCenter;
        // 设置圆角的大小
        _onSaleLabel.layer.cornerRadius = 5;
        [_onSaleLabel.layer setMasksToBounds:YES];
    }
    return _onSaleLabel;
}

- (UILabel *)hourLabel {
    if (!_hourLabel) {
        _hourLabel = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
        _hourLabel.backgroundColor = [UIColor lightGrayColor];
        _hourLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _hourLabel;
}

- (UILabel *)colonLabel1 {
    if (!_colonLabel1) {
        _colonLabel1 = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _colonLabel1;
}

- (UILabel *)minuteLabel {
    if (!_minuteLabel) {
        _minuteLabel = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
        _minuteLabel.backgroundColor = [UIColor lightGrayColor];
        _minuteLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _minuteLabel;
}

- (UILabel *)colonLabel2 {
    if (!_colonLabel2) {
        _colonLabel2 = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _colonLabel2;
}

- (UILabel *)secondLabel {
    if (!_secondLabel) {
        _secondLabel = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
        _secondLabel.backgroundColor = [UIColor lightGrayColor];
        _secondLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _secondLabel;
}

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _tipLabel;
}

@end
