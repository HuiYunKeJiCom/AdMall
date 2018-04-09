//
//  ADCouponCenterCell.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/7.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import "ADCouponCenterCell.h"

@interface ADCouponCenterCell()

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
/** 有效期标题 */
@property(nonatomic,strong)UILabel *effectiveTitLab;
/** 开始时间 */
@property(nonatomic,strong)UILabel *couponStartTimeLab;
/** 至 */
@property(nonatomic,strong)UILabel *toLab;
/** 结束时间 */
@property(nonatomic,strong)UILabel *couponEndTimeLab;
/** 领取 按钮 */
@property(nonatomic,strong)UIButton *receiveBtn;
@end

@implementation ADCouponCenterCell

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
        [self.bgView addSubview:self.effectiveTitLab];
        [self.bgView addSubview:self.couponStartTimeLab];
        [self.bgView addSubview:self.toLab];
        [self.bgView addSubview:self.couponEndTimeLab];
        [self.bgView addSubview:self.receiveBtn];
        
        [self makeConstraints];
    }
    
    return self;
}

-(void)setFrame:(CGRect)frame {
    frame.origin.y += 15;
    [super setFrame:frame];
    
}

- (void)setModel:(ADCouponModel *)model {
    _model = model;
    
    self.couponNameLab.text = model.coupon_name;
    self.symbolLab.text = @"¥";
    self.seriesTitLab1.text = @"可用于";
    self.couponSeriesLab.text = model.class_name;
    self.seriesTitLab2.text = @"系列产品";
    self.couponInstructionsLab.text = [NSString stringWithFormat:@"(满%@元可使用)",model.coupon_order_amount];
    self.effectiveTitLab.text = @"*有效期：";
    self.couponStartTimeLab.text = model.coupon_begin_time;
    self.toLab.text = @"至";
    self.couponEndTimeLab.text = model.coupon_end_time;
    [self.receiveBtn setTitle:@"领取" forState:UIControlStateNormal];
    NSString *couponPrice = [NSString stringWithFormat:@"%.2f",[model.coupon_amount floatValue]];
    NSArray *tempArr = [couponPrice componentsSeparatedByString:@"."];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:couponPrice];
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
    
    [self.effectiveTitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(10);
        make.bottom.equalTo(weakSelf.bgView.mas_bottom).with.offset(-10);
    }];
    
    [self.couponStartTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.effectiveTitLab.mas_right);
        make.bottom.equalTo(weakSelf.bgView.mas_bottom).with.offset(-10);
    }];
    
    [self.toLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.couponStartTimeLab.mas_right).with.offset(5);
        make.bottom.equalTo(weakSelf.bgView.mas_bottom).with.offset(-10);
    }];
    
    [self.couponEndTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.toLab.mas_right).with.offset(5);
        make.bottom.equalTo(weakSelf.bgView.mas_bottom).with.offset(-10);
    }];

    [self.receiveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.bgView.mas_right).with.offset(-30);
        make.bottom.equalTo(weakSelf.bgView.mas_bottom).with.offset(-5);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectZero];
        _bgView.backgroundColor = [UIColor whiteColor];
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

- (UILabel *)effectiveTitLab {
    if (!_effectiveTitLab) {
        _effectiveTitLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum10 TextColor:[UIColor blackColor]];
    }
    return _effectiveTitLab;
}

- (UILabel *)couponStartTimeLab {
    if (!_couponStartTimeLab) {
        _couponStartTimeLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum10 TextColor:[UIColor blackColor]];
    }
    return _couponStartTimeLab;
}

- (UILabel *)toLab {
    if (!_toLab) {
        _toLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum10 TextColor:[UIColor blackColor]];
    }
    return _toLab;
}

- (UILabel *)couponEndTimeLab {
    if (!_couponEndTimeLab) {
        _couponEndTimeLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum10 TextColor:[UIColor blackColor]];
    }
    return _couponEndTimeLab;
}

- (UIButton *)receiveBtn {
    if (!_receiveBtn) {
        _receiveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _receiveBtn.titleLabel.font = [UIFont systemFontOfSize:kFontNum14];
        _receiveBtn.backgroundColor = [UIColor orangeColor];
        [_receiveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_receiveBtn addTarget:self action:@selector(receiveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _receiveBtn.layer.masksToBounds = YES;
        _receiveBtn.layer.cornerRadius = 5;
    }
    return _receiveBtn;
}

#pragma mark - 领取 点击
- (void)receiveBtnClick:(UIButton *)btn {
//    NSLog(@"领取 点击");
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.superview animated:YES];
    [RequestTool receiveCoupon:@{@"couponId":self.model.idx} withSuccessBlock:^(NSDictionary *result) {
        if([result[@"code"] integerValue] == 1){
            NSLog(@"领取优惠券成功");
            hud.hidden = YES;
            btn.backgroundColor = [UIColor lightGrayColor];
            [btn setTitle:@"已领取" forState:UIControlStateNormal];
            btn.userInteractionEnabled = NO;
        }else if([result[@"code"] integerValue] == -2){
            hud.detailsLabelText = @"登录失效";
            hud.mode = MBProgressHUDModeText;
            [hud hide:YES afterDelay:1.0];
        }else if([result[@"code"] integerValue] == -1){
            hud.detailsLabelText = @"未登录";
            hud.mode = MBProgressHUDModeText;
            [hud hide:YES afterDelay:1.0];
        }else if([result[@"code"] integerValue] == 0){
            hud.detailsLabelText = @"失败";
            hud.mode = MBProgressHUDModeText;
            [hud hide:YES afterDelay:1.0];
        }
    } withFailBlock:^(NSString *msg) {
        hud.detailsLabelText = msg;
        hud.mode = MBProgressHUDModeText;
        [hud hide:YES afterDelay:1.0];
    }];

//    !_toLoginClickBlock ? : _toLoginClickBlock();
    
}
@end
