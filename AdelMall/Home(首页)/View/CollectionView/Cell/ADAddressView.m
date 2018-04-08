//
//  ADAddressView.m
//  DropDownView(筛选框)
//
//  Created by 张锐凌 on 2018/3/15.
//  Copyright © 2018年 Mix_Reality. All rights reserved.
//

#import "ADAddressView.h"
#import "EdgeInsetsLabel.h"
#import "ADAdressModelNew.h"

@interface ADAddressView()
/** 地址 */
@property(nonatomic,strong)UILabel *addressLab;
/** 家 */
@property(nonatomic,strong)EdgeInsetsLabel *homeLab;
/** 收货人 */
@property(nonatomic,strong)UILabel *receiverLab;
/** 收 */
@property(nonatomic,strong)UILabel *acceptLab;
/** 竖线1 */
@property(nonatomic,strong)UIView *lineView1;
/** 电话 */
@property(nonatomic,strong)UILabel *phoneLab;
/** 竖线2 */
@property(nonatomic,strong)UIView *lineView2;
/** 邮编标题 */
@property(nonatomic,strong)UILabel *zipCodeTitLab;
/** 邮编 */
@property(nonatomic,strong)UILabel *zipCodeLab;
@end

@implementation ADAddressView

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
    
    [self addSubview:self.addressLab];
    [self addSubview:self.homeLab];
    [self addSubview:self.receiverLab];
    [self addSubview:self.acceptLab];
    [self addSubview:self.lineView1];
    [self addSubview:self.phoneLab];
    [self addSubview:self.lineView2];
    [self addSubview:self.zipCodeTitLab];
    [self addSubview:self.zipCodeLab];
    [self makeConstraints];
//    NSLog(@"self.homeLab = %@",NSStringFromCGRect(self.homeLab.frame));
}

- (void)setModel:(ADAdressModelNew *)model {
    _model = model;
    self.addressLab.text = model.detail_address;
//    self.homeLab.text = model.addressLabelName;
    self.receiverLab.text = model.trueName;
    self.phoneLab.text = model.mobile;
    self.zipCodeLab.text = model.post_code;
}

#pragma mark - 填充数据
-(void)setUpData{
//    self.addressLab.text = @"广东省 深圳市 宝安区 松柏路南岗第二工业区";
//    self.homeLab.text = @" 家 ";
//    self.receiverLab.text = @"黄先生";
    self.acceptLab.text = @"收";
//    self.phoneLab.text = @"137 0000 0000";
    self.zipCodeTitLab.text = @"邮编：";
//    self.zipCodeLab.text = @"518000";
    //    [self.detailBtn setTitle:@">" forState:UIControlStateNormal];
}

#pragma mark - Constraints
- (void)makeConstraints {
    WEAKSELF
    
    [self.addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(100);
        make.top.equalTo(weakSelf.mas_top).with.offset(10);
        make.width.mas_equalTo(GetScaleWidth(200));
    }];
    
//    [self.homeLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weakSelf.addressLab.mas_right).with.offset(5);
//        make.top.equalTo(weakSelf.mas_top).with.offset(10);
//    }];
    
    [self.receiverLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(100);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-10);
    }];
    
    [self.acceptLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.receiverLab.mas_right).with.offset(5);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-10);
    }];
    
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.acceptLab.mas_right).with.offset(5);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-13);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(10);
    }];
    
    [self.phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.lineView1.mas_right).with.offset(5);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-10);
    }];
    
    [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.phoneLab.mas_right).with.offset(5);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-10);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(10);
    }];
    
    [self.zipCodeTitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.lineView2.mas_right).with.offset(5);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-10);
    }];
    
    [self.zipCodeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.zipCodeTitLab.mas_right);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-10);
    }];
    
}

- (UILabel *)addressLab {
    if (!_addressLab) {
        _addressLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor lightGrayColor]];
    }
    return _addressLab;
}

- (EdgeInsetsLabel *)homeLab {
    if (!_homeLab) {
        _homeLab = [[EdgeInsetsLabel alloc] initWithFrame:CGRectMake(325, 10, 35, 16)];
        _homeLab.font = [UIFont systemFontOfSize:kFontNum12];
        _homeLab.textColor = [UIColor whiteColor];
//        _homeLab = [[EdgeInsetsLabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor whiteColor]];
        _homeLab.backgroundColor = [UIColor cyanColor];
        _homeLab.layer.cornerRadius = 3.0;
        _homeLab.layer.masksToBounds = YES;
        _homeLab.contentInset = UIEdgeInsetsMake(5, 5, 5, 5);//分别为上、左、下、右
    }
    return _homeLab;
}

- (UILabel *)receiverLab {
    if (!_receiverLab) {
        _receiverLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor lightGrayColor]];
    }
    return _receiverLab;
}

- (UILabel *)acceptLab {
    if (!_acceptLab) {
        _acceptLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor lightGrayColor]];
    }
    return _acceptLab;
}

- (UIView *)lineView1 {
    if (!_lineView1) {
        _lineView1 = [[UIView alloc] initWithFrame:CGRectZero];
        _lineView1.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineView1;
}

- (UILabel *)phoneLab {
    if (!_phoneLab) {
        _phoneLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor lightGrayColor]];
    }
    return _phoneLab;
}

- (UIView *)lineView2 {
    if (!_lineView2) {
        _lineView2 = [[UIView alloc] initWithFrame:CGRectZero];
        _lineView2.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineView2;
}

- (UILabel *)zipCodeTitLab {
    if (!_zipCodeTitLab) {
        _zipCodeTitLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor lightGrayColor]];
    }
    return _zipCodeTitLab;
}

- (UILabel *)zipCodeLab {
    if (!_zipCodeLab) {
        _zipCodeLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor lightGrayColor]];
    }
    return _zipCodeLab;
}

@end
