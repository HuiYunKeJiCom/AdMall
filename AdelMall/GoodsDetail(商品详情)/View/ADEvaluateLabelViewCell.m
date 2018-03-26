//
//  ADEvaluateLabelViewCell.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/2/25.
//  Copyright © 2018年 Adel. All rights reserved.
//  商品详情-用户评论-标签

#import "ADEvaluateLabelViewCell.h"

@interface ADEvaluateLabelViewCell()
@property (nonatomic, strong) UIView           *bgView;
/** 标签标题 */
@property(nonatomic,strong)UILabel *labelTitLab;
/** 箭头按钮 */
@property(nonatomic,strong)UIButton *moreBtn;
@end


@implementation ADEvaluateLabelViewCell
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
    [self.bgView addSubview:self.labelTitLab];
    [self createLabelAndButton];
    [self.bgView addSubview:self.moreBtn];
}

-(void)createLabelAndButton{
    for(int i=0;i<6;i++){
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor lightGrayColor];
        button.tag = i;
        [button addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"商品包装好看" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:kFontNum14];
        CGFloat buttonW = kScreenWidth/3.5;
        CGFloat buttonH = 20;
        CGFloat buttonX = (20+(buttonW +10)* (i%3));
        CGFloat buttonY = (35+25 * (i/3));
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        button.layer.borderWidth=0.5;
        button.layer.borderColor=[UIColor grayColor].CGColor;
        // 设置圆角的大小
        button.layer.cornerRadius = 5;
        [button.layer setMasksToBounds:YES];
        [self.bgView addSubview:button];
    }
}

//标签按钮点击事件
-(void)bottomButtonClick:(UIButton *)btn{
    
    btn.selected = !btn.selected;
    if(btn.selected){
            btn.backgroundColor = [UIColor cyanColor];
    }else{
        btn.backgroundColor = [UIColor lightGrayColor];
    }

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self makeConstraints];
}

#pragma mark - 填充数据
-(void)setUpData{
    self.labelTitLab.text = @"只显示有图";
    [self.moreBtn setTitle:@"v" forState:UIControlStateNormal];
}

- (void)makeConstraints {
    WEAKSELF
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.top.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf.mas_bottom);
    }];
    
    [self.labelTitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(30);
        make.top.equalTo(weakSelf.bgView.mas_top).with.offset(10);
    }];
    
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.bgView.mas_bottom);
        make.centerX.equalTo(weakSelf.bgView.mas_centerX);
        make.width.mas_equalTo(kScreenWidth);
        make.height.mas_equalTo(20);
    }];
    
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectZero];
        _bgView.backgroundColor = k_UIColorFromRGB(0xffffff);
    }
    return _bgView;
}

- (UILabel *)labelTitLab {
    if (!_labelTitLab) {
        _labelTitLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor blackColor]];
    }
    return _labelTitLab;
}

- (UIButton *)moreBtn {
    if (!_moreBtn) {
        _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _moreBtn.titleLabel.font = [UIFont systemFontOfSize:kFontNum14];
        _moreBtn.backgroundColor = [UIColor whiteColor];
        [_moreBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_moreBtn addTarget:self action:@selector(moreBtnButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreBtn;
}

#pragma mark - 箭头 点击
- (void)moreBtnButtonClick {
    NSLog(@"箭头 点击");
    !_moreBtnClickBlock ? : _moreBtnClickBlock();
}

@end
