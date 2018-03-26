//
//  ADApplyAfterSaleCell.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/13.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import "ADApplyAfterSaleCell.h"

@interface ADApplyAfterSaleCell()
@property (nonatomic, strong) UIView  *bgView;
/** 商品图片 */
@property(nonatomic,strong)UIImageView *goodsIV;
/** 地址 */
@property(nonatomic,strong)UILabel *addressLab;
/** 商品类型 */
@property(nonatomic,strong)UILabel *goodsTypeLab;
/** 价格 */
@property(nonatomic,strong)UILabel *priceLab;
/** 单位 */
@property(nonatomic,strong)UILabel *unitLab;
/** 申请售后 */
@property(nonatomic,strong)UIButton *applyAfterSalebtn;
@end

@implementation ADApplyAfterSaleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.bgView];
        [self addSubview:self.goodsIV];
        [self addSubview:self.addressLab];
        [self addSubview:self.goodsTypeLab];
        [self addSubview:self.priceLab];
        [self addSubview:self.unitLab];
        [self addSubview:self.applyAfterSalebtn];
        [self makeConstraints];
    }
    
    return self;
}

-(void)setFrame:(CGRect)frame {
    [super setFrame:frame];
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
    
    [self.goodsIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(10);
        make.top.equalTo(weakSelf.bgView.mas_top).with.offset(10);
        //        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-15);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(100);
    }];
    
    [self.addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(120);
        make.top.equalTo(weakSelf.bgView.mas_top).with.offset(20);
    }];
    
    [self.goodsTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(120);
        make.top.equalTo(weakSelf.addressLab.mas_bottom).with.offset(10);
    }];

    [self.applyAfterSalebtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.bgView.mas_right).with.offset(-10);
        make.centerY.equalTo(weakSelf.bgView.mas_centerY);
        //        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-15);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(30);
    }];
    
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(120);
        make.top.equalTo(weakSelf.applyAfterSalebtn.mas_bottom);
    }];
    
    [self.unitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.priceLab.mas_right).with.offset(5);
        make.top.equalTo(weakSelf.applyAfterSalebtn.mas_bottom);
    }];
}

- (void)setModel:(ADApplyAfterSaleModel *)model {
    _model = model;
    
    self.addressLab.text = model.address;
    self.goodsTypeLab.text = model.goodsType;
    self.priceLab.text = model.price;
    self.unitLab.text = @"元";
    [self.applyAfterSalebtn setTitle:@"申请售后" forState:UIControlStateNormal];
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

- (UILabel *)addressLab {
    if (!_addressLab) {
        _addressLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
        _addressLab.textAlignment = NSTextAlignmentLeft;
    }
    return _addressLab;
}

- (UILabel *)goodsTypeLab {
    if (!_goodsTypeLab) {
        _goodsTypeLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
        _goodsTypeLab.textAlignment = NSTextAlignmentLeft;
    }
    return _goodsTypeLab;
}

- (UILabel *)priceLab {
    if (!_priceLab) {
        _priceLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor redColor]];
        _priceLab.textAlignment = NSTextAlignmentLeft;
    }
    return _priceLab;
}

- (UILabel *)unitLab {
    if (!_unitLab) {
        _unitLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
        _unitLab.textAlignment = NSTextAlignmentLeft;
    }
    return _unitLab;
}

- (UIButton *)applyAfterSalebtn {
    if (!_applyAfterSalebtn) {
        _applyAfterSalebtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _applyAfterSalebtn.backgroundColor = [UIColor redColor];
        [DCSpeedy dc_chageControlCircularWith:_applyAfterSalebtn AndSetCornerRadius:5 SetBorderWidth:1 SetBorderColor:k_UIColorFromRGB(0xffffff) canMasksToBounds:YES];
        _applyAfterSalebtn.titleLabel.font = [UIFont systemFontOfSize:kFontNum12];
        [_applyAfterSalebtn addTarget:self action:@selector(afterSaleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _applyAfterSalebtn;
}

#pragma mark - 申请售后 点击
- (void)afterSaleButtonClick:(UIButton *)button{
    NSLog(@"申请售后 点击");
    button.backgroundColor = [UIColor lightGrayColor];
    button.enabled = NO;
    [button setTitle:@"已申请" forState:UIControlStateNormal];
    !_applyAfterSaleBtnClickBlock ? : _applyAfterSaleBtnClickBlock();
}

@end
