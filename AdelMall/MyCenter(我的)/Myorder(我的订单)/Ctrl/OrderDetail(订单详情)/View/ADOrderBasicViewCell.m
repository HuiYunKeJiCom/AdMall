//
//  ADOrderBasicViewCell.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/2/9.
//  Copyright © 2018年 Adel. All rights reserved.
//  订单基本信息

#import "ADOrderBasicViewCell.h"

@interface ADOrderBasicViewCell()
@property (nonatomic, strong) UIView  *bgView;
/** 标题 */
@property(nonatomic,strong)UILabel *titleLab;
/** 横线 */
@property(nonatomic,strong)UIView *lineView;
/** 下单日期 */
@property(nonatomic,strong)UILabel *orderDateLab;
/** 日期 */
@property(nonatomic,strong)UILabel *dateLab;
/** 订单编号 */
@property(nonatomic,strong)UILabel *orderNumLab;
/** 编号 */
@property(nonatomic,strong)UILabel *numLab;
/** 支付方式 */
@property(nonatomic,strong)UILabel *payWayLab;
/** 方式 */
@property(nonatomic,strong)UILabel *wayLab;
/** 配送方式 */
@property(nonatomic,strong)UILabel *distributionWayLab;
/** 配送 */
@property(nonatomic,strong)UILabel *distributionLab;
@end

@implementation ADOrderBasicViewCell
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
    [self addSubview:self.lineView];
    [self addSubview:self.titleLab];
    [self addSubview:self.orderDateLab];
    [self addSubview:self.dateLab];
    [self addSubview:self.orderNumLab];
    [self addSubview:self.numLab];
    [self addSubview:self.payWayLab];
    [self addSubview:self.wayLab];
    [self addSubview:self.distributionWayLab];
    [self addSubview:self.distributionLab];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self makeConstraints];
}

#pragma mark - 填充数据
-(void)setUpData{
    self.titleLab.text = @"订单基本信息：";
    self.orderDateLab.text = @"下单日期：";
    self.dateLab.text = @"2019-08-09 12:00:00";
    self.orderNumLab.text = @"订单编号：";
    self.numLab.text = @"1456346531313";
    self.payWayLab.text = @"支付方式：";
    self.wayLab.text = @"银联在线支付";
    self.distributionWayLab.text = @"配送方式：";
    self.distributionLab.text = @"快递";
}

#pragma mark - Constraints
- (void)makeConstraints {
    WEAKSELF
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.top.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf.mas_bottom);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(10);
        make.top.equalTo(weakSelf.bgView.mas_top).with.offset(10);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.bgView.mas_centerX);
        make.top.equalTo(weakSelf.titleLab.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 1));
    }];
    
    [self.orderDateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(30);
        make.top.equalTo(weakSelf.lineView.mas_bottom).with.offset(10);
    }];
    
    [self.dateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.orderDateLab.mas_right);
        make.top.equalTo(weakSelf.lineView.mas_bottom).with.offset(5);
    }];
    
    [self.orderNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(30);
        make.top.equalTo(weakSelf.orderDateLab.mas_bottom).with.offset(5);
    }];
    
    [self.numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.orderNumLab.mas_right);
        make.top.equalTo(weakSelf.orderDateLab.mas_bottom).with.offset(5);
    }];
    
    [self.payWayLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(30);
        make.top.equalTo(weakSelf.orderNumLab.mas_bottom).with.offset(25);
    }];
    
    [self.wayLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.payWayLab.mas_right);
        make.top.equalTo(weakSelf.orderNumLab.mas_bottom).with.offset(25);
    }];
    
    [self.distributionWayLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(30);
        make.top.equalTo(weakSelf.payWayLab.mas_bottom).with.offset(5);
    }];
    
    [self.distributionLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.distributionWayLab.mas_right);
        make.top.equalTo(weakSelf.payWayLab.mas_bottom).with.offset(5);
    }];

}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectZero];
        _bgView.backgroundColor = k_UIColorFromRGB(0xffffff);
    }
    return _bgView;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor blackColor]];
    }
    return _titleLab;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectZero];
        _lineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineView;
}

- (UILabel *)orderDateLab {
    if (!_orderDateLab) {
        _orderDateLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _orderDateLab;
}

- (UILabel *)dateLab {
    if (!_dateLab) {
        _dateLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _dateLab;
}

- (UILabel *)orderNumLab {
    if (!_orderNumLab) {
        _orderNumLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _orderNumLab;
}

- (UILabel *)numLab {
    if (!_numLab) {
        _numLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _numLab;
}

- (UILabel *)payWayLab {
    if (!_payWayLab) {
        _payWayLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _payWayLab;
}

- (UILabel *)wayLab {
    if (!_wayLab) {
        _wayLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _wayLab;
}

- (UILabel *)distributionWayLab {
    if (!_distributionWayLab) {
        _distributionWayLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _distributionWayLab;
}

- (UILabel *)distributionLab {
    if (!_distributionLab) {
        _distributionLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _distributionLab;
}

@end
