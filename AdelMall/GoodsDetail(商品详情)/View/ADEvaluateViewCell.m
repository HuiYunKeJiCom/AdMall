//
//  ADEvaluateViewCell.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/2/26.
//  Copyright © 2018年 Adel. All rights reserved.
//  商品详情-用户评论-评论cell

#import "ADEvaluateViewCell.h"

@interface ADEvaluateViewCell()
@property (nonatomic, strong) UIView           *bgView;
/** 用户头像 */
@property(nonatomic,strong)UIImageView *headerIV;
/** 用户名称 */
@property(nonatomic,strong)UILabel *userNameLab;
/** 购买日期标题 */
@property(nonatomic,strong)UILabel *purchaseDateTitLab;
/** 购买日期 */
@property(nonatomic,strong)UILabel *purchaseDateLab;
/** 评论内容 */
@property(nonatomic,strong)UILabel *contentLab;
/** 评论按钮 */
@property(nonatomic,strong)UIButton *evaluateBtn;
@end

@implementation ADEvaluateViewCell
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
    [self.bgView addSubview:self.headerIV];
    [self.bgView addSubview:self.userNameLab];
    [self.bgView addSubview:self.purchaseDateTitLab];
    [self.bgView addSubview:self.purchaseDateLab];
    [self.bgView addSubview:self.contentLab];
    [self.bgView addSubview:self.evaluateBtn];
    [self createLabelAndButton];
}

-(void)createLabelAndButton{
    for(int i=0;i<2;i++){
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        button.backgroundColor = button.tag == 0 ? [UIColor cyanColor] : [UIColor lightGrayColor];
        button.userInteractionEnabled = NO;
        [button setTitle:@"商品包装好看" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:kFontNum14];
        CGFloat buttonW = kScreenWidth/3.5;
        CGFloat buttonH = 20;
        CGFloat buttonX = (20+(buttonW +10)* (i%3));
        CGFloat buttonY = (70+25 * (i/3));
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        button.layer.borderWidth=0.5;
        button.layer.borderColor=[UIColor grayColor].CGColor;
        // 设置圆角的大小
        button.layer.cornerRadius = 5;
        [button.layer setMasksToBounds:YES];
        [self.bgView addSubview:button];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self makeConstraints];
}

#pragma mark - 填充数据
-(void)setUpData{
    self.userNameLab.text = @"Pakho";
    self.purchaseDateTitLab.text = @"购买日期：";
    self.purchaseDateLab.text = @"2017-01-01";
    self.contentLab.text = @"第一次购买爱迪尔门锁，质量好的没的说，期望平台能有更多的活动优惠。";
    [self.evaluateBtn setTitle:@"评论 (4）" forState:UIControlStateNormal];
}

- (void)makeConstraints {
    WEAKSELF
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.top.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf.mas_bottom);
    }];
    
    [self.headerIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(10);
        make.top.equalTo(weakSelf.bgView.mas_top).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [self.userNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.headerIV.mas_right).with.offset(10);
        make.centerY.equalTo(weakSelf.headerIV.mas_centerY);
    }];
    
    [self.purchaseDateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.bgView.mas_right).with.offset(-15);
        make.centerY.equalTo(weakSelf.headerIV.mas_centerY);
    }];
    
    [self.purchaseDateTitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.purchaseDateLab.mas_left);
        make.centerY.equalTo(weakSelf.headerIV.mas_centerY);
    }];
    
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(20);
        make.right.equalTo(weakSelf.bgView.mas_right).with.offset(-30);
        make.top.equalTo(weakSelf.headerIV.mas_bottom).with.offset(40);
    }];
    
    [self.evaluateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.bgView.mas_right).with.offset(-15);
        make.bottom.equalTo(weakSelf.bgView.mas_bottom).with.offset(-15);
        make.width.mas_equalTo(GetScaleWidth(70));
        make.height.mas_equalTo(30);
    }];
    
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectZero];
        _bgView.backgroundColor = k_UIColorFromRGB(0xffffff);
    }
    return _bgView;
}

-(UIImageView *)headerIV{
    if (!_headerIV) {
        _headerIV = [[UIImageView alloc] init];
        [_headerIV setBackgroundColor:[UIColor greenColor]];
        [_headerIV setContentMode:UIViewContentModeScaleAspectFill];
        // 设置圆角的大小
        _headerIV.layer.cornerRadius = 5;
        [_headerIV.layer setMasksToBounds:YES];
    }
    return _headerIV;
}

- (UILabel *)userNameLab {
    if (!_userNameLab) {
        _userNameLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor blackColor]];
    }
    return _userNameLab;
}

- (UILabel *)purchaseDateTitLab {
    if (!_purchaseDateTitLab) {
        _purchaseDateTitLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor lightGrayColor]];
    }
    return _purchaseDateTitLab;
}

- (UILabel *)purchaseDateLab {
    if (!_purchaseDateLab) {
        _purchaseDateLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor lightGrayColor]];
    }
    return _purchaseDateLab;
}

- (UILabel *)contentLab {
    if (!_contentLab) {
        _contentLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor blackColor]];
        _contentLab.numberOfLines = 0;
    }
    return _contentLab;
}

- (UIButton *)evaluateBtn {
    if (!_evaluateBtn) {
        _evaluateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _evaluateBtn.titleLabel.font = [UIFont systemFontOfSize:kFontNum14];
        _evaluateBtn.backgroundColor = [UIColor redColor];
        // 设置圆角的大小
        _evaluateBtn.layer.cornerRadius = 5;
        [_evaluateBtn.layer setMasksToBounds:YES];
        [_evaluateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_evaluateBtn addTarget:self action:@selector(evaluateBtnButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _evaluateBtn;
}

#pragma mark - 评论 点击
- (void)evaluateBtnButtonClick {
    NSLog(@"评论 点击");
    !_evaluateBtnClickBlock ? : _evaluateBtnClickBlock();
}

@end
