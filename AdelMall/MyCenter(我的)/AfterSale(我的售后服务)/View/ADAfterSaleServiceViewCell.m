//
//  ADAfterSaleServiceViewCell.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/2.
//  Copyright © 2018年 Adel. All rights reserved.
//  售后服务cell

#import "ADAfterSaleServiceViewCell.h"

@interface ADAfterSaleServiceViewCell()
@property (nonatomic, strong) UIView  *bgView;
/** 商品图片 */
@property(nonatomic,strong)UIImageView *goodsIV;
/** 商品名 */
@property(nonatomic,strong)UILabel *goodsNameLab;
/** 商品类型 */
@property(nonatomic,strong)UILabel *goodsStyleLab;
@end

@implementation ADAfterSaleServiceViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
//        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.goodsIV];
        [self.bgView addSubview:self.goodsNameLab];
        [self.bgView addSubview:self.goodsStyleLab];
        
//        [self setUpData];
        [self makeConstraints];
    }
    
    return self;
}

//#pragma mark - 填充数据
//-(void)setUpData{
//    self.goodsNameLab.text = @"ADEL爱迪尔4920B";
//    self.goodsStyleLab.text = @"智能指纹锁";
//}

-(void)setFrame:(CGRect)frame {
//    frame.origin.y += 30;
    [super setFrame:frame];
}

#pragma mark - Constraints
- (void)makeConstraints {
    
    WEAKSELF
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(10);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10);
        make.top.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf.mas_bottom);
    }];
    
    [self.goodsIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left);
        make.top.equalTo(weakSelf.bgView.mas_top);
        //        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-15);
        make.width.mas_equalTo(kScreenWidth*0.5);
        make.height.mas_equalTo(GetScaleWidth(120));
    }];
    
    [self.goodsNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.bgView.mas_right).with.offset(-20);
        make.bottom.equalTo(weakSelf.bgView.mas_centerY).with.offset(-5);
    }];
    
    [self.goodsStyleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.bgView.mas_right).with.offset(-20);
        make.top.equalTo(weakSelf.bgView.mas_centerY).with.offset(5);
    }];
    
}

- (void)setModel:(ADAfterSaleServiceViewModel *)model {
    _model = model;
    
        self.goodsNameLab.text = model.goods_name;
//        self.goodsStyleLab.text = model.goodsStyle;
    
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectZero];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

-(UIImageView *)goodsIV{
    if (!_goodsIV) {
        _goodsIV = [[UIImageView alloc] init];
        [_goodsIV setBackgroundColor:[UIColor greenColor]];
        [_goodsIV setContentMode:UIViewContentModeScaleAspectFill];
        //        [_goodsIV setClipsToBounds:YES];
    }
    return _goodsIV;
}

- (UILabel *)goodsNameLab {
    if (!_goodsNameLab) {
        _goodsNameLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor blackColor]];
        _goodsNameLab.textAlignment = NSTextAlignmentLeft;
    }
    return _goodsNameLab;
}

- (UILabel *)goodsStyleLab {
    if (!_goodsStyleLab) {
        _goodsStyleLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor blackColor]];
        _goodsStyleLab.textAlignment = NSTextAlignmentLeft;
    }
    return _goodsStyleLab;
}

@end
