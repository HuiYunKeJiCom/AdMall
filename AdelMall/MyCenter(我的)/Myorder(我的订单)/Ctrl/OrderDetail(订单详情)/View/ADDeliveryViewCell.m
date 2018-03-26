//
//  ADDeliveryViewCell.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/2/9.
//  Copyright © 2018年 Adel. All rights reserved.
//  发货信息

#import "ADDeliveryViewCell.h"

@interface ADDeliveryViewCell()
@property (nonatomic, strong) UIView  *bgView;
/** 标题 */
@property(nonatomic,strong)UILabel *titleLab;
/** 查看物流 */
@property(nonatomic,strong)UIButton *checkBtn;
/** 横线 */
@property(nonatomic,strong)UIView *lineView;
/** tip */
@property(nonatomic,strong)UILabel *tipLab;
/** 快递公司 */
@property(nonatomic,strong)UILabel *expressTypeLab;
/** 快递名称 */
@property(nonatomic,strong)UILabel *typeLab;
/** 快递单号 */
@property(nonatomic,strong)UILabel *expressNumLab;
/** 单号 */
@property(nonatomic,strong)UILabel *NumLab;
@end

@implementation ADDeliveryViewCell

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
    [self addSubview:self.checkBtn];
    [self addSubview:self.tipLab];
    [self addSubview:self.expressTypeLab];
    [self addSubview:self.typeLab];
    [self addSubview:self.expressNumLab];
    [self addSubview:self.NumLab];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self makeConstraints];
}

#pragma mark - 填充数据
-(void)setUpData{
    self.titleLab.text = @"发货信息";
    [self.checkBtn setTitle:@"查看物流 >" forState:UIControlStateNormal];
    self.tipLab.text = @"*订单需要发货";
    self.expressTypeLab.text = @"快递公司：";
    self.typeLab.text = @"韵达快递";
    self.expressNumLab.text = @"快递单号：";
    self.NumLab.text = @"20180209122334";
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
    
    [self.checkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.bgView.mas_right).with.offset(5);
        make.centerY.equalTo(weakSelf.titleLab.mas_centerY);
        make.width.mas_equalTo(GetScaleWidth(80));
        make.height.mas_equalTo(GetScaleWidth(25));
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.bgView.mas_centerX);
        make.top.equalTo(weakSelf.titleLab.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 1));
    }];
    
    [self.tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(30);
        make.top.equalTo(weakSelf.lineView.mas_bottom).with.offset(7);
    }];
    
    [self.expressTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(30);
        make.top.equalTo(weakSelf.tipLab.mas_bottom).with.offset(5);
    }];
    
    [self.typeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.expressTypeLab.mas_right);
        make.top.equalTo(weakSelf.tipLab.mas_bottom).with.offset(5);
    }];
    
    [self.expressNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(30);
        make.top.equalTo(weakSelf.expressTypeLab.mas_bottom).with.offset(5);
    }];
    
    [self.NumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.expressNumLab.mas_right);
        make.top.equalTo(weakSelf.expressTypeLab.mas_bottom).with.offset(5);
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

- (UIButton *)checkBtn {
    if (!_checkBtn) {
        _checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _checkBtn.titleLabel.font = [UIFont systemFontOfSize:kFontNum12];
        _checkBtn.backgroundColor = k_UIColorFromRGB(0xffffff);
        [_checkBtn setTitleColor:KColorText878686 forState:UIControlStateNormal];
        [_checkBtn addTarget:self action:@selector(checkButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _checkBtn;
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

- (UILabel *)expressTypeLab {
    if (!_expressTypeLab) {
        _expressTypeLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _expressTypeLab;
}

- (UILabel *)typeLab {
    if (!_typeLab) {
        _typeLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _typeLab;
}

- (UILabel *)expressNumLab {
    if (!_expressNumLab) {
        _expressNumLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _expressNumLab;
}

- (UILabel *)NumLab {
    if (!_NumLab) {
        _NumLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _NumLab;
}

#pragma mark - 查看物流 点击
- (void)checkButtonClick {
    !_checkBtnClickBlock ? : _checkBtnClickBlock();
}
@end
