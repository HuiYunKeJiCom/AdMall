//
//  ADCountDownSubclassCell.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/27.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import "ADCountDownSubclassCell.h"
#import "ADCountDownGoodsModel.h"
// Vendors
#import <UIImageView+WebCache.h>

@interface ADCountDownSubclassCell()
/** 图片 */
@property (strong , nonatomic)UIImageView *goodsImageView;
/** 商品名称 */
@property (strong , nonatomic)UILabel *goodsNameLabel;
/** 商品原价格 */
@property (strong , nonatomic)UILabel *goodsPriceLabel;
/** 商品抢购价格 */
@property (strong , nonatomic)UILabel *ggPrice;
/** 竖线 */
@property (strong , nonatomic)UIView *lineView;
@end


@implementation ADCountDownSubclassCell
#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}

#pragma mark - UI
- (void)setUpUI
{
    [self addSubview:self.goodsImageView];
    [self addSubview:self.goodsNameLabel];
    [self addSubview:self.goodsPriceLabel];
    [self addSubview:self.ggPrice];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = kBACKGROUNDCOLOR;
    self.lineView.frame = CGRectMake(0, -10, 1, self.dc_height+10);
    [self addSubview:self.lineView];

}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self makeConstraints];
}

#pragma mark - Constraints
- (void)makeConstraints {
    WEAKSELF
    [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf);
        make.top.mas_equalTo(weakSelf).with.offset(5);
        make.width.mas_equalTo(weakSelf).multipliedBy(0.7);
        make.height.mas_equalTo(weakSelf.dc_width * 0.7);
    }];
    
    [self.goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.goodsImageView.mas_left);
        make.top.equalTo(weakSelf.goodsImageView.mas_bottom).with.offset(10);
        make.width.mas_equalTo(weakSelf).multipliedBy(0.7);
    }];
    
    [self.goodsPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.goodsImageView.mas_left);
        make.top.equalTo(weakSelf.goodsNameLabel.mas_bottom).with.offset(10);
    }];
    
    [self.ggPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.goodsImageView.mas_left);
        make.top.equalTo(weakSelf.goodsPriceLabel.mas_bottom).with.offset(5);
    }];
    
}

#pragma mark - Setter Getter Methods
-(void)setModel:(ADCountDownGoodsModel *)model
{
    //    NSLog(@"来这里了吗");
    _model = model;
    
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:model.goods_image_path] placeholderImage:[UIImage imageNamed:@"image_default"]];
    self.goodsNameLabel.text = model.gg_name;
//    self.goodsPriceLabel.text = [NSString stringWithFormat:@"¥ %.2f",[model.goods_price floatValue]];
    self.ggPrice.text = [NSString stringWithFormat:@"¥ %.2f",[model.gg_price floatValue]];
    
    //中划线
    NSDictionary *attribtDic =@{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥ %.2f",[model.goods_price floatValue]] attributes:attribtDic];
    self.goodsPriceLabel.attributedText = attribtStr;
    
}

-(UIImageView *)goodsImageView{
    if (!_goodsImageView) {
        _goodsImageView = [[UIImageView alloc] init];
        //        [_goodsIV setImage:[UIImage imageNamed:@"icon"]];
        [_goodsImageView setContentMode:UIViewContentModeScaleAspectFill];
        //设置layer
        CALayer *layer=[_goodsImageView layer];
        //是否设置边框以及是否可见
        [layer setMasksToBounds:YES];
        //设置边框线的宽
        [layer setBorderWidth:1];
        //设置边框线的颜色
        [layer setBorderColor:[kBACKGROUNDCOLOR CGColor]];
    }
    return _goodsImageView;
}

- (UILabel *)goodsNameLabel {
    if (!_goodsNameLabel) {
        _goodsNameLabel = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
        _goodsNameLabel.numberOfLines = 2;
    }
    return _goodsNameLabel;
}

- (UILabel *)goodsPriceLabel {
    if (!_goodsPriceLabel) {
        _goodsPriceLabel = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor lightGrayColor]];
    }
    return _goodsPriceLabel;
}

- (UILabel *)ggPrice {
    if (!_ggPrice) {
        _ggPrice = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor redColor]];
        //设置layer
        CALayer *layer=[_ggPrice layer];
        //是否设置边框以及是否可见
        [layer setMasksToBounds:YES];
        //设置边框线的宽
        [layer setBorderWidth:1];
        //设置边框线的颜色
        [layer setBorderColor:[[UIColor redColor] CGColor]];
    }
    return _ggPrice;
}

@end
