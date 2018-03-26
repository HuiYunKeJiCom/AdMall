//
//  ADSallingCell.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/6.
//  Copyright © 2018年 Adel. All rights reserved.
//  限时抢购-正在抢购Cell

#import "ADSallingCell.h"
#import "ADOriginalPriceView.h"

@interface ADSallingCell()

@property (nonatomic, strong) UIView           *bgView;
/** 商品图片 */
@property(nonatomic,strong)UIImageView *goodsIV;
/** 名称 */
@property(nonatomic,strong)UILabel *goodsNameLab;
/** 类型 */
@property(nonatomic,strong)UILabel *typeLab;
/** 抢 */
@property(nonatomic,strong)UILabel *robLab;
/** 已购数量 */
@property(nonatomic,strong)UILabel *soldNumLab;
/** 已购数量单位 */
@property(nonatomic,strong)UILabel *soldUnitLab;
/** 原价格 */
@property(nonatomic,strong)ADOriginalPriceView *oldPriceView;
///** 原价格 */
//@property(nonatomic,strong)UILabel *oldPriceLab;
///** 原价格单位 */
//@property(nonatomic,strong)UILabel *oldUnitLab;
/** 总数量view */
@property(nonatomic,strong)UIView *totalView;
/** 已购数量view */
@property(nonatomic,strong)UIView *soldView;
/** 价格 */
@property(nonatomic,strong)UILabel *salePriceLab;
/** 价格单位 */
@property(nonatomic,strong)UILabel *saleUnitLab;

@end

@implementation ADSallingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.goodsIV];
        [self.bgView addSubview:self.goodsNameLab];
        [self.bgView addSubview:self.typeLab];
        [self.bgView addSubview:self.robLab];
        [self.bgView addSubview:self.soldNumLab];
        [self.bgView addSubview:self.soldUnitLab];
        [self.bgView addSubview:self.oldPriceView];
        [self.bgView addSubview:self.totalView];
        [self.bgView addSubview:self.soldView];
        [self.bgView addSubview:self.salePriceLab];
        [self.bgView addSubview:self.saleUnitLab];
        
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
        make.left.equalTo(weakSelf.bgView.mas_left);
        make.top.equalTo(weakSelf.bgView.mas_top);
        make.bottom.equalTo(weakSelf.bgView.mas_bottom);
        make.width.mas_equalTo(kScreenWidth*0.4);
    }];
    
    [self.goodsNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.goodsIV.mas_right).with.offset(10);
        make.top.equalTo(weakSelf.bgView.mas_top).with.offset(10);
    }];
    
    [self.typeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.goodsIV.mas_right).with.offset(10);
        make.top.equalTo(weakSelf.goodsNameLab.mas_bottom).with.offset(5);
    }];
    
    [self.soldNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.goodsIV.mas_right).with.offset(10);
        make.top.equalTo(weakSelf.typeLab.mas_bottom).with.offset(5);
    }];
    
    [self.soldUnitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.soldNumLab.mas_right);
        make.top.equalTo(weakSelf.typeLab.mas_bottom).with.offset(5);
    }];
    
    [self.oldPriceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.bgView.mas_right).with.offset(-15);
        make.top.equalTo(weakSelf.typeLab.mas_bottom).with.offset(5);
        make.bottom.equalTo(weakSelf.soldUnitLab.mas_bottom);
        make.width.mas_equalTo(120);
    }];
    
    [self.totalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.goodsIV.mas_right).with.offset(10);
        make.bottom.equalTo(weakSelf.bgView.mas_bottom).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
    [self.soldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.goodsIV.mas_right).with.offset(10);
        make.bottom.equalTo(weakSelf.bgView.mas_bottom).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];
    
    [self.robLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.bgView.mas_right).with.offset(-15);
        make.top.equalTo(weakSelf.bgView.mas_top).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [self.saleUnitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.bgView.mas_right).with.offset(-15);
        make.bottom.equalTo(weakSelf.bgView.mas_bottom).with.offset(-10);
    }];
    
    [self.salePriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.saleUnitLab.mas_left).with.offset(-5);
        make.bottom.equalTo(weakSelf.bgView.mas_bottom).with.offset(-10);
    }];
}

- (void)setModel:(ADSallingModel *)model {
    _model = model;
    self.goodsNameLab.text = model.goodsName;
    self.typeLab.text = model.type;
    self.robLab.text = @"抢";
    self.soldNumLab.text = model.soldNum;
    self.soldUnitLab.text = @"件已售";
    self.salePriceLab.text = model.salePrice;
    self.saleUnitLab.text = @"元";
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
        //        [_goodsIV setImage:[UIImage imageNamed:@"icon"]];
        [_goodsIV setBackgroundColor:[UIColor greenColor]];
        [_goodsIV setContentMode:UIViewContentModeScaleAspectFill];
        //        [_goodsIV setClipsToBounds:YES];
    }
    return _goodsIV;
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

- (UILabel *)soldNumLab {
    if (!_soldNumLab) {
        _soldNumLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor redColor]];
    }
    return _soldNumLab;
}

- (UILabel *)soldUnitLab {
    if (!_soldUnitLab) {
        _soldUnitLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor redColor]];
    }
    return _soldUnitLab;
}

- (ADOriginalPriceView *)oldPriceView {
    if (!_oldPriceView) {
        _oldPriceView = [[ADOriginalPriceView alloc] initWithFrame:CGRectZero];
        _oldPriceView.backgroundColor = [UIColor whiteColor];
    }
    return _oldPriceView;
}

- (UIView *)totalView {
    if (!_totalView) {
        _totalView = [[UIView alloc] initWithFrame:CGRectZero];
        _totalView.backgroundColor = [UIColor whiteColor];
        _totalView.layer.borderColor = [UIColor redColor].CGColor;//边框颜色
        _totalView.layer.borderWidth = 1;
        _totalView.layer.masksToBounds = YES;
        _totalView.layer.cornerRadius = 5;
    }
    return _totalView;
}

- (UIView *)soldView {
    if (!_soldView) {
        _soldView = [[UIView alloc] initWithFrame:CGRectZero];
        _soldView.backgroundColor = [UIColor redColor];
        _soldView.layer.masksToBounds = YES;
        _soldView.layer.cornerRadius = 5;
    }
    return _soldView;
}

- (UILabel *)robLab {
    if (!_robLab) {
        _robLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor whiteColor]];
        _robLab.textAlignment = NSTextAlignmentCenter;
        _robLab.backgroundColor = [UIColor redColor];
        _robLab.layer.masksToBounds = YES;
        _robLab.layer.cornerRadius = 20;
    }
    return _robLab;
}

- (UILabel *)salePriceLab {
    if (!_salePriceLab) {
        _salePriceLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor redColor]];
//        NSString *oldPrice = @"1268.00";
//        NSUInteger length = [oldPrice length];
//        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
//        [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
//        [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, length)];
//        [_salePriceLab setAttributedText:attri];
    }
    return _salePriceLab;
}

- (UILabel *)saleUnitLab {
    if (!_saleUnitLab) {
        _saleUnitLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor blackColor]];
    }
    return _saleUnitLab;
}

@end
