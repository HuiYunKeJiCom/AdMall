//
//  ADInvoiceViewCell.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/2/9.
//  Copyright © 2018年 Adel. All rights reserved.
//  发票信息

#import "ADInvoiceViewCell.h"
#import "ADOrderBasicModel.h"

@interface ADInvoiceViewCell()
@property (nonatomic, strong) UIView  *bgView;
/** 标题 */
@property(nonatomic,strong)UILabel *titleLab;
/** 横线 */
@property(nonatomic,strong)UIView *lineView;
/** 发票类型 */
@property(nonatomic,strong)UILabel *invoiceTypeLab;
/** 类型 */
@property(nonatomic,strong)UILabel *typeLab;
/** 发票内容 */
@property(nonatomic,strong)UILabel *invoiceContentLab;
/** 内容 */
@property(nonatomic,strong)UILabel *contentLab;

@end

@implementation ADInvoiceViewCell

#pragma mark - Intial
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUpUI];
        [self setUpData];
    }
    
    return self;
}

- (void)setUpUI{
    [self addSubview:self.bgView];
    [self addSubview:self.lineView];
    [self addSubview:self.titleLab];
    [self addSubview:self.invoiceTypeLab];
    [self addSubview:self.typeLab];
    [self addSubview:self.invoiceContentLab];
    [self addSubview:self.contentLab];
    
    [self makeConstraints];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}

#pragma mark - 填充数据
-(void)setUpData{
    self.titleLab.text = @"发票信息";
    self.invoiceTypeLab.text = @"发票类型：";
    self.invoiceContentLab.text = @"发票内容：";
}

-(void)setOrderBasicModel:(ADOrderBasicModel *)orderBasicModel{
    _orderBasicModel = orderBasicModel;
    
    if([orderBasicModel.invoice_type isEqualToString:@"1"]){
        self.typeLab.text = @"电子发票";
    }else if([orderBasicModel.invoice_type isEqualToString:@"2"]){
        self.typeLab.text = @"增值税专用发票";
    }else if([orderBasicModel.invoice_type isEqualToString:@"0"]){
        self.typeLab.text = @"普通发票";
    }
    if([orderBasicModel.invoice_content isEqualToString:@"1"]){
        self.contentLab.text = @"商品类别";
    }else if([orderBasicModel.invoice_content isEqualToString:@"0"]){
        self.contentLab.text = @"商品明细";
    }
    
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
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(10);
        make.top.equalTo(weakSelf.bgView.mas_top).with.offset(10);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.bgView.mas_centerX);
        make.top.equalTo(weakSelf.titleLab.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 1));
    }];
    
    [self.invoiceTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(30);
        make.top.equalTo(weakSelf.lineView.mas_bottom).with.offset(7);
    }];
    
    [self.typeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.invoiceTypeLab.mas_right);
        make.top.equalTo(weakSelf.lineView.mas_bottom).with.offset(7);
    }];
    
    [self.invoiceContentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(30);
        make.top.equalTo(weakSelf.invoiceTypeLab.mas_bottom).with.offset(5);
    }];
    
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.invoiceContentLab.mas_right);
        make.top.equalTo(weakSelf.invoiceTypeLab.mas_bottom).with.offset(5);
    }];
    
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectZero];
        _bgView.backgroundColor = k_UIColorFromRGB(0xffffff);
    }
    return _bgView;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor blackColor]];
    }
    return _titleLab;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectZero];
        _lineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineView;
}

- (UILabel *)invoiceTypeLab {
    if (!_invoiceTypeLab) {
        _invoiceTypeLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _invoiceTypeLab;
}

- (UILabel *)typeLab {
    if (!_typeLab) {
        _typeLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _typeLab;
}

- (UILabel *)invoiceContentLab {
    if (!_invoiceContentLab) {
        _invoiceContentLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _invoiceContentLab;
}

- (UILabel *)contentLab {
    if (!_contentLab) {
        _contentLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _contentLab;
}
@end
