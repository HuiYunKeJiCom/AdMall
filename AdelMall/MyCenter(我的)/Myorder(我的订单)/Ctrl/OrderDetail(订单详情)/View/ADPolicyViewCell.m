//
//  ADPolicyViewCell.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/2/9.
//  Copyright © 2018年 Adel. All rights reserved.
//  保险单信息

#import "ADPolicyViewCell.h"

@interface ADPolicyViewCell()
@property (nonatomic, strong) UIView  *bgView;
/** 标题 */
@property(nonatomic,strong)UILabel *titleLab;
/** 查看 */
@property(nonatomic,strong)UIButton *checkBtn;
@end

@implementation ADPolicyViewCell

#pragma mark - Intial
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUpUI];
        [self setUpData];
    }
    
    return self;
}

- (void)setUpUI{
    [self addSubview:self.bgView];
    [self addSubview:self.titleLab];
    [self addSubview:self.checkBtn];
    [self makeConstraints];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}

#pragma mark - 填充数据
-(void)setUpData{
    self.titleLab.text = @"保险单信息";
    [self.checkBtn setTitle:@"查看 >" forState:UIControlStateNormal];
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
        make.right.equalTo(weakSelf.bgView.mas_right).with.offset(15);
        make.centerY.equalTo(weakSelf.titleLab.mas_centerY);
        make.width.mas_equalTo(GetScaleWidth(80));
        make.height.mas_equalTo(GetScaleWidth(25));
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

#pragma mark - 查看 点击
- (void)checkButtonClick {
    !_checkBtnClickBlock ? : _checkBtnClickBlock();
}

@end
