//
//  ADAddressShowView.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/20.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import "ADAddressShowView.h"
#import "ADAdressModelNew.h"

@interface ADAddressShowView()
/** 收货人 标题 */
@property(nonatomic,strong)UILabel *receiverTitLab;
/** 收货人 */
@property(nonatomic,strong)UILabel *receiverLab;
/** 地址 标题 */
@property(nonatomic,strong)UILabel *addressTitLab;
/** 地址 */
@property(nonatomic,strong)UILabel *addressLab;
@end

@implementation ADAddressShowView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
        [self setUpData];
    }
    
    return self;
}

- (void)initViews {
//    self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
//    self.titleLab.font = [UIFont systemFontOfSize:14];
//    self.titleLab.textAlignment = NSTextAlignmentCenter;
//    self.titleLab.textColor = [UIColor blackColor];
//    [self addSubview:self.titleLab];
    //    [self setUpDictionary:self.dict];
    
    [self addSubview:self.receiverTitLab];
    [self addSubview:self.receiverLab];
    [self addSubview:self.addressTitLab];
    [self addSubview:self.addressLab];
    [self makeConstraints];
}

- (void)setModel:(ADAdressModelNew *)model {
    _model = model;
    self.receiverLab.text = model.trueName;
    self.addressLab.text = model.detail_address;
}

#pragma mark - 填充数据
-(void)setUpData{
    self.receiverTitLab.text = @"收货人：";
    self.addressTitLab.text = @"地址：";
}

#pragma mark - Constraints
- (void)makeConstraints {
    WEAKSELF
    [self.receiverTitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(20);
        make.top.equalTo(weakSelf.mas_top).with.offset(10);
    }];
    
    [self.receiverLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.receiverTitLab.mas_right);
        make.top.equalTo(weakSelf.mas_top).with.offset(10);
    }];
    
    [self.addressTitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.receiverLab.mas_right).with.offset(5);
        make.top.equalTo(weakSelf.mas_top).with.offset(10);
    }];
    
    [self.addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.addressTitLab.mas_right);
        make.top.equalTo(weakSelf.mas_top).with.offset(10);
        make.width.mas_equalTo(GetScaleWidth(200));
    }];
}

- (UILabel *)receiverTitLab {
    if (!_receiverTitLab) {
        _receiverTitLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor blackColor]];
    }
    return _receiverTitLab;
}

- (UILabel *)receiverLab {
    if (!_receiverLab) {
        _receiverLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor blackColor]];
    }
    return _receiverLab;
}

- (UILabel *)addressTitLab {
    if (!_addressTitLab) {
        _addressTitLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor blackColor]];
    }
    return _addressTitLab;
}

- (UILabel *)addressLab {
    if (!_addressLab) {
        _addressLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor blackColor]];
    }
    return _addressLab;
}
@end
