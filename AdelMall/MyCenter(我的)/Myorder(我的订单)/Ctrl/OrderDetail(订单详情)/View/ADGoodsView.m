//
//  ADGoodsView.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/2/9.
//  Copyright © 2018年 Adel. All rights reserved.
//  订单详情-商品清单

#import "ADGoodsView.h"

@interface ADGoodsView()
/** 商品图片 */
@property(nonatomic,strong)UIImageView *goodsIV;
/** 商品名 */
@property(nonatomic,strong)UILabel *goodsNameLab;
/** 颜色标题 */
@property(nonatomic,strong)UILabel *colorTitLab;
/** 颜色 */
@property(nonatomic,strong)UILabel *colorLab;
/** 数量标题 */
@property(nonatomic,strong)UILabel *numberTitLab;
/** 数量 */
@property(nonatomic,strong)UILabel *numberLab;
/** 单价标题 */
@property(nonatomic,strong)UILabel *priceTitLab;
/** 单价 */
@property(nonatomic,strong)UILabel *priceLab;
/** 总价格 */
@property(nonatomic,strong)UILabel *priceTotalLab;
/** 横线 */
@property(nonatomic,strong)UIView *lineView;

@end

@implementation ADGoodsView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kBACKGROUNDCOLOR;
        [self initViews];
        [self setUpData];
    }
    
    return self;
}

- (void)setUpData {
    self.goodsNameLab.text = @"爱迪尔智能门锁";
    self.colorTitLab.text = @"颜色：";
    self.colorLab.text = @"黑色";
    self.numberTitLab.text = @"数量：";
    self.numberLab.text = @"2";
    self.priceTitLab.text = @"单价：";
    self.priceLab.text = @"¥ 2600";
    self.priceTotalLab.text = @"5200.00 元";
}

- (void)initViews {

    [self addSubview:self.goodsIV];
    [self addSubview:self.goodsNameLab];
    [self addSubview:self.colorTitLab];
    [self addSubview:self.colorLab];
    [self addSubview:self.numberTitLab];
    [self addSubview:self.numberLab];
    [self addSubview:self.priceTitLab];
    [self addSubview:self.priceLab];
    [self addSubview:self.priceTotalLab];
    [self addSubview:self.lineView];
    [self makeConstraints];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)makeConstraints {
    WEAKSELF
    
    [self.goodsIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(25);
        make.top.equalTo(weakSelf.mas_top).with.offset(10);
//        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(80);
    }];
    
    [self.goodsNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(125);
        make.top.equalTo(weakSelf.mas_top).with.offset(20);
    }];
    
    [self.colorTitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(125);
        make.top.equalTo(weakSelf.goodsNameLab.mas_bottom).with.offset(3);
    }];
    
    [self.colorLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.colorTitLab.mas_right);
        make.top.equalTo(weakSelf.goodsNameLab.mas_bottom).with.offset(3);
    }];
    
    [self.numberTitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(125);
        make.top.equalTo(weakSelf.colorTitLab.mas_bottom).with.offset(3);
    }];
    
    [self.numberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.numberTitLab.mas_right);
        make.top.equalTo(weakSelf.colorTitLab.mas_bottom).with.offset(3);
    }];
    
    [self.priceTitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(125);
        make.top.equalTo(weakSelf.numberTitLab.mas_bottom).with.offset(3);
    }];
    
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.priceTitLab.mas_right);
        make.top.equalTo(weakSelf.numberTitLab.mas_bottom).with.offset(3);
    }];
    
    [self.priceTotalLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).with.offset(-20);
        make.top.equalTo(weakSelf.numberTitLab.mas_bottom).with.offset(3);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
        make.top.equalTo(weakSelf.priceTotalLab.mas_bottom).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 1));
    }];
}

-(UIImageView *)goodsIV{
    if (!_goodsIV) {
        _goodsIV = [[UIImageView alloc] init];
        //        [_goodsIV setImage:[UIImage imageNamed:@"icon"]];
        [_goodsIV setBackgroundColor:[UIColor greenColor]];
        [_goodsIV setContentMode:UIViewContentModeScaleAspectFill];
        //        [_goodsIV setClipsToBounds:YES];
    }
    return _goodsIV;
}

- (UILabel *)goodsNameLab {
    if (!_goodsNameLab) {
        _goodsNameLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _goodsNameLab;
}

- (UILabel *)colorTitLab {
    if (!_colorTitLab) {
        _colorTitLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _colorTitLab;
}

- (UILabel *)colorLab {
    if (!_colorLab) {
        _colorLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _colorLab;
}

- (UILabel *)numberTitLab {
    if (!_numberTitLab) {
        _numberTitLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _numberTitLab;
}

- (UILabel *)numberLab {
    if (!_numberLab) {
        _numberLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _numberLab;
}

- (UILabel *)priceTitLab {
    if (!_priceTitLab) {
        _priceTitLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _priceTitLab;
}

- (UILabel *)priceLab {
    if (!_priceLab) {
        _priceLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _priceLab;
}

- (UILabel *)priceTotalLab {
    if (!_priceTotalLab) {
        _priceTotalLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _priceTotalLab;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectZero];
        _lineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineView;
}

@end
