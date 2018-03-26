//
//  ADEvaluateBottomView.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/8.
//  Copyright © 2018年 Adel. All rights reserved.
//  商品详情-用户评论-评论详情-底部View

#import "ADEvaluateBottomView.h"

@interface ADEvaluateBottomView()
/** 评论内容 */
@property(nonatomic,strong)UITextField *evaluateContentTF;
/** 评论 按钮 */
@property(nonatomic,strong)UIButton *evaluateBtn;
@property (nonatomic, readonly, copy) NSString         *text;
@end

@implementation ADEvaluateBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
        
    }
    
    return self;
}

- (void)initViews {
    
    [self addSubview:self.evaluateContentTF];
    [self addSubview:self.evaluateBtn];
    [self makeConstraints];
    [self setUpData];
    
}

-(void)setUpData{
    [self.evaluateBtn setTitle:@"评论" forState:UIControlStateNormal];
}

- (void)makeConstraints {
    WEAKSELF
    
    [self.evaluateContentTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.left.mas_equalTo(weakSelf.mas_left);
        make.width.mas_equalTo(kScreenWidth*0.8);
        make.height.mas_equalTo(49);
    }];
    
    [self.evaluateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.width.mas_equalTo(kScreenWidth*0.2);
        make.height.mas_equalTo(49);
    }];
}

- (NSString *)text {
    return self.evaluateContentTF.text;
}

- (UITextField *)evaluateContentTF {
    if (!_evaluateContentTF) {
        _evaluateContentTF = [[UITextField alloc] initWithFrame:CGRectZero];
        _evaluateContentTF.font = [UIFont systemFontOfSize:14];
        _evaluateContentTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _evaluateContentTF.placeholder = @"回复楼主";
        _evaluateContentTF.textColor = [UIColor lightGrayColor];
        _evaluateContentTF.backgroundColor = [UIColor whiteColor];
    
        UIView *paddingView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 49)];
        _evaluateContentTF.leftView = paddingView;
        _evaluateContentTF.leftViewMode = UITextFieldViewModeAlways;
    }
    return _evaluateContentTF;
}

- (UIButton *)evaluateBtn {
    if (!_evaluateBtn) {
        _evaluateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _evaluateBtn.titleLabel.font = [UIFont systemFontOfSize:kFontNum14];
        _evaluateBtn.backgroundColor = [UIColor redColor];
        // 设置圆角的大小
//        _evaluateBtn.layer.cornerRadius = 5;
//        [_evaluateBtn.layer setMasksToBounds:YES];
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
