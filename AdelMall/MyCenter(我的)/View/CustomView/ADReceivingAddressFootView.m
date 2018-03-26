//
//  ADReceivingAddressFootView.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/9.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import "ADReceivingAddressFootView.h"

@interface ADReceivingAddressFootView()
/** 默认地址标题 */
@property(nonatomic,strong)UILabel *defaultAddressTitLab;
/** 地址 */
@property(nonatomic,strong)UILabel *addressLab;
/** 邮编标题 */
@property(nonatomic,strong)UILabel *zipCodeTitLab;
/** 邮编 */
@property(nonatomic,strong)UILabel *zipCodeLab;
/** 收货人 */
@property(nonatomic,strong)UILabel *receiverLab;
/** 收 */
@property(nonatomic,strong)UILabel *acceptLab;
/** 竖线1 */
@property(nonatomic,strong)UIView *lineView1;
/** 电话 */
@property(nonatomic,strong)UILabel *phoneLab;
/** 查看 按钮 */
@property(nonatomic,strong)UIButton *viewBtn;
@end

@implementation ADReceivingAddressFootView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
        
    }
    
    return self;
}

- (void)initViews {
    
    [self addSubview:self.defaultAddressTitLab];
    [self addSubview:self.addressLab];
    [self addSubview:self.zipCodeTitLab];
    [self addSubview:self.zipCodeLab];
    [self addSubview:self.receiverLab];
    [self addSubview:self.acceptLab];
    [self addSubview:self.lineView1];
    [self addSubview:self.phoneLab];
    [self addSubview:self.viewBtn];
    [self makeConstraints];
    [self setUpData];
    
}

-(void)setUpData{
    self.defaultAddressTitLab.text = @"默认地址";
    self.addressLab.text = @"广东省 深圳市 宝安区 松柏路南岗第二工业区";
    self.zipCodeTitLab.text = @"邮编：";
    self.zipCodeLab.text = @"518000";
    self.receiverLab.text = @"黄先生";
    self.acceptLab.text = @"收";
    self.phoneLab.text = @"137 0000 0000";
    
//    [self.evaluateBtn setTitle:@"查看>" forState:UIControlStateNormal];
    NSString *textStr = @"查看>";
    // 下划线
    NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:textStr attributes:attribtDic];
    NSRange hightlightTextRange = NSMakeRange(0, textStr.length);
    [attribtStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:hightlightTextRange];
    //赋值
    [self.viewBtn setAttributedTitle:attribtStr forState:UIControlStateNormal];
}

- (void)makeConstraints {
    WEAKSELF
    
    [self.defaultAddressTitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(85*0.5);
        make.top.equalTo(weakSelf.mas_top).with.offset(15);
    }];
    
    [self.addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(85*0.5);
        make.top.equalTo(weakSelf.defaultAddressTitLab.mas_bottom).with.offset(5);
        make.width.mas_equalTo(200);
    }];
    
    [self.zipCodeTitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.addressLab.mas_right).with.offset(10);
        make.top.equalTo(weakSelf.defaultAddressTitLab.mas_bottom).with.offset(5);
    }];
    
    [self.zipCodeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.zipCodeTitLab.mas_right);
        make.top.equalTo(weakSelf.defaultAddressTitLab.mas_bottom).with.offset(5);
    }];
    
    [self.receiverLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(85*0.5);
        make.top.equalTo(weakSelf.addressLab.mas_bottom).with.offset(5);
    }];
    
    [self.acceptLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.receiverLab.mas_right).with.offset(5);
        make.top.equalTo(weakSelf.addressLab.mas_bottom).with.offset(5);
    }];
    
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.acceptLab.mas_right).with.offset(5);
        make.top.equalTo(weakSelf.zipCodeTitLab.mas_bottom).with.offset(5);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(10);
    }];
    
    [self.phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.lineView1.mas_right).with.offset(5);
        make.top.equalTo(weakSelf.zipCodeTitLab.mas_bottom).with.offset(5);
    }];
    
    [self.viewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).with.offset(-85*0.5);
        make.top.equalTo(weakSelf.addressLab.mas_bottom);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(20);
    }];
}

- (UILabel *)defaultAddressTitLab {
    if (!_defaultAddressTitLab) {
        _defaultAddressTitLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor lightGrayColor]];
    }
    return _defaultAddressTitLab;
}

- (UILabel *)addressLab {
    if (!_addressLab) {
        _addressLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor lightGrayColor]];
    }
    return _addressLab;
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
        _lineView1.backgroundColor = kBACKGROUNDCOLOR;
    }
    return _lineView1;
}

- (UILabel *)phoneLab {
    if (!_phoneLab) {
        _phoneLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor lightGrayColor]];
    }
    return _phoneLab;
}

- (UIButton *)viewBtn {
    if (!_viewBtn) {
        _viewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _viewBtn.titleLabel.font = [UIFont systemFontOfSize:kFontNum12];
        [_viewBtn addTarget:self action:@selector(viewBtnButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _viewBtn;
}

#pragma mark - 查看 点击
- (void)viewBtnButtonClick {
//    NSLog(@"查看 点击");
    !_viewBtnClickBlock ? : _viewBtnClickBlock();
}


@end
