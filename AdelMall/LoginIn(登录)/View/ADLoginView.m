//
//  ADLoginView.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/29.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import "ADLoginView.h"
#import "UIView+animation.h"
#import "ADLImageField.h"

@interface ADLoginView()<UITextFieldDelegate>
/** 错误提示 */
@property (nonatomic, strong)UILabel *errorLabel;
/** 用户名 */
@property (nonatomic, strong) ADLImageField           *nameTextField;
/** 密码 */
@property (nonatomic, strong) ADLImageField           *passTextField;
/** 登录按钮 */
@property (nonatomic, strong) UIButton              *loginButton;
/** 忘记密码按钮 */
@property (nonatomic, strong) UIButton              *forgetButton;
/** 注册按钮 */
@property (nonatomic, strong) UIButton              *phoneButton;
@end

@implementation ADLoginView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    
    return self;
}

- (void)initViews {

    [self addSubview:self.errorLabel];
    [self addSubview:self.nameTextField];
    [self addSubview:self.passTextField];
    [self addSubview:self.loginButton];
    [self addSubview:self.forgetButton];
    [self addSubview:self.phoneButton];
    
    [self refreshView];
    
    [self makeConstraints];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self addGestureRecognizer:tap];
}

- (UILabel *)errorLabel {
    if (!_errorLabel) {
        _errorLabel = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:KColorTextDA2F2D];
    }
    return _errorLabel;
}

- (ADLImageField *)nameTextField {
    if (!_nameTextField) {
        _nameTextField = [[ADLImageField alloc] initWithFrame:CGRectZero];
        _nameTextField.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _nameTextField.textField.keyboardType = UIKeyboardTypeDefault;
        _nameTextField.textField.delegate = self;
        _nameTextField.layer.cornerRadius = GetScaleWidth(20);
        _nameTextField.layer.masksToBounds = YES;
        
        [self nameTextSelect:NO];
        
    }
    return _nameTextField;
}


- (ADLImageField *)passTextField {
    if (!_passTextField) {
        _passTextField = [[ADLImageField alloc] initWithFrame:CGRectZero];
        _passTextField.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passTextField.textField.secureTextEntry = YES;
        _passTextField.textField.delegate = self;
        _passTextField.layer.cornerRadius = GetScaleWidth(20);
        _passTextField.layer.masksToBounds = YES;
        
        [self passTextSelect:NO];
        
        
    }
    return _passTextField;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setTitleColor:KColorTextFFFFFF forState:UIControlStateNormal];
        _loginButton.titleLabel.font = [UIFont systemFontOfSize:kFontNum15];
        _loginButton.backgroundColor = KColorTextDA2F2D;
        _loginButton.layer.cornerRadius = GetScaleWidth(20);
        _loginButton.layer.masksToBounds = YES;
        [_loginButton addTarget:self action:@selector(actionLogin:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

- (UIButton *)phoneButton {
    if (!_phoneButton) {
        _phoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_phoneButton setTitleColor:KColorText333333 forState:UIControlStateNormal];
        _phoneButton.titleLabel.font = [UIFont systemFontOfSize:kFontNum14];
        [_phoneButton addTarget:self action:@selector(actionRegister:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _phoneButton;
}


- (UIButton *)forgetButton {
    if (!_forgetButton) {
        _forgetButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_forgetButton setTitleColor:KColorText333333 forState:UIControlStateNormal];
        _forgetButton.titleLabel.font = [UIFont systemFontOfSize:kFontNum14];
        [_forgetButton addTarget:self action:@selector(actionForget:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetButton;
}

- (void)makeConstraints {
    
    WEAKSELF

    float topImgY = kScreenWidth > 320 ? GetScaleWidth(103) : 90;
//    float nameTextY = kScreenWidth > 320 ? GetScaleWidth(75) : 60;
    float topImgWidth =  kScreenWidth > 320 ? GetScaleWidth(115) : 90;
    
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.mas_top).offset(topImgY+topImgWidth);
        make.left.mas_equalTo(weakSelf.mas_left).offset(GetScaleWidth(25));
        make.right.mas_equalTo(weakSelf.mas_right).offset(GetScaleWidth(-25));
        make.height.mas_equalTo(GetScaleWidth(40));
    }];
    
    [self.errorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.nameTextField.mas_top).offset(GetScaleWidth(-15));
        make.centerX.mas_equalTo(weakSelf);
    }];
    
    [self.passTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.nameTextField.mas_bottom).offset(GetScaleWidth(10));
        make.width.height.mas_equalTo(weakSelf.nameTextField);
        make.centerX.mas_equalTo(weakSelf.nameTextField);
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.passTextField.mas_bottom).offset(GetScaleWidth(30));
        make.width.height.mas_equalTo(weakSelf.nameTextField);
        make.centerX.mas_equalTo(weakSelf.nameTextField);
    }];
    
    [self.phoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.loginButton.mas_bottom).offset(5);
        make.left.mas_equalTo(weakSelf.loginButton.mas_left).offset(15);
        make.height.mas_equalTo(GetScaleWidth(20));
    }];
    
    [self.forgetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.loginButton.mas_bottom).offset(5);
        make.right.mas_equalTo(weakSelf.loginButton.mas_right).offset(-15);
        make.height.mas_equalTo(GetScaleWidth(20));
    }];
    
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (textField.superview) {
        if (textField.superview == self.nameTextField) {
            
            [self passTextSelect:NO];
            [self nameTextSelect:YES];
            
        } else if(textField.superview == self.passTextField) {
            
            [self passTextSelect:YES];
            [self nameTextSelect:NO];
            
        }
    }
    
}

- (void)nameTextSelect:(BOOL)selected {
    
    _nameTextField.imgView.image = selected ? IMAGE(@"ico_login_name_H") : IMAGE(@"ico_login_name");
    _nameTextField.lineView.backgroundColor = selected ? KColorTextDA2F2D : KColorTextEBA0A0;
    _nameTextField.textField.textColor = selected ?  KColorTextDA2F2D : KColorTextEBA0A0;
    _nameTextField.backgroundColor = selected ? KColorTextFBECEE : KColorTextFBECEE;
}

- (void)passTextSelect:(BOOL)selected {
    
    _passTextField.imgView.image = selected ? IMAGE(@"ico_login_pwd_H") : IMAGE(@"ico_login_pwd");
    _passTextField.lineView.backgroundColor = selected ? KColorTextDA2F2D : KColorTextEBA0A0;
    _passTextField.textField.textColor = selected ?  KColorTextDA2F2D : KColorTextEBA0A0;
    _passTextField.backgroundColor = selected ? KColorTextFBECEE : KColorTextFBECEE;
}

#pragma mark - public

- (void)showError:(NSString *)error {
    self.errorLabel.text = error;
}

#pragma mark - action
- (void)handleTap:(UITapGestureRecognizer *)tap
{
    [self endEditing:YES];
}

/**
 *登陆
 */
- (void)actionLogin:(UIButton *)button {
    //测试
    self.nameTextField.textField.text = @"test";
    self.passTextField.textField.text = @"123456";
    
    if ([[self.nameTextField.text trim] isEmptyOrNull]) {
        self.nameTextField.textField.text = @"";
        [self.nameTextField animateShake];
        _errorLabel.text = KLocalizableStr(@"用户名不能为空");
        return;
    }
    
    if ([[self.passTextField.text trim] isEmptyOrNull]) {
        self.passTextField.textField.text = @"";
        [self.passTextField animateShake];
        _errorLabel.text = KLocalizableStr(@"密码不能为空");
        return;
    } else {
        NSString *reg = @"^[a-zA-Z0-9_]{6,20}$";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", reg];
        if (![predicate evaluateWithObject:[self.passTextField.text trim]]) {
            _errorLabel.text = KLocalizableStr(@"6-20位数，数字字母组合");
            return;
        }
    }
    

    
    [self endEditing:YES];
    _errorLabel.text = @"";
    if (self.delegate && [self.delegate respondsToSelector:@selector(loginView:userName:pwd:)]) {
        [self.delegate loginView:self userName:[self.nameTextField.text trim] pwd:[self.passTextField.text trim]];
    }
}

- (void)actionRegister:(UIButton *)button {
    
    [self handleType:UseLoginTypeRegister];
}

- (void)actionForget:(UIButton *)button {
    [self handleType:UseLoginTypeForget];
}

- (void)handleType:(UseLoginType)type {
    [self endEditing:YES];
    
    if ([self.delegate respondsToSelector:@selector(loginView:eventType:)]) {
//        [self.delegate loginView:self eventType:type];
    }
}

- (void)refreshView {
    
    self.errorLabel.text = @"";

    [self.nameTextField placeholder:KLocalizableStr(@"用户名") color:KColorTextEBA0A0];
    [self.passTextField placeholder:KLocalizableStr(@"密码") color:KColorTextEBA0A0];
    [self.loginButton setTitle:KLocalizableStr(@"登录") forState:UIControlStateNormal];
    [self.phoneButton setTitle:KLocalizableStr(@"注册账号") forState:UIControlStateNormal];
    [self.forgetButton setTitle:KLocalizableStr(@"忘记密码") forState:UIControlStateNormal];
}

@end
