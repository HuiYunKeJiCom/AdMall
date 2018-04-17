//
//  ADOrderCell.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/2/6.
//  Copyright © 2018年 Adel. All rights reserved.
//  我的订单cell

#import "ADOrderCell.h"
#import "ADGoodsOrderModel.h"

@interface ADOrderCell()
/** 订单号 */
@property(nonatomic,strong)UILabel *orderLab;
/** 商品售后 */
@property(nonatomic,strong)UIButton *afterSalebtn;
/** 商品图片 */
@property(nonatomic,strong)UIImageView *goodsIV;
/** 商品名 */
@property(nonatomic,strong)UILabel *goodsNameLab;
/** 商品总数 */
@property(nonatomic,strong)UILabel *totalLab;
/** 日期 */
@property(nonatomic,strong)UILabel *dateLab;
/** 价格标题 */
@property(nonatomic,strong)UILabel *priceTitLab;
/** 价格 */
@property(nonatomic,strong)UILabel *priceLab;
/** 单位 */
@property(nonatomic,strong)UILabel *unitLab;
/** 状态 */
@property(nonatomic,strong)UILabel *stateLab;

/** 详情 */
@property(nonatomic,strong)UIButton *detailBtn;

/** 右箭头 */
@property(nonatomic,strong)UIImageView *rightIV;

/** 支付按钮 */
@property(nonatomic,strong)UIButton *toPayBtn;
@property (nonatomic, strong) UIView  *bgView;
@end

@implementation ADOrderCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];

        [self addSubview:self.bgView];
        [self addSubview:self.goodsIV];
        [self addSubview:self.afterSalebtn];
        [self addSubview:self.orderLab];
        [self addSubview:self.goodsNameLab];
        [self addSubview:self.totalLab];
        [self addSubview:self.dateLab];
        [self addSubview:self.priceTitLab];
        [self addSubview:self.priceLab];
        [self addSubview:self.unitLab];
        [self addSubview:self.stateLab];
        [self addSubview:self.rightIV];
        [self addSubview:self.detailBtn];
        [self addSubview:self.toPayBtn];
        [self makeConstraints];
    }
    
    return self;
}

-(void)setFrame:(CGRect)frame {
//    frame.origin.y += 10;
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
        make.left.equalTo(weakSelf.contentView).with.offset(10);
        make.top.equalTo(weakSelf.mas_top).with.offset(40);
        //        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(80);
    }];
    
    [self.afterSalebtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).with.offset(10);
        make.top.equalTo(weakSelf.mas_top).with.offset(40);
        //        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(80);
    }];
    
    [self.orderLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).with.offset(10);
        make.top.equalTo(weakSelf.contentView).with.offset(10);
    }];
    
    [self.stateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.orderLab.mas_right).with.offset(15);
        make.top.equalTo(weakSelf.contentView).with.offset(10);
        make.width.mas_equalTo(GetScaleWidth(44));
    }];
    
    [self.goodsNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).with.offset(100);
        make.top.equalTo(weakSelf.contentView).with.offset(40);
    }];
    
    [self.totalLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).with.offset(100);
        make.top.equalTo(weakSelf.contentView).with.offset(60);
    }];
    
    [self.dateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).with.offset(100);
        make.top.equalTo(weakSelf.contentView).with.offset(80);
    }];
    
    [self.priceTitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).with.offset(100);
        make.top.equalTo(weakSelf.contentView).with.offset(100);
    }];
    
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.priceTitLab.mas_right);
        make.bottom.equalTo(weakSelf.priceTitLab.mas_bottom);
    }];
    
    [self.unitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.priceLab.mas_right).with.offset(5);
        make.top.equalTo(weakSelf.contentView).with.offset(100);
    }];
    
    [self.toPayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.bgView.mas_right).with.offset(-20);
        make.top.equalTo(weakSelf.contentView).with.offset(90);
        make.width.mas_equalTo(GetScaleWidth(80));
        make.height.mas_equalTo(GetScaleWidth(30));
    }];
    
    [self.detailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.bgView.mas_right).with.offset(-15);
        make.top.equalTo(weakSelf.bgView.mas_top).with.offset(5);
        make.width.mas_equalTo(GetScaleWidth(80));
        make.height.mas_equalTo(GetScaleWidth(25));
    }];
    
    [self.rightIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.bgView.mas_right).with.offset(-15);
        make.top.equalTo(weakSelf.bgView.mas_top).with.offset(12);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
}

- (void)setModel:(ADGoodsOrderModel *)model {
    _model = model;
    
    NSLog(@"order_status = %@",model.order_status);
    [self.goodsIV sd_setImageWithURL:[NSURL URLWithString:self.model.goods_image_path]];
    self.orderLab.text = [NSString stringWithFormat:@"订单号:%@",model.order_id];
    
    NSString *goodsName;
    if([model.goods_name hasSuffix:@","]){
        goodsName = [model.goods_name substringToIndex:([model.goods_name length] - 1)];
    }else{
        goodsName = model.goods_name;
    }
    
    self.goodsNameLab.text = goodsName;
    
    self.dateLab.text = model.addTime;
    self.priceTitLab.text =@"共计：";
    self.priceLab.text = [NSString stringWithFormat:@"%.2f",[model.totalPrice floatValue]];
    self.unitLab.text =@"元";
    if([model.order_status isEqualToString:@"10"]){
        self.stateLab.text = @"未支付";
        [self.toPayBtn setTitle:@"去支付" forState:UIControlStateNormal];
        [_toPayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _toPayBtn.backgroundColor = [UIColor redColor];
        [DCSpeedy dc_chageControlCircularWith:_toPayBtn AndSetCornerRadius:5 SetBorderWidth:1 SetBorderColor:[UIColor redColor]canMasksToBounds:YES];
        [DCSpeedy dc_chageControlCircularWith:_stateLab AndSetCornerRadius:5 SetBorderWidth:1 SetBorderColor:[UIColor redColor]canMasksToBounds:YES];
        self.stateLab.textColor = [UIColor redColor];

    }else if([model.order_status isEqualToString:@"30"]){
        self.stateLab.text = @"待收货";
        [self.toPayBtn setTitle:@"待收货" forState:UIControlStateNormal];
        _toPayBtn.backgroundColor = k_UIColorFromRGB(0xffffff);
        [DCSpeedy dc_chageControlCircularWith:_toPayBtn AndSetCornerRadius:5 SetBorderWidth:1 SetBorderColor:[UIColor orangeColor]canMasksToBounds:YES];
        [DCSpeedy dc_chageControlCircularWith:_stateLab AndSetCornerRadius:5 SetBorderWidth:1 SetBorderColor:[UIColor blackColor]canMasksToBounds:YES];
        [_toPayBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        self.stateLab.textColor = [UIColor blackColor];
    }else if([model.order_status isEqualToString:@"50"]){
        self.stateLab.text = @"已完成";
        [self.toPayBtn setTitle:@"已完成" forState:UIControlStateNormal];
        _toPayBtn.backgroundColor = [UIColor lightGrayColor];
        [_toPayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [DCSpeedy dc_chageControlCircularWith:_toPayBtn AndSetCornerRadius:5 SetBorderWidth:1 SetBorderColor:[UIColor lightGrayColor]canMasksToBounds:YES];
        [DCSpeedy dc_chageControlCircularWith:_stateLab AndSetCornerRadius:5 SetBorderWidth:1 SetBorderColor:[UIColor blackColor]canMasksToBounds:YES];
        self.stateLab.textColor = [UIColor blackColor];
    }else if([model.order_status isEqualToString:@"0"]){
        self.stateLab.text = @"已关闭";
        [self.toPayBtn setTitle:@"已关闭" forState:UIControlStateNormal];
        _toPayBtn.backgroundColor = [UIColor lightGrayColor];
        [_toPayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [DCSpeedy dc_chageControlCircularWith:_toPayBtn AndSetCornerRadius:5 SetBorderWidth:1 SetBorderColor:[UIColor lightGrayColor]canMasksToBounds:YES];
        [DCSpeedy dc_chageControlCircularWith:_stateLab AndSetCornerRadius:5 SetBorderWidth:1 SetBorderColor:[UIColor blackColor]canMasksToBounds:YES];
        self.stateLab.textColor = [UIColor blackColor];
    }

    self.totalLab.text = [NSString stringWithFormat:@"共%@件商品",model.count];
    
    
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectZero];
        _bgView.backgroundColor = k_UIColorFromRGB(0xffffff);
    }
    return _bgView;
}

-(UIImageView *)goodsIV{
    if (!_goodsIV) {
        _goodsIV = [[UIImageView alloc] init];
//        [_goodsIV setBackgroundColor:[UIColor greenColor]];
        [_goodsIV setContentMode:UIViewContentModeScaleAspectFill];
        //        [_goodsIV setClipsToBounds:YES];
    }
    return _goodsIV;
}

- (UIButton *)afterSalebtn {
    if (!_afterSalebtn) {
        _afterSalebtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _afterSalebtn.titleLabel.font = [UIFont systemFontOfSize:kFontNum12];
        _afterSalebtn.backgroundColor = [UIColor clearColor];
        [_afterSalebtn setTitleColor:KColorText878686 forState:UIControlStateNormal];
        [_afterSalebtn addTarget:self action:@selector(afterSaleButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _afterSalebtn;
}

#pragma mark - 售后 点击
- (void)afterSaleButtonClick {
    NSLog(@"售后 点击");
    !_afterSaleBtnClickBlock ? : _afterSaleBtnClickBlock();
}

- (UILabel *)orderLab {
    if (!_orderLab) {
        _orderLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum15 TextColor:[UIColor blackColor]];
//        _orderLab.backgroundColor = [UIColor redColor];
        _orderLab.textAlignment = NSTextAlignmentLeft;
    }
    return _orderLab;
}

- (UILabel *)goodsNameLab {
    if (!_goodsNameLab) {
        _goodsNameLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
        _goodsNameLab.textAlignment = NSTextAlignmentLeft;
    }
    return _goodsNameLab;
}

- (UILabel *)totalLab {
    if (!_totalLab) {
        _totalLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
        _totalLab.textAlignment = NSTextAlignmentLeft;
    }
    return _totalLab;
}

- (UILabel *)dateLab {
    if (!_dateLab) {
        _dateLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
        _dateLab.textAlignment = NSTextAlignmentLeft;
    }
    return _dateLab;
}

- (UILabel *)priceTitLab {
    if (!_priceTitLab) {
        _priceTitLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
        _priceTitLab.textAlignment = NSTextAlignmentLeft;
    }
    return _priceTitLab;
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

- (UILabel *)stateLab {
    if (!_stateLab) {
        _stateLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor redColor]];
//        [DCSpeedy dc_chageControlCircularWith:_stateLab AndSetCornerRadius:5 SetBorderWidth:1 SetBorderColor:[UIColor redColor]canMasksToBounds:YES];
        _stateLab.textAlignment = NSTextAlignmentCenter;
    }
    return _stateLab;
}

- (UIButton *)toPayBtn {
    if (!_toPayBtn) {
        _toPayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [DCSpeedy dc_chageControlCircularWith:_toPayBtn AndSetCornerRadius:10 SetBorderWidth:1 SetBorderColor:k_UIColorFromRGB(0xffffff) canMasksToBounds:YES];
        _toPayBtn.titleLabel.font = [UIFont systemFontOfSize:kFontNum14];
        [_toPayBtn addTarget:self action:@selector(toPayButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _toPayBtn;
}

- (UIButton *)detailBtn {
    if (!_detailBtn) {
        _detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _detailBtn.titleLabel.font = [UIFont systemFontOfSize:kFontNum14];
        _detailBtn.backgroundColor = [UIColor clearColor];
        [_detailBtn setTitle:@"订单详情" forState:UIControlStateNormal];
        [_detailBtn setTitleColor:KColorText878686 forState:UIControlStateNormal];
        [_detailBtn addTarget:self action:@selector(detailButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _detailBtn;
}

-(UIImageView *)rightIV{
    if (!_rightIV) {
        _rightIV = [[UIImageView alloc] init];
        [_rightIV setImage:[UIImage imageNamed:@"ico_home_back_black"]];
        [_rightIV setContentMode:UIViewContentModeScaleAspectFill];
        //        [_goodsIV setClipsToBounds:YES];
    }
    return _rightIV;
}

#pragma mark - 去支付 点击
- (void)toPayButtonClick {
    !_toPayBtnClickBlock ? : _toPayBtnClickBlock();
}

#pragma mark - 订单详情 点击
- (void)detailButtonClick {
    !_detailBtnClickBlock ? : _detailBtnClickBlock();
}

@end
