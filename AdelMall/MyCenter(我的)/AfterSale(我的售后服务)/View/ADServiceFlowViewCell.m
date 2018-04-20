//
//  ADServiceFlowViewCell.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/2.
//  Copyright © 2018年 Adel. All rights reserved.
//  售后服务单详情-售后流程

#import "ADServiceFlowViewCell.h"
@interface ADServiceFlowViewCell()
@property (nonatomic, strong) UIView  *bgView;
/** 标题 */
@property(nonatomic,strong)UILabel *titleLab;
/* 查看 */
@property (strong, nonatomic) UILabel        *numLb;
@property (strong, nonatomic) UIImageView    *arrowImgView;
/** 查看 按钮 */
@property(nonatomic,strong)UIButton *checkBtn;
/** 横线 */
@property(nonatomic,strong)UIView *lineView;
/** 流程图 */
@property(nonatomic,strong)UIImageView *flowIV;
/** 提交申请 */
@property(nonatomic,strong)UILabel *submissionLab;
/** 客服审核 */
@property(nonatomic,strong)UILabel *customerServiceLab;
/** 商家收货 */
@property(nonatomic,strong)UILabel *goodsReceiptLab;
/** 商家处理 */
@property(nonatomic,strong)UILabel *businessProcessingLab;
/** 售后完成 */
@property(nonatomic,strong)UILabel *completionLab;
/** 提交时间 标题*/
@property(nonatomic,strong)UILabel *applyTimeTitLab;
/** 提交时间 */
@property(nonatomic,strong)UILabel *applyTimeLab;
@end

@implementation ADServiceFlowViewCell
#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
        [self setUpData];
    }
    return self;
}

- (void)setUpUI{
    [self addSubview:self.bgView];
    [self addSubview:self.lineView];
    [self addSubview:self.titleLab];
    [self addSubview:self.numLb];
    [self addSubview:self.arrowImgView];
    [self addSubview:self.checkBtn];
    [self addSubview:self.flowIV];
    [self addSubview:self.submissionLab];
    [self addSubview:self.customerServiceLab];
    [self addSubview:self.goodsReceiptLab];
    [self addSubview:self.businessProcessingLab];
    [self addSubview:self.completionLab];
    [self addSubview:self.applyTimeTitLab];
    [self addSubview:self.applyTimeLab];
     [self makeConstraints];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
   
}

#pragma mark - 填充数据
-(void)setUpData{
    self.titleLab.text = @"售后流程";
//    [self.checkBtn setTitle:@"查看 >" forState:UIControlStateNormal];
    self.submissionLab.text = @"提交申请";
    self.customerServiceLab.text = @"客服审核";
    self.goodsReceiptLab.text = @"商家收货";
    self.businessProcessingLab.text = @"商家处理";
    self.completionLab.text = @"售后完成";
    self.applyTimeTitLab.text = @"提交申请时间:";
    self.applyTimeLab.text = @"2017/01/01";
    self.numLb.text = @"查看";
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
    
    [self.checkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.bgView.mas_right).with.offset(-15);
        make.centerY.equalTo(weakSelf.titleLab.mas_centerY);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
    }];
    
    [self.arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.bgView.mas_right).with.offset(-15);
        make.centerY.equalTo(weakSelf.titleLab.mas_centerY);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    
    [self.numLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.arrowImgView.mas_left).with.offset(0);
        make.centerY.equalTo(weakSelf.titleLab.mas_centerY);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.bgView.mas_centerX);
        make.top.equalTo(weakSelf.titleLab.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 1));
    }];
    
    [self.flowIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.top.equalTo(weakSelf.lineView.mas_bottom).with.offset(10);
//        make.height.mas_equalTo(57);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 38*kScreenWidth/360));
    }];
    
    [self.submissionLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(30);
        make.top.equalTo(weakSelf.flowIV.mas_bottom).with.offset(10);
    }];
    
    [self.customerServiceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.submissionLab.mas_right).with.offset(28);
        make.top.equalTo(weakSelf.flowIV.mas_bottom).with.offset(10);
    }];
    
    [self.goodsReceiptLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.customerServiceLab.mas_right).with.offset(28);
        make.top.equalTo(weakSelf.flowIV.mas_bottom).with.offset(10);
    }];
    
    [self.businessProcessingLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.goodsReceiptLab.mas_right).with.offset(28);
        make.top.equalTo(weakSelf.flowIV.mas_bottom).with.offset(10);
    }];
    
    [self.completionLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.businessProcessingLab.mas_right).with.offset(28);
        make.top.equalTo(weakSelf.flowIV.mas_bottom).with.offset(10);
    }];
    
    [self.applyTimeTitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.bgView.mas_centerX);
        make.top.equalTo(weakSelf.goodsReceiptLab.mas_bottom).with.offset(10);
    }];

    [self.applyTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_centerX).with.offset(5);
        make.top.equalTo(weakSelf.goodsReceiptLab.mas_bottom).with.offset(10);
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

-(UIImageView *)flowIV{
    if (!_flowIV) {
        _flowIV = [[UIImageView alloc] init];
        _flowIV.image = [UIImage imageNamed:@"shouhou_progress_2"];;
//        _flowIV.backgroundColor = [UIColor redColor];
        [_flowIV setContentMode:UIViewContentModeScaleAspectFill];
    }
    return _flowIV;
}

- (UILabel *)submissionLab {
    if (!_submissionLab) {
        _submissionLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _submissionLab;
}

- (UILabel *)customerServiceLab {
    if (!_customerServiceLab) {
        _customerServiceLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _customerServiceLab;
}

- (UILabel *)businessProcessingLab {
    if (!_businessProcessingLab) {
        _businessProcessingLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _businessProcessingLab;
}

- (UILabel *)goodsReceiptLab {
    if (!_goodsReceiptLab) {
        _goodsReceiptLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _goodsReceiptLab;
}

- (UILabel *)completionLab {
    if (!_completionLab) {
        _completionLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor blackColor]];
    }
    return _completionLab;
}

- (UILabel *)applyTimeTitLab {
    if (!_applyTimeTitLab) {
        _applyTimeTitLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor lightGrayColor]];
    }
    return _applyTimeTitLab;
}

- (UILabel *)applyTimeLab {
    if (!_applyTimeLab) {
        _applyTimeLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor lightGrayColor]];
    }
    return _applyTimeLab;
}

- (UILabel *)numLb {
    if (!_numLb) {
        _numLb = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum13 TextColor:KColorText878686];
        _numLb.textAlignment = NSTextAlignmentRight;
    }
    return _numLb;
}

- (UIImageView *)arrowImgView {
    if (!_arrowImgView) {
        _arrowImgView = [[UIImageView alloc] initWithImage:IMAGE(@"ico_home_back_black")];
    }
    return _arrowImgView;
}

- (UIButton *)checkBtn {
    if (!_checkBtn) {
        _checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _checkBtn.backgroundColor = [UIColor clearColor];
        [_checkBtn addTarget:self action:@selector(checkButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _checkBtn;
}

#pragma mark - 查看 点击
- (void)checkButtonClick {
    NSLog(@"点击了 查看");
    !_checkBtnClickBlock ? : _checkBtnClickBlock();
}


@end
