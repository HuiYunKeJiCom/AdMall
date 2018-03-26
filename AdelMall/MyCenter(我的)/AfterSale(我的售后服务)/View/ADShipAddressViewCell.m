//
//  ADShipAddressViewCell.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/2.
//  Copyright © 2018年 Adel. All rights reserved.
//  售后服务单详情-发货地址

#import "ADShipAddressViewCell.h"

@interface ADShipAddressViewCell()
@property (nonatomic, strong) UIView  *bgView;
/** 标题 */
@property(nonatomic,strong)UILabel *titleLab;
/** 横线 */
@property(nonatomic,strong)UIView *lineView;

/** 提示语 */
@property(nonatomic,strong)UILabel *tipLab;
/** 收货地址标题 */
@property(nonatomic,strong)UILabel *receivingAddressTitLab;
/** 收货地址 */
@property(nonatomic,strong)UILabel *receivingAddressLab;
/** 收件人标题 */
@property(nonatomic,strong)UILabel *addresseeTitLab;
/** 收件人 */
@property(nonatomic,strong)UILabel *addresseeLab;
/** 邮编标题 */
@property(nonatomic,strong)UILabel *zipCodeTitLab;
/** 邮编 */
@property(nonatomic,strong)UILabel *zipCodeLab;
/** 电话标题 */
@property(nonatomic,strong)UILabel *phoneTitLab;
/** 电话 */
@property(nonatomic,strong)UILabel *phoneLab;
@end

@implementation ADShipAddressViewCell

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
    [self.bgView addSubview:self.lineView];
    [self.bgView addSubview:self.titleLab];
    [self.bgView addSubview:self.tipLab];
    [self.bgView addSubview:self.receivingAddressTitLab];
    [self.bgView addSubview:self.receivingAddressLab];
    [self.bgView addSubview:self.addresseeTitLab];
    [self.bgView addSubview:self.addresseeLab];
    [self.bgView addSubview:self.zipCodeTitLab];
    [self.bgView addSubview:self.zipCodeLab];
    [self.bgView addSubview:self.phoneTitLab];
    [self.bgView addSubview:self.phoneLab];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self makeConstraints];
}

#pragma mark - 填充数据
-(void)setUpData{
    self.titleLab.text = @"发货地址";
    self.tipLab.text = @"请将商品邮寄至如下地址";
    self.receivingAddressTitLab.text = @"收货地址：";
    self.receivingAddressLab.text = @"深圳市宝安区松柏路南岗第二工业区";
    self.addresseeTitLab.text = @"收件人：";
    self.addresseeLab.text = @"爱迪尔售后部";
    self.zipCodeTitLab.text = @"邮编：";
    self.zipCodeLab.text = @"518000";
    self.phoneTitLab.text = @"电话：";
    self.phoneLab.text = @"075545825814";
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
    
    [self.tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(30);
        make.top.equalTo(weakSelf.lineView.mas_bottom).with.offset(5);
    }];
    
    [self.receivingAddressTitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(30);
        make.top.equalTo(weakSelf.tipLab.mas_bottom).with.offset(5);
    }];
    
    [self.receivingAddressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.receivingAddressTitLab.mas_right);
        make.top.equalTo(weakSelf.tipLab.mas_bottom).with.offset(5);
    }];
    
    [self.addresseeTitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(30);
        make.top.equalTo(weakSelf.receivingAddressTitLab.mas_bottom).with.offset(5);
    }];
    
    [self.addresseeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.addresseeTitLab.mas_right);
        make.top.equalTo(weakSelf.receivingAddressTitLab.mas_bottom).with.offset(5);
    }];
    
    [self.zipCodeTitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(30);
        make.top.equalTo(weakSelf.addresseeTitLab.mas_bottom).with.offset(5);
    }];
    
    [self.zipCodeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.zipCodeTitLab.mas_right);
        make.top.equalTo(weakSelf.addresseeTitLab.mas_bottom).with.offset(5);
    }];
    
    [self.phoneTitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(30);
        make.top.equalTo(weakSelf.zipCodeTitLab.mas_bottom).with.offset(5);
    }];
    
    [self.phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.phoneTitLab.mas_right);
        make.top.equalTo(weakSelf.zipCodeTitLab.mas_bottom).with.offset(5);
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

- (UILabel *)tipLab {
    if (!_tipLab) {
        _tipLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor lightGrayColor]];
    }
    return _tipLab;
}

- (UILabel *)receivingAddressTitLab {
    if (!_receivingAddressTitLab) {
        _receivingAddressTitLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _receivingAddressTitLab;
}

- (UILabel *)receivingAddressLab {
    if (!_receivingAddressLab) {
        _receivingAddressLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _receivingAddressLab;
}

- (UILabel *)addresseeTitLab {
    if (!_addresseeTitLab) {
        _addresseeTitLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _addresseeTitLab;
}

- (UILabel *)addresseeLab {
    if (!_addresseeLab) {
        _addresseeLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _addresseeLab;
}

- (UILabel *)zipCodeTitLab {
    if (!_zipCodeTitLab) {
        _zipCodeTitLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _zipCodeTitLab;
}

- (UILabel *)zipCodeLab {
    if (!_zipCodeLab) {
        _zipCodeLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _zipCodeLab;
}

- (UILabel *)phoneTitLab {
    if (!_phoneTitLab) {
        _phoneTitLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _phoneTitLab;
}

- (UILabel *)phoneLab {
    if (!_phoneLab) {
        _phoneLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _phoneLab;
}

@end
