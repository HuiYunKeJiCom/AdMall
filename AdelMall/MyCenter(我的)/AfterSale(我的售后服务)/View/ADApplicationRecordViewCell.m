//
//  ADApplicationRecordViewCell.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/2.
//  Copyright © 2018年 Adel. All rights reserved.
//  售后服务单详情-售后申请记录

#import "ADApplicationRecordViewCell.h"

@interface ADApplicationRecordViewCell()
@property (nonatomic, strong) UIView  *bgView;
/** 标题 */
@property(nonatomic,strong)UILabel *titleLab;
/** 横线 */
@property(nonatomic,strong)UIView *lineView;
/** 售后类型标题 */
@property(nonatomic,strong)UILabel *afterSaleTypeTitLab;
/** 售后类型 */
@property(nonatomic,strong)UILabel *afterSaleTypeLab;
/** 商品问题类型标题 */
@property(nonatomic,strong)UILabel *problemTypesTitLab;
/** 商品问题类型 */
@property(nonatomic,strong)UILabel *problemTypesLab;
/** 原因说明标题 */
@property(nonatomic,strong)UILabel *reasonExplanationTitLab;
/** 原因说明 */
@property(nonatomic,strong)UILabel *reasonExplanationLab;
/** 原订单收货地址标题 */
@property(nonatomic,strong)UILabel *oldReceivingAddressTitLab;
/** 原订单收货地址 */
@property(nonatomic,strong)UILabel *oldReceivingAddressLab;
/** 取件地址标题 */
@property(nonatomic,strong)UILabel *receivingAddressTitLab;
/** 取件地址 */
@property(nonatomic,strong)UILabel *receivingAddressLab;
/** 联系人标题 */
@property(nonatomic,strong)UILabel *contactsTitLab;
/** 联系人 */
@property(nonatomic,strong)UILabel *contactsLab;
/** 联系手机标题 */
@property(nonatomic,strong)UILabel *contactPhoneTitLab;
/** 联系手机 */
@property(nonatomic,strong)UILabel *contactPhoneLab;
@end

@implementation ADApplicationRecordViewCell

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
    [self.bgView addSubview:self.titleLab];
    [self.bgView addSubview:self.lineView];
    [self.bgView addSubview:self.afterSaleTypeTitLab];
    [self.bgView addSubview:self.afterSaleTypeLab];
    [self.bgView addSubview:self.problemTypesTitLab];
    [self.bgView addSubview:self.problemTypesLab];
    [self.bgView addSubview:self.reasonExplanationTitLab];
    [self.bgView addSubview:self.reasonExplanationLab];
    [self.bgView addSubview:self.oldReceivingAddressTitLab];
    [self.bgView addSubview:self.oldReceivingAddressLab];
    [self.bgView addSubview:self.receivingAddressTitLab];
    [self.bgView addSubview:self.receivingAddressLab];
    [self.bgView addSubview:self.contactsTitLab];
    [self.bgView addSubview:self.contactsLab];
    [self.bgView addSubview:self.contactPhoneTitLab];
    [self.bgView addSubview:self.contactPhoneLab];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self makeConstraints];
}

#pragma mark - 填充数据
-(void)setUpData{
    self.titleLab.text = @"售后申请记录";
    self.afterSaleTypeTitLab.text = @"售后类型：";
    self.afterSaleTypeLab.text = @"退款";
    self.problemTypesTitLab.text = @"商品问题类型：";
    self.problemTypesLab.text = @"外观损坏";
    self.reasonExplanationTitLab.text = @"原因说明：";
    self.reasonExplanationLab.text = @"收到货时，外观掉漆了";
    self.oldReceivingAddressTitLab.text = @"原订单收货地址：";
    self.oldReceivingAddressLab.text = @"广东深圳市南山区华侨新村26号楼602";
    self.receivingAddressTitLab.text = @"取件地址：";
    self.reasonExplanationLab.text = @"广东深圳市南山区华侨新村26号楼602";
    self.contactsTitLab.text = @"联系人：";
    self.contactsLab.text = @"王先生";
    self.contactPhoneTitLab.text = @"联系人手机：";
    self.contactPhoneLab.text = @"159****8917";
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
    
    [self.afterSaleTypeTitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(30);
        make.top.equalTo(weakSelf.lineView.mas_bottom).with.offset(5);
    }];
    
    [self.afterSaleTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.afterSaleTypeTitLab.mas_right);
        make.top.equalTo(weakSelf.lineView.mas_bottom).with.offset(5);
    }];
    
    [self.problemTypesTitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(30);
        make.top.equalTo(weakSelf.afterSaleTypeTitLab.mas_bottom).with.offset(5);
    }];
    
    [self.problemTypesLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.problemTypesTitLab.mas_right);
        make.top.equalTo(weakSelf.afterSaleTypeTitLab.mas_bottom).with.offset(5);
    }];
    
    [self.reasonExplanationTitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(30);
        make.top.equalTo(weakSelf.problemTypesTitLab.mas_bottom).with.offset(5);
    }];
    
    [self.reasonExplanationLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.reasonExplanationTitLab.mas_right);
        make.top.equalTo(weakSelf.problemTypesTitLab.mas_bottom).with.offset(5);
    }];
    
    [self.oldReceivingAddressTitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(30);
        make.top.equalTo(weakSelf.reasonExplanationTitLab.mas_bottom).with.offset(5);
    }];
    
    [self.oldReceivingAddressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.oldReceivingAddressTitLab.mas_right);
        make.top.equalTo(weakSelf.reasonExplanationTitLab.mas_bottom).with.offset(5);
    }];
    
    [self.receivingAddressTitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(30);
        make.top.equalTo(weakSelf.oldReceivingAddressTitLab.mas_bottom).with.offset(5);
    }];
    
    [self.receivingAddressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.receivingAddressTitLab.mas_right);
        make.top.equalTo(weakSelf.oldReceivingAddressTitLab.mas_bottom).with.offset(5);
    }];
    
    [self.contactsTitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(30);
        make.top.equalTo(weakSelf.receivingAddressTitLab.mas_bottom).with.offset(5);
    }];
    
    [self.contactsLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contactsTitLab.mas_right);
        make.top.equalTo(weakSelf.receivingAddressTitLab.mas_bottom).with.offset(5);
    }];
    
    [self.contactPhoneTitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(30);
        make.top.equalTo(weakSelf.contactsTitLab.mas_bottom).with.offset(5);
    }];
    
    [self.contactPhoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contactPhoneTitLab.mas_right);
        make.top.equalTo(weakSelf.contactsTitLab.mas_bottom).with.offset(5);
    }];
    
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectZero];
        _bgView.backgroundColor = kBACKGROUNDCOLOR;
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

- (UILabel *)afterSaleTypeTitLab {
    if (!_afterSaleTypeTitLab) {
        _afterSaleTypeTitLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _afterSaleTypeTitLab;
}

- (UILabel *)afterSaleTypeLab {
    if (!_afterSaleTypeLab) {
        _afterSaleTypeLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _afterSaleTypeLab;
}

- (UILabel *)problemTypesTitLab {
    if (!_problemTypesTitLab) {
        _problemTypesTitLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _problemTypesTitLab;
}

- (UILabel *)problemTypesLab {
    if (!_problemTypesLab) {
        _problemTypesLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _problemTypesLab;
}

- (UILabel *)reasonExplanationTitLab {
    if (!_reasonExplanationTitLab) {
        _reasonExplanationTitLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _reasonExplanationTitLab;
}

- (UILabel *)reasonExplanationLab {
    if (!_reasonExplanationLab) {
        _reasonExplanationLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _reasonExplanationLab;
}

- (UILabel *)oldReceivingAddressTitLab {
    if (!_oldReceivingAddressTitLab) {
        _oldReceivingAddressTitLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _oldReceivingAddressTitLab;
}

- (UILabel *)oldReceivingAddressLab {
    if (!_oldReceivingAddressLab) {
        _oldReceivingAddressLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _oldReceivingAddressLab;
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

- (UILabel *)contactsTitLab {
    if (!_contactsTitLab) {
        _contactsTitLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _contactsTitLab;
}

- (UILabel *)contactsLab {
    if (!_contactsLab) {
        _contactsLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _contactsLab;
}

- (UILabel *)contactPhoneTitLab {
    if (!_contactPhoneTitLab) {
        _contactPhoneTitLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _contactPhoneTitLab;
}

- (UILabel *)contactPhoneLab {
    if (!_contactPhoneLab) {
        _contactPhoneLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _contactPhoneLab;
}

@end
