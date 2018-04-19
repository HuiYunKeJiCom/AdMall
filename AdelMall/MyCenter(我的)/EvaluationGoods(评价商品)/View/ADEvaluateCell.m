//
//  ADEvaluateCell.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/10.
//  Copyright © 2018年 Adel. All rights reserved.
//  评论Cell

#import "ADEvaluateCell.h"

@interface ADEvaluateCell()
@property (nonatomic, strong) UIView           *bgView;
/** 商品图片 */
@property(nonatomic,strong)UIImageView *goodsIV;
/** 商品名称 */
@property(nonatomic,strong)UILabel *goodsNameLab;
/** 商品类型 */
@property(nonatomic,strong)UILabel *typeLab;
/** 价格 */
@property(nonatomic,strong)UILabel *priceLab;
/** 价格单位 */
@property(nonatomic,strong)UILabel *unitLab;
/** 评价人数 */
@property(nonatomic,strong)UILabel *advertiseLab;
/** 评价人数标题 */
@property(nonatomic,strong)UILabel *evaluateNumLab;
/** 去评价 按钮 */
@property(nonatomic,strong)UIButton *evaluateBtn;
@end

@implementation ADEvaluateCell

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
        [self addSubview:self.evaluateNumLab];
        [self addSubview:self.evaluateBtn];
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
        make.width.mas_equalTo(kScreenWidth*0.34);
    }];
    
    [self.goodsNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.bgView.mas_right).with.offset(-20);
        make.top.equalTo(weakSelf.bgView.mas_top).with.offset(20);
    }];
    
    [self.typeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.bgView.mas_right).with.offset(-20);
        make.top.equalTo(weakSelf.goodsNameLab.mas_bottom).with.offset(10);
    }];
    
    [self.unitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.bgView.mas_right).with.offset(-20);
        make.top.equalTo(weakSelf.typeLab.mas_bottom).with.offset(5);
    }];
    
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.unitLab.mas_left).with.offset(-5);
        make.top.equalTo(weakSelf.typeLab.mas_bottom).with.offset(5);
    }];
    
    [self.evaluateNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.bgView.mas_right).with.offset(-20);
        make.top.equalTo(weakSelf.unitLab.mas_bottom).with.offset(5);
    }];
    
    [self.advertiseLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.evaluateNumLab.mas_left).with.offset(-5);
        make.top.equalTo(weakSelf.unitLab.mas_bottom).with.offset(5);
    }];
    
    [self.evaluateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.bgView.mas_right).with.offset(-20);
        make.top.equalTo(weakSelf.evaluateNumLab.mas_bottom).with.offset(5);
        make.width.mas_equalTo(GetScaleWidth(70));
        make.height.mas_equalTo(25);
    }];

}

- (void)setModel:(ADEvaluateModel *)model {
    _model = model;
    
    [self.goodsIV sd_setImageWithURL:[NSURL URLWithString:self.model.goods_image_path]];
    self.goodsNameLab.text = model.goods_name;
//    self.typeLab.text = model.goodsType;
    self.advertiseLab.text = model.goods_evaluates_size;
    self.priceLab.text = model.goods_current_price;
    self.unitLab.text = @"元";
    
    if([model.evaluate_status isEqualToString:@"0"]){
        [self.evaluateBtn setTitle:@"去评价" forState:UIControlStateNormal];
        self.evaluateBtn.userInteractionEnabled = YES;
        self.evaluateBtn.backgroundColor = [UIColor redColor];
    }else if([model.evaluate_status isEqualToString:@"1"]){
        [self.evaluateBtn setTitle:@"已评价" forState:UIControlStateNormal];
        self.evaluateBtn.userInteractionEnabled = NO;
        self.evaluateBtn.backgroundColor = [UIColor lightGrayColor];
    }else if([model.evaluate_status isEqualToString:@"2"]){
        [self.evaluateBtn setTitle:@"已失效" forState:UIControlStateNormal];
        self.evaluateBtn.userInteractionEnabled = NO;
        self.evaluateBtn.backgroundColor = [UIColor lightGrayColor];
    }
    self.evaluateNumLab.text = @"人已评价";
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

- (UILabel *)evaluateNumLab {
    if (!_evaluateNumLab) {
        _evaluateNumLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum13 TextColor:[UIColor lightGrayColor]];
    }
    return _evaluateNumLab;
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
//        [_goodsIV setBackgroundColor:[UIColor greenColor]];
        [_goodsIV setContentMode:UIViewContentModeScaleAspectFill];
        //        [_goodsIV setClipsToBounds:YES];
    }
    return _goodsIV;
}

- (UIButton *)evaluateBtn {
    if (!_evaluateBtn) {
        _evaluateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _evaluateBtn.titleLabel.font = [UIFont systemFontOfSize:kFontNum12];
        // 设置圆角的大小
        _evaluateBtn.layer.cornerRadius = 5;
        [_evaluateBtn.layer setMasksToBounds:YES];
        [_evaluateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_evaluateBtn addTarget:self action:@selector(evaluateBtnButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _evaluateBtn;
}

#pragma mark - 去评价 点击
- (void)evaluateBtnButtonClick {
    NSLog(@"去评价 点击");
    !_evaluateBtnClickBlock ? : _evaluateBtnClickBlock();
}
@end
