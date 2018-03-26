//
//  ADGoodsListViewCell.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/1.
//  Copyright © 2018年 Adel. All rights reserved.
//  下单页面-商品列表

#import "ADGoodsListViewCell.h"
#import "ADOrderGoodsView.h"

@interface ADGoodsListViewCell()
@property (nonatomic, strong) UIView  *bgView;

@end

@implementation ADGoodsListViewCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
        [self createGoodsViewsWithNSInteger:3];
        [self setUpData];
    }
    return self;
}

- (void)setUpUI{
    [self addSubview:self.bgView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self makeConstraints];
}

#pragma mark - 填充数据
-(void)setUpData{
}

- (void)createGoodsViewsWithNSInteger:(NSInteger)temp{
    for(int i=0;i<temp;i++){
        ADOrderGoodsView *goodsView = [[ADOrderGoodsView alloc]initWithFrame:CGRectMake(0, 91*i, kScreenWidth, 90)];
        [self.bgView addSubview:goodsView];
    }
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
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectZero];
        _bgView.backgroundColor = k_UIColorFromRGB(0xffffff);
    }
    return _bgView;
}

@end
