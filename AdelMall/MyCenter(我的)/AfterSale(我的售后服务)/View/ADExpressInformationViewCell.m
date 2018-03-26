//
//  ADExpressInformationViewCell.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/2.
//  Copyright © 2018年 Adel. All rights reserved.
//  售后服务单详情-快递单信息

#import "ADExpressInformationViewCell.h"

@interface ADExpressInformationViewCell()
@property (nonatomic, strong) UIView  *bgView;
/** 标题 */
@property(nonatomic,strong)UILabel *titleLab;
/** 横线 */
@property(nonatomic,strong)UIView *lineView;

/** 快递公司 标题 */
@property(nonatomic,strong)UILabel *expressCompanyLab;
/** 快递公司输入框 */
@property(nonatomic,strong)UITextField *expressCompanyTF;
/** 快递费用 标题 */
@property(nonatomic,strong)UILabel *expressCostLab;
/** 快递费用输入框 */
@property(nonatomic,strong)UITextField *expressCostTF;
/** 快递单号 标题 */
@property(nonatomic,strong)UILabel *expressNumLab;
/** 快递单号输入框 */
@property(nonatomic,strong)UITextField *expressNumTF;
/** 提交 */
@property(nonatomic,strong)UIButton *submitBtn;
/** 删除 */
@property(nonatomic,strong)UIButton *deleteBtn;
@end

@implementation ADExpressInformationViewCell

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
    [self addSubview:self.expressCompanyLab];
    [self addSubview:self.expressCostLab];
    [self addSubview:self.expressNumLab];
    [self addSubview:self.expressCompanyTF];
    [self addSubview:self.expressCostTF];
    [self addSubview:self.expressNumTF];
    [self addSubview:self.submitBtn];
    [self addSubview:self.deleteBtn];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self makeConstraints];
}

#pragma mark - 填充数据
-(void)setUpData{
    self.titleLab.text = @"快递单信息";
    [self.submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [self.deleteBtn setTitle:@"清除" forState:UIControlStateNormal];
    NSString *expressCompany = @"*快递公司";
    NSString *expressCost = @"*快递费用";
    NSString *expressNum = @"*快递单号";
//    self.expressCompanyLab.text = @"*快递公司";
    self.expressCostLab.text = expressCost;
    self.expressNumLab.text = expressNum;
    
    NSArray *tempArr = [expressCompany componentsSeparatedByString:@"快"];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:expressCompany];
    //修改颜色
    [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, ((NSString *)tempArr[0]).length)];
    [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(((NSString *)tempArr[0]).length, ((NSString *)tempArr[1]).length+1)];
    self.expressCompanyLab.attributedText = AttributedStr;
    
    NSArray *tempArr1 = [expressCost componentsSeparatedByString:@"快"];
    NSMutableAttributedString *AttributedStr1 = [[NSMutableAttributedString alloc]initWithString:expressCost];
    //修改颜色
    [AttributedStr1 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, ((NSString *)tempArr1[0]).length)];
    [AttributedStr1 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(((NSString *)tempArr1[0]).length, ((NSString *)tempArr1[1]).length+1)];
    self.expressCostLab.attributedText = AttributedStr1;
    
    NSArray *tempArr2 = [expressNum componentsSeparatedByString:@"快"];
    NSMutableAttributedString *AttributedStr2 = [[NSMutableAttributedString alloc]initWithString:expressNum];
    //修改颜色
    [AttributedStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, ((NSString *)tempArr2[0]).length)];
    [AttributedStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(((NSString *)tempArr2[0]).length, ((NSString *)tempArr2[1]).length+1)];
    self.expressNumLab.attributedText = AttributedStr2;
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
    
    [self.expressCompanyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(30);
        make.top.equalTo(weakSelf.lineView.mas_bottom).with.offset(10);
    }];
    
    [self.expressCostLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(30);
        make.top.equalTo(weakSelf.expressCompanyLab.mas_bottom).with.offset(15);
    }];
    
    [self.expressNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(30);
        make.top.equalTo(weakSelf.expressCostLab.mas_bottom).with.offset(15);
    }];
    
    [self.expressCompanyTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.expressCompanyLab.mas_top);
        make.bottom.equalTo(weakSelf.expressCompanyLab.mas_bottom);
        make.right.equalTo(weakSelf.bgView.mas_right).with.offset(-40);
        make.width.mas_equalTo(kScreenWidth*0.68);
    }];
    
    [self.expressCostTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.expressCostLab.mas_top);
        make.bottom.equalTo(weakSelf.expressCostLab.mas_bottom);
        make.right.equalTo(weakSelf.bgView.mas_right).with.offset(-40);
        make.width.mas_equalTo(kScreenWidth*0.68);
    }];
    
    [self.expressNumTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.expressNumLab.mas_top);
        make.bottom.equalTo(weakSelf.expressNumLab.mas_bottom);
        make.right.equalTo(weakSelf.bgView.mas_right).with.offset(-40);
        make.width.mas_equalTo(kScreenWidth*0.68);
    }];
    
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(30);
        make.top.equalTo(weakSelf.expressNumLab.mas_bottom).with.offset(15);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(25);
    }];
    
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.bgView.mas_right).with.offset(-40);
        make.top.equalTo(weakSelf.expressNumLab.mas_bottom).with.offset(15);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(25);
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

- (UILabel *)expressCompanyLab {
    if (!_expressCompanyLab) {
        _expressCompanyLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _expressCompanyLab;
}

- (UILabel *)expressCostLab {
    if (!_expressCostLab) {
        _expressCostLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _expressCostLab;
}

- (UILabel *)expressNumLab {
    if (!_expressNumLab) {
        _expressNumLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _expressNumLab;
}

- (UITextField *)expressCompanyTF {
    if (!_expressCompanyTF) {
        _expressCompanyTF = [[UITextField alloc] initWithFrame:CGRectZero];
        _expressCompanyTF.font = [UIFont systemFontOfSize:12];
        _expressCompanyTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _expressCompanyTF.placeholder = @"请选择";
        _expressCompanyTF.textColor = [UIColor lightGrayColor];
        _expressCompanyTF.backgroundColor = [UIColor whiteColor];
        _expressCompanyTF.layer.borderWidth = 1.0f;
        _expressCompanyTF.layer.cornerRadius = 5;
        _expressCompanyTF.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        UIView *paddingView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 25)];
        _expressCompanyTF.leftView = paddingView;
        _expressCompanyTF.leftViewMode = UITextFieldViewModeAlways;
    }
    return _expressCompanyTF;
}

- (UITextField *)expressCostTF {
    if (!_expressCostTF) {
        _expressCostTF = [[UITextField alloc] initWithFrame:CGRectZero];
        _expressCostTF.font = [UIFont systemFontOfSize:12];
        _expressCostTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _expressCostTF.placeholder = @"请输入";
        _expressCostTF.textColor = [UIColor lightGrayColor];
        _expressCostTF.backgroundColor = [UIColor whiteColor];
        _expressCostTF.layer.borderWidth = 1.0f;
        _expressCostTF.layer.cornerRadius = 5;
        _expressCostTF.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        UIView *paddingView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 25)];
        _expressCostTF.leftView = paddingView;
        _expressCostTF.leftViewMode = UITextFieldViewModeAlways;
    }
    return _expressCostTF;
}

- (UITextField *)expressNumTF {
    if (!_expressNumTF) {
        _expressNumTF = [[UITextField alloc] initWithFrame:CGRectZero];
        _expressNumTF.font = [UIFont systemFontOfSize:12];
        _expressNumTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _expressNumTF.placeholder = @"请输入";
        _expressNumTF.textColor = [UIColor lightGrayColor];
        _expressNumTF.backgroundColor = [UIColor whiteColor];
        _expressNumTF.layer.borderWidth = 1.0f;
        _expressNumTF.layer.cornerRadius = 5;
        _expressNumTF.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        UIView *paddingView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 25)];
        _expressNumTF.leftView = paddingView;
        _expressNumTF.leftViewMode = UITextFieldViewModeAlways;
    }
    return _expressNumTF;
}

- (UIButton *)deleteBtn {
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteBtn.titleLabel.font = [UIFont systemFontOfSize:kFontNum12];
        _deleteBtn.backgroundColor = KBGCOLOR;
        [_deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [_deleteBtn addTarget:self action:@selector(submitButtonClick) forControlEvents:UIControlEventTouchUpInside];
        // 设置圆角的大小
        _deleteBtn.layer.cornerRadius = 5;
        [_deleteBtn.layer setMasksToBounds:YES];
    }
    return _deleteBtn;
}

- (UIButton *)submitBtn {
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:kFontNum12];
        _submitBtn.backgroundColor = BASECOLOR_RED;
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitBtn addTarget:self action:@selector(submitButtonClick) forControlEvents:UIControlEventTouchUpInside];
        // 设置圆角的大小
        _submitBtn.layer.cornerRadius = 5;
        [_submitBtn.layer setMasksToBounds:YES];
    }
    return _submitBtn;
}

#pragma mark - 提交 点击
- (void)submitButtonClick {
    !_submitBtnClickBlock ? : _submitBtnClickBlock();
}
@end
