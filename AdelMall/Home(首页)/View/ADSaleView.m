//
//  ADSaleView.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/6.
//  Copyright © 2018年 Adel. All rights reserved.
//  自定义 正在抢购 的页面

#import "ADSaleView.h"

@interface ADSaleView()

/** 时间 */
@property(nonatomic,strong)UILabel *timeLab;
/** 主题 */
@property(nonatomic,strong)UILabel *titleLab;
/** detail */
@property(nonatomic,strong)UILabel *detailLab;

@end

@implementation ADSaleView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    
    return self;
}

- (void)initViews {
    [self addSubview:self.timeLab];
    [self addSubview:self.titleLab];
    [self addSubview:self.detailLab];
    [self makeConstraints];
//    [self setUpDictionary:self.dict];
}

- (void)setUpDictionary:(NSDictionary *)dict {
    self.timeLab.text = [dict objectForKey:@"time"];
    self.titleLab.text = [dict objectForKey:@"title"];
    self.detailLab.text = [dict objectForKey:@"detail"];
    
}

//改变字体颜色
- (void)changeTextColor:(UIColor *)color{
    self.timeLab.textColor = color;
    self.titleLab.textColor = color;
    self.detailLab.textColor = color;
}

- (void)makeConstraints {
    WEAKSELF
    
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(15);
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.timeLab.mas_right).with.offset(30);
        make.bottom.equalTo(weakSelf.mas_centerY);
    }];
    
    [self.detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.timeLab.mas_right).with.offset(20);
        make.top.equalTo(weakSelf.mas_centerY).with.offset(3);
    }];
    
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum15 TextColor:[UIColor blackColor]];
    }
    return _titleLab;
}

- (UILabel *)timeLab {
    if (!_timeLab) {
        _timeLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor blackColor]];
    }
    return _timeLab;
}

- (UILabel *)detailLab {
    if (!_detailLab) {
        _detailLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor blackColor]];
    }
    return _detailLab;
}


@end
