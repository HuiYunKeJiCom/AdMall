//
//  ADUseCouponRecordCell.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/7.
//  Copyright © 2018年 Adel. All rights reserved.
//  优惠券-使用记录cell

#import "ADUseCouponRecordCell.h"

@interface ADUseCouponRecordCell()
@property (nonatomic, strong) UIView           *bgView;
/** 背景图片 */
@property(nonatomic,strong)UIImageView *bgIV;
/** 优惠券名称 */
@property(nonatomic,strong)UILabel *couponNameLab;
/** 金额符号 */
@property(nonatomic,strong)UILabel *symbolLab;
/** 价格 */
@property(nonatomic,strong)UILabel *couponPriceLab;
/** 可用于 */
@property(nonatomic,strong)UILabel *seriesTitLab1;
/** 优惠券 使用系列 */
@property(nonatomic,strong)UILabel *couponSeriesLab;
/** 系列产品 */
@property(nonatomic,strong)UILabel *seriesTitLab2;
/** 使用说明 */
@property(nonatomic,strong)UILabel *couponInstructionsLab;
/** 使用日期标题 */
@property(nonatomic,strong)UILabel *useTimeTitLab;
/** 使用时间 */
@property(nonatomic,strong)UILabel *couponUseTimeLab;
/** 已使用图片 */
@property(nonatomic,strong)UIImageView *usedIV;
@end

@implementation ADUseCouponRecordCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.bgIV];
        [self.bgView addSubview:self.couponNameLab];
        [self.bgView addSubview:self.symbolLab];
        [self.bgView addSubview:self.couponPriceLab];
        [self.bgView addSubview:self.seriesTitLab1];
        [self.bgView addSubview:self.couponSeriesLab];
        [self.bgView addSubview:self.seriesTitLab2];
        [self.bgView addSubview:self.couponInstructionsLab];
        [self.bgView addSubview:self.useTimeTitLab];
        [self.bgView addSubview:self.couponUseTimeLab];
        [self.bgView addSubview:self.usedIV];
        
        [self makeConstraints];
    }
    
    return self;
}

-(void)setFrame:(CGRect)frame {
    frame.origin.y += 15;
    [super setFrame:frame];
    
}

- (void)setModel:(ADUseCouponModel *)model {
    _model = model;
    
    self.couponNameLab.text = model.couponName;
    self.symbolLab.text = @"¥";
    
    self.seriesTitLab1.text = @"可用于";
    self.couponSeriesLab.text = model.couponSeries;
    self.seriesTitLab2.text = @"系列产品";
    self.couponInstructionsLab.text = @"(满3900元可使用)";
    self.useTimeTitLab.text = @"使用日期：";
    self.couponUseTimeLab.text = model.couponUseTime;
    
    NSArray *tempArr = [model.couponPrice componentsSeparatedByString:@"."];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:model.couponPrice];
    [AttributedStr addAttribute:NSFontAttributeName
                          value:[UIFont systemFontOfSize:45.0]
                          range:NSMakeRange(0, ((NSString *)tempArr[0]).length)];
    [AttributedStr addAttribute:NSFontAttributeName
                          value:[UIFont systemFontOfSize:14.0]
                          range:NSMakeRange(((NSString *)tempArr[0]).length, ((NSString *)tempArr[1]).length+1)];
    self.couponPriceLab.attributedText = AttributedStr;
}


#pragma mark - Constraints
- (void)makeConstraints {
    
    WEAKSELF
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(15);
        make.right.equalTo(weakSelf.mas_right).with.offset(-15);
        make.top.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-15);
    }];
    
    [self.bgIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(weakSelf.bgView);
        //        make.left.equalTo(weakSelf.mas_left).with.offset(15);
        //        make.right.equalTo(weakSelf.mas_right).with.offset(-15);
        //        make.top.equalTo(weakSelf);
        //        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-15);
    }];
    
    [self.couponNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(10);
        make.top.equalTo(weakSelf.bgView.mas_top).with.offset(10);
    }];
    
    [self.couponPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.bgView.mas_right).with.offset(-40);
        make.top.equalTo(weakSelf.bgView.mas_top).with.offset(10);
    }];
    
    [self.symbolLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.couponPriceLab.mas_left).with.offset(-5);
        //        make.right.equalTo(weakSelf.bgView.mas_right).with.offset(-10);
        make.top.equalTo(weakSelf.bgView.mas_top).with.offset(10);
    }];
    
    [self.seriesTitLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(10);
        make.centerY.equalTo(weakSelf.bgView.mas_centerY);
    }];
    
    [self.couponSeriesLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.seriesTitLab1.mas_right).with.offset(5);
        make.bottom.equalTo(weakSelf.seriesTitLab1.mas_bottom);
    }];
    
    [self.seriesTitLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.couponSeriesLab.mas_right).with.offset(5);
        make.centerY.equalTo(weakSelf.bgView.mas_centerY);
    }];
    
    [self.couponInstructionsLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.bgView.mas_right).with.offset(-50);
        make.centerY.equalTo(weakSelf.bgView.mas_centerY);
    }];
    
    [self.useTimeTitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(10);
        make.bottom.equalTo(weakSelf.bgView.mas_bottom).with.offset(-15);
    }];
    
    [self.couponUseTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.useTimeTitLab.mas_right);
        make.bottom.equalTo(weakSelf.bgView.mas_bottom).with.offset(-15);
    }];
    
    [self.usedIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.bgView.mas_right).with.offset(-20);
        make.bottom.equalTo(weakSelf.bgView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(80, 65));
    }];
    
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectZero];
        _bgView.backgroundColor = [UIColor clearColor];
    }
    return _bgView;
}

-(UIImageView *)bgIV{
    if (!_bgIV) {
        _bgIV = [[UIImageView alloc] init];
        [_bgIV setImage:[UIImage imageNamed:@"coupon_bg_1"]];
        [_bgIV setContentMode:UIViewContentModeScaleAspectFill];
    }
    return _bgIV;
}

- (UILabel *)couponNameLab {
    if (!_couponNameLab) {
        _couponNameLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor whiteColor]];
    }
    return _couponNameLab;
}

- (UILabel *)symbolLab {
    if (!_symbolLab) {
        _symbolLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum16 TextColor:[UIColor whiteColor]];
        _symbolLab.font = [UIFont systemFontOfSize:45];
    }
    return _symbolLab;
}

- (UILabel *)couponPriceLab {
    if (!_couponPriceLab) {
        _couponPriceLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum16 TextColor:[UIColor whiteColor]];
        _couponPriceLab.font = [UIFont systemFontOfSize:25];
        
    }
    return _couponPriceLab;
}

- (UILabel *)seriesTitLab1 {
    if (!_seriesTitLab1) {
        _seriesTitLab1 = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor whiteColor]];
    }
    return _seriesTitLab1;
}

- (UILabel *)couponSeriesLab {
    if (!_couponSeriesLab) {
        _couponSeriesLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor whiteColor]];
        _couponSeriesLab.font = [UIFont boldSystemFontOfSize:12.0];
    }
    return _couponSeriesLab;
}

- (UILabel *)seriesTitLab2 {
    if (!_seriesTitLab2) {
        _seriesTitLab2 = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor whiteColor]];
    }
    return _seriesTitLab2;
}

- (UILabel *)couponInstructionsLab {
    if (!_couponInstructionsLab) {
        _couponInstructionsLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor whiteColor]];
    }
    return _couponInstructionsLab;
}

- (UILabel *)useTimeTitLab {
    if (!_useTimeTitLab) {
        _useTimeTitLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum10 TextColor:[UIColor blackColor]];
    }
    return _useTimeTitLab;
}

- (UILabel *)couponUseTimeLab {
    if (!_couponUseTimeLab) {
        _couponUseTimeLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum10 TextColor:[UIColor blackColor]];
    }
    return _couponUseTimeLab;
}

-(UIImageView *)usedIV{
    if (!_usedIV) {
        _usedIV = [[UIImageView alloc] init];
        [_usedIV setImage:[UIImage imageNamed:@"used"]];
        [_usedIV setContentMode:UIViewContentModeScaleAspectFill];
    }
    return _usedIV;
}

@end
