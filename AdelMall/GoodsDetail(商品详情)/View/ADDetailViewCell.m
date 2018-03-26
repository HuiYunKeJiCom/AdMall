//
//  ADDetailViewCell.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/2/7.
//  Copyright © 2018年 Adel. All rights reserved.
//  商品详情-详情-广告词

#import "ADDetailViewCell.h"

@interface ADDetailViewCell()
@property (nonatomic, strong) UIView           *bgView;
/** 商品名 */
@property(nonatomic,strong)UILabel *goodsNameLab;
/** hour */
@property(nonatomic,strong)UILabel *hourLab;
/** 冒号2 */
@property(nonatomic,strong)UILabel *intervalLab2;
/** min */
@property(nonatomic,strong)UILabel *minuteLab;
/** 冒号1 */
@property(nonatomic,strong)UILabel *intervalLab1;
/** second */
@property(nonatomic,strong)UILabel *secondLab;
/** time tip */
@property(nonatomic,strong)UILabel *timeTipLab;
/** 价格 */
@property(nonatomic,strong)UILabel *priceLab;
/** 已选择 */
@property(nonatomic,strong)UILabel *choiceLab;
/** 已选择类型 */
@property(nonatomic,strong)UILabel *typeLab;

@end

@implementation ADDetailViewCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
        [self setUpData];
    }
    return self;
}

- (void)setUpUI{
    [self addSubview:self.bgView];
    [self addSubview:self.goodsNameLab];
    [self addSubview:self.hourLab];
    [self addSubview:self.minuteLab];
    [self addSubview:self.secondLab];
    [self addSubview:self.timeTipLab];
    [self addSubview:self.priceLab];
    [self addSubview:self.intervalLab1];
    [self addSubview:self.intervalLab2];
    [self addSubview:self.choiceLab];
    [self addSubview:self.typeLab];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self makeConstraints];
}

#pragma mark - 填充数据
-(void)setUpData{
    self.goodsNameLab.text = @"ADEL爱迪尔4920 智能指纹锁";
    self.hourLab.text = @"22";
    self.minuteLab.text = @"48";
    self.secondLab.text = @"05";
    self.timeTipLab.text = @"后结束抢购";
    self.priceLab.text = @"¥ 1680.00";
    self.intervalLab1.text = @":";
    self.intervalLab2.text = @":";
    self.choiceLab.text = @"已选择:";
    self.typeLab.text = @"三合一(亮金色)";
}

- (void)makeConstraints {
    WEAKSELF
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.top.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf.mas_bottom);
    }];
    
    [self.goodsNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(10);
        make.top.equalTo(weakSelf.bgView.mas_top).with.offset(10);
    }];
    
    [self.timeTipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.bgView.mas_right).with.offset(-10);
        make.centerY.equalTo(weakSelf.goodsNameLab.mas_centerY);
    }];
    
    [self.secondLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.timeTipLab.mas_left).with.offset(-5);
        make.centerY.equalTo(weakSelf.goodsNameLab.mas_centerY);
    }];
    
    [self.intervalLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.secondLab.mas_left).with.offset(-1);
        make.centerY.equalTo(weakSelf.goodsNameLab.mas_centerY);
    }];
    
    [self.minuteLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.secondLab.mas_left).with.offset(-5);
        make.centerY.equalTo(weakSelf.goodsNameLab.mas_centerY);
    }];
    
    [self.intervalLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.minuteLab.mas_left).with.offset(-1);
        make.centerY.equalTo(weakSelf.goodsNameLab.mas_centerY);
    }];
    
    [self.hourLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.minuteLab.mas_left).with.offset(-5);
        make.centerY.equalTo(weakSelf.goodsNameLab.mas_centerY);
    }];
    
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.bgView.mas_right).with.offset(-10);
        make.top.equalTo(weakSelf.timeTipLab.mas_bottom).with.offset(10);
    }];
    
    [self.choiceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(10);
        make.centerY.equalTo(weakSelf.priceLab.mas_centerY);
    }];
    
    [self.typeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.choiceLab.mas_right).with.offset(10);
        make.centerY.equalTo(weakSelf.priceLab.mas_centerY);
    }];
    
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectZero];
        _bgView.backgroundColor = k_UIColorFromRGB(0xffffff);
    }
    return _bgView;
}

- (UILabel *)goodsNameLab {
    if (!_goodsNameLab) {
        _goodsNameLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor blackColor]];
    }
    return _goodsNameLab;
}

- (UILabel *)hourLab {
    if (!_hourLab) {
        _hourLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
        _hourLab.backgroundColor = [UIColor lightGrayColor];
    }
    return _hourLab;
}

- (UILabel *)intervalLab2 {
    if (!_intervalLab2) {
        _intervalLab2 = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _intervalLab2;
}

- (UILabel *)minuteLab {
    if (!_minuteLab) {
        _minuteLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
        _minuteLab.backgroundColor = [UIColor lightGrayColor];
    }
    return _minuteLab;
}

- (UILabel *)intervalLab1 {
    if (!_intervalLab1) {
        _intervalLab1 = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _intervalLab1;
}

- (UILabel *)secondLab {
    if (!_secondLab) {
        _secondLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
        _secondLab.backgroundColor = [UIColor lightGrayColor];
    }
    return _secondLab;
}

- (UILabel *)timeTipLab {
    if (!_timeTipLab) {
        _timeTipLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor grayColor]];
    }
    return _timeTipLab;
}

- (UILabel *)priceLab {
    if (!_priceLab) {
        _priceLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor redColor]];
    }
    return _priceLab;
}

- (UILabel *)choiceLab {
    if (!_choiceLab) {
        _choiceLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor grayColor]];
    }
    return _choiceLab;
}

- (UILabel *)typeLab {
    if (!_typeLab) {
        _typeLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor grayColor]];
    }
    return _typeLab;
}


@end
