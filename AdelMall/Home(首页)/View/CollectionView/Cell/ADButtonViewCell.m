//
//  ADButtonViewCell.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/2/28.
//  Copyright © 2018年 Adel. All rights reserved.
//  首页-按钮

#import "ADButtonViewCell.h"

@interface ADButtonViewCell()
@property (nonatomic, strong) UIView* bgView;
/** 选购门锁 */
@property(nonatomic,strong)UIButton *chooseBtn;
/** 企业团购 */
@property(nonatomic,strong)UIButton *groupPurchaseBtn;
/** 限时特价 */
@property(nonatomic,strong)UIButton *onSaleBtn;
/** 爱迪尔服务 */
@property(nonatomic,strong)UIButton *serviceBtn;
/** 以旧换新 */
@property(nonatomic,strong)UIButton *exchangeBtn;
/** 售后政策 */
@property(nonatomic,strong)UIButton *afterSaleBtn;
@end

@implementation ADButtonViewCell

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
    [self.bgView addSubview:self.chooseBtn];
    [self.bgView addSubview:self.groupPurchaseBtn];
    [self.bgView addSubview:self.onSaleBtn];
    [self.bgView addSubview:self.serviceBtn];
    [self.bgView addSubview:self.exchangeBtn];
    [self.bgView addSubview:self.afterSaleBtn];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self makeConstraints];
}

#pragma mark - 填充数据
-(void)setUpData{
    [self.chooseBtn setTitle:@"选购门锁" forState:UIControlStateNormal];
    [self.groupPurchaseBtn setTitle:@"企业团购" forState:UIControlStateNormal];
    [self.onSaleBtn setTitle:@"限时特价" forState:UIControlStateNormal];
    [self.serviceBtn setTitle:@"爱迪尔服务" forState:UIControlStateNormal];
    [self.exchangeBtn setTitle:@"以旧换新" forState:UIControlStateNormal];
    [self.afterSaleBtn setTitle:@"售后政策" forState:UIControlStateNormal];
}

- (void)makeConstraints {
    WEAKSELF
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.top.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf.mas_bottom);
    }];
    
    [self.chooseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(5);
        make.centerY.equalTo(weakSelf.bgView.mas_centerY);
        make.width.mas_equalTo((kScreenWidth-60)/6.0);
        make.height.mas_equalTo(40);
    }];
    
    [self.groupPurchaseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.chooseBtn.mas_right).with.offset(10);
        make.centerY.equalTo(weakSelf.bgView.mas_centerY);
        make.width.mas_equalTo((kScreenWidth-60)/6.0);
        make.height.mas_equalTo(40);
    }];
    
    [self.onSaleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.groupPurchaseBtn.mas_right).with.offset(10);
        make.centerY.equalTo(weakSelf.bgView.mas_centerY);
        make.width.mas_equalTo((kScreenWidth-60)/6.0);
        make.height.mas_equalTo(40);
    }];
    
    [self.serviceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.onSaleBtn.mas_right).with.offset(10);
        make.centerY.equalTo(weakSelf.bgView.mas_centerY);
        make.width.mas_equalTo((kScreenWidth-60)/6.0);
        make.height.mas_equalTo(40);
    }];
    
    [self.exchangeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.serviceBtn.mas_right).with.offset(10);
        make.centerY.equalTo(weakSelf.bgView.mas_centerY);
        make.width.mas_equalTo((kScreenWidth-60)/6.0);
        make.height.mas_equalTo(40);
    }];
    
    [self.afterSaleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.exchangeBtn.mas_right).with.offset(10);
        make.centerY.equalTo(weakSelf.bgView.mas_centerY);
        make.width.mas_equalTo((kScreenWidth-60)/6.0);
        make.height.mas_equalTo(40);
    }];
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectZero];
        _bgView.backgroundColor = [UIColor clearColor];
    }
    return _bgView;
}

- (UIButton *)chooseBtn {
    if (!_chooseBtn) {
        _chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _chooseBtn.titleLabel.font = [UIFont systemFontOfSize:kFontNum11];
        _chooseBtn.backgroundColor = [UIColor clearColor];
        [_chooseBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_chooseBtn addTarget:self action:@selector(chooseBtnButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chooseBtn;
}

- (UIButton *)groupPurchaseBtn {
    if (!_groupPurchaseBtn) {
        _groupPurchaseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _groupPurchaseBtn.titleLabel.font = [UIFont systemFontOfSize:kFontNum11];
        _groupPurchaseBtn.backgroundColor = [UIColor clearColor];
        [_groupPurchaseBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_groupPurchaseBtn addTarget:self action:@selector(groupPurchaseBtnButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _groupPurchaseBtn;
}

- (UIButton *)onSaleBtn {
    if (!_onSaleBtn) {
        _onSaleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _onSaleBtn.titleLabel.font = [UIFont systemFontOfSize:kFontNum11];
        _onSaleBtn.backgroundColor = [UIColor clearColor];
        [_onSaleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_onSaleBtn addTarget:self action:@selector(onSaleBtnButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _onSaleBtn;
}

- (UIButton *)serviceBtn {
    if (!_serviceBtn) {
        _serviceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _serviceBtn.titleLabel.font = [UIFont systemFontOfSize:kFontNum11];
        _serviceBtn.backgroundColor = [UIColor clearColor];
        [_serviceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_serviceBtn addTarget:self action:@selector(serviceBtnButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _serviceBtn;
}

- (UIButton *)exchangeBtn {
    if (!_exchangeBtn) {
        _exchangeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _exchangeBtn.titleLabel.font = [UIFont systemFontOfSize:kFontNum11];
        _exchangeBtn.backgroundColor = [UIColor clearColor];
        [_exchangeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_exchangeBtn addTarget:self action:@selector(exchangeBtnButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _exchangeBtn;
}

- (UIButton *)afterSaleBtn {
    if (!_afterSaleBtn) {
        _afterSaleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _afterSaleBtn.titleLabel.font = [UIFont systemFontOfSize:kFontNum11];
//        _afterSaleBtn.backgroundColor = [UIColor redColor];
        [_afterSaleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_afterSaleBtn addTarget:self action:@selector(afterSaleBtnButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _afterSaleBtn;
}

#pragma mark - 选购门锁 点击
- (void)chooseBtnButtonClick {
    NSLog(@"选购门锁 点击");
    !_chooseBtnClickBlock ? : _chooseBtnClickBlock();
}

#pragma mark - 企业团购 点击
- (void)groupPurchaseBtnButtonClick {
    NSLog(@"企业团购 点击");
    !_groupPurchaseBtnClickBlock ? : _groupPurchaseBtnClickBlock();
}

#pragma mark - 限时特价 点击
- (void)onSaleBtnButtonClick {
    NSLog(@"限时特价 点击");
    !_onSaleBtnClickBlock ? : _onSaleBtnClickBlock();
}

#pragma mark - 爱迪尔服务 点击
- (void)serviceBtnButtonClick {
    NSLog(@"爱迪尔服务 点击");
    !_serviceBtnClickBlock ? : _serviceBtnClickBlock();
}

#pragma mark - 以旧换新 点击
- (void)exchangeBtnButtonClick {
    NSLog(@"以旧换新 点击");
    !_exchangeBtnClickBlock ? : _exchangeBtnClickBlock();
}

#pragma mark - 售后政策 点击
- (void)afterSaleBtnButtonClick {
    NSLog(@"售后政策 点击");
    !_afterSaleBtnClickBlock ? : _afterSaleBtnClickBlock();
}



@end
