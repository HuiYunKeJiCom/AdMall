//
//  ADGoodsCell.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/2/8.
//  Copyright © 2018年 Adel. All rights reserved.
//  商品详情-相关商品-商品cell

#import "ADGoodsCell.h"

@interface ADGoodsCell()
@property (nonatomic, strong) UIView           *bgView;
/** 商品图片 */
@property(nonatomic,strong)UIImageView *goodsIV;
/** 名称 */
@property(nonatomic,strong)UILabel *goodsNameLab;
/** 类型 */
@property(nonatomic,strong)UILabel *typeLab;
/** 广告语 */
@property(nonatomic,strong)UILabel *advertiseLab;
/** 价格 */
@property(nonatomic,strong)UILabel *priceLab;
/** 价格单位 */
@property(nonatomic,strong)UILabel *unitLab;

@end

@implementation ADGoodsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.bgView];
        [self addSubview:self.goodsNameLab];
        [self addSubview:self.typeLab];
        [self addSubview:self.advertiseLab];
        [self addSubview:self.priceLab];
        [self addSubview:self.unitLab];
        [self addSubview:self.goodsIV];
//        self.bgView.backgroundColor = [UIColor redColor];
        [self makeConstraints];
    }
    
    return self;
}

-(void)setFrame:(CGRect)frame {
    frame.origin.y += 15;
    [super setFrame:frame];
    
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
    
    [self.goodsIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(15);
        make.top.equalTo(weakSelf.bgView.mas_top);
        make.bottom.equalTo(weakSelf.bgView.mas_bottom);
        make.width.mas_equalTo(kScreenWidth*0.5);
    }];
    
    [self.goodsNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.bgView.mas_right).with.offset(-20);
        make.top.equalTo(weakSelf.bgView.mas_top).with.offset(20);
    }];
    
    [self.typeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.bgView.mas_right).with.offset(-20);
        make.top.equalTo(weakSelf.goodsNameLab.mas_bottom).with.offset(10);
    }];
    
    [self.advertiseLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.bgView.mas_right).with.offset(-20);
        make.top.equalTo(weakSelf.typeLab.mas_bottom).with.offset(30);
    }];
    
    [self.unitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.bgView.mas_right).with.offset(-20);
        make.top.equalTo(weakSelf.advertiseLab.mas_bottom).with.offset(5);
    }];
    
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.unitLab.mas_left).with.offset(-5);
        make.top.equalTo(weakSelf.advertiseLab.mas_bottom).with.offset(5);
    }];
}

- (void)setModel:(ADGoodsModel *)model {
    _model = model;
//    NSLog(@"model.goods_image_path = %@",model.goods_image_path);
    [self.goodsIV sd_setImageWithURL:[NSURL URLWithString:model.goods_image_path]];
    self.goodsNameLab.text = model.goods_name;
    self.typeLab.text = @"智能指纹锁";
//    NSLog(@"model.goods_details = %@",model.goods_details);
    self.advertiseLab.text = model.goods_details;//@"门锁618 疯狂抢购中"
    self.priceLab.text = [NSString stringWithFormat:@"%.2f",[model.goods_current_price floatValue]];
    self.unitLab.text = @"元起";
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectZero];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

- (UILabel *)goodsNameLab {
    if (!_goodsNameLab) {
        _goodsNameLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor blackColor]];
    }
    return _goodsNameLab;
}

- (UILabel *)typeLab {
    if (!_typeLab) {
        _typeLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor blackColor]];
    }
    return _typeLab;
}

- (UILabel *)advertiseLab {
    if (!_advertiseLab) {
        _advertiseLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum13 TextColor:[UIColor lightGrayColor]];
    }
    return _advertiseLab;
}

- (UILabel *)priceLab {
    if (!_priceLab) {
        _priceLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum13 TextColor:[UIColor redColor]];
    }
    return _priceLab;
}

- (UILabel *)unitLab {
    if (!_unitLab) {
        _unitLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor lightGrayColor]];
    }
    return _unitLab;
}

-(UIImageView *)goodsIV{
    if (!_goodsIV) {
        _goodsIV = [[UIImageView alloc] init];
//        [_goodsIV setImage:[UIImage imageNamed:@"icon"]];
//        [_goodsIV setBackgroundColor:[UIColor greenColor]];
        [_goodsIV setContentMode:UIViewContentModeScaleAspectFill];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doTap:)];
        // 允许用户交互
        _goodsIV.userInteractionEnabled = YES;
        
        [_goodsIV addGestureRecognizer:tap];
//        [_goodsIV setClipsToBounds:YES];
    }
    return _goodsIV;
}

#pragma mark - 图片 点击
- (void)doTap:(UITapGestureRecognizer *)tap {
//    NSLog(@"图片 点击");
    !_imageViewBtnClickBlock ? : _imageViewBtnClickBlock();
}

@end
