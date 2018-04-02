//
//  ADGoodsSpecCell.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/17.
//  Copyright © 2018年 Adel. All rights reserved.
//  商品规格

#import "ADGoodsSpecCell.h"
//#import "GoodAttrModel.h"
//#import "GoodAttributesView.h"
#import "ADGoodsSpecModel.h"
#import "AttributeView.h"
#import "ADGoodsSpecModel.h"
#import "UIView+Extension.h"
#import "ADProsModel.h"

// 筛选框 上下的图片
#define kDownImg [UIImage imageNamed:@"arrow_down.png"]
#define kUpImg [UIImage imageNamed:@"arrow_up.png"]

@interface ADGoodsSpecCell()<AttributeViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong) UIView* bgView;
/** 购买数量Lbl */
@property (nonatomic, weak) UITextField *buyNumsLbl;
/** 已选择 标题 */
@property (strong , nonatomic)UILabel *chosenTitLabel;
/** 已选择  */
@property (strong , nonatomic)UILabel *chosenLabel;
///** 规格选择View  */
//@property (strong , nonatomic)GoodAttributesView *attributesView;
/** 规格选择View  */
@property (strong , nonatomic)UIView *specView;
/** 展开选择页面 按钮 */
@property(nonatomic,strong)UIButton *openSpecViewBtn;

/** 是否打开地址筛选框 */
@property(nonatomic,assign)BOOL isOpen;

/** 规格字典 */
@property(nonatomic,strong)NSMutableDictionary *specDict;
@end


@implementation ADGoodsSpecCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        //        self.userInteractionEnabled = YES;
        [self setUpUI];
        [self setUpData];
    }
    return self;
}

- (void)setUpUI{
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.chosenTitLabel];
    [self.bgView addSubview:self.chosenLabel];
    [self.bgView addSubview:self.openSpecViewBtn];
    
    //抢购详情的商品id
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getGoodAttrsArr:) name:@"specItem" object:nil];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self makeConstraints];
}

#pragma mark - 填充数据
-(void)setUpData{
    self.chosenTitLabel.text = @"未选择:";
    self.chosenLabel.text = @"类型/数量";
//    [self.openSpecViewBtn setTitle:@"v" forState:UIControlStateNormal];
    [self.openSpecViewBtn setImage:kDownImg forState:UIControlStateNormal];
}

//跳转到抢购详情页面
-(void)getGoodAttrsArr:(NSNotification *)text{
    self.goodAttrsArr = text.userInfo[@"specItem"];
}



- (void)createAttributesViewWith:(NSMutableArray *)array {
    
    float height = 0;
    self.specView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, kScreenWidth, height)];
    [self addSubview:self.specView];
    
    for(int i=0;i<self.goodAttrsArr.count;i++){
        ADGoodsSpecModel *model = self.goodAttrsArr[i];
        AttributeView *attributeViewGJ = [AttributeView attributeViewWithTitle:model.spec_name titleFont:[UIFont boldSystemFontOfSize:13] attributeTexts:model.pros viewWidth:kScreenWidth];
        if(i==0){
            UIView *line1=[[UIView alloc] initWithFrame:CGRectMake(0, 1, kScreenWidth, 1)];
            line1.backgroundColor=[UIColor lightGrayColor];
            [attributeViewGJ addSubview:line1];
        }
        attributeViewGJ.y = height;
        attributeViewGJ.Attribute_delegate = self;
        height = CGRectGetMaxY(attributeViewGJ.frame);
        [self.specView addSubview:attributeViewGJ];
        attributeViewGJ.tag = 2000+i;
    }
    UILabel *numLab=[[UILabel alloc] initWithFrame:CGRectMake(kBigMargin, height+kSmallMargin+5, 80, kBigMargin)];
    [numLab setText:@"数量"];
    numLab.font=kContentTextFont;
    numLab.textColor= [UIColor blackColor];
    [self.specView addSubview:numLab];
    
    UIButton *minusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [minusBtn setTitle:@"-" forState:UIControlStateNormal];
    CGFloat minusBtnWH = 35;
    CGFloat minusBtnX = kBigMargin;
    CGFloat minusBtnY = CGRectGetMaxY(numLab.frame)+15;
    minusBtn.frame = CGRectMake(minusBtnX, minusBtnY, minusBtnWH, minusBtnWH);
    [minusBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [minusBtn setTitleColor:HX_RGB(125, 125, 125) forState:UIControlStateHighlighted];
    minusBtn.layer.borderColor = LXBorderColor.CGColor;
    minusBtn.layer.cornerRadius = 1;
    [minusBtn setBackgroundImage:[self buttonImageFromColor:HX_RGB(136, 137, 138)] forState:UIControlStateNormal];
    [minusBtn setBackgroundImage:[self buttonImageFromColor:kMAINCOLOR] forState:UIControlStateHighlighted];
    [minusBtn addTarget:self action:@selector(minusBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.specView addSubview:minusBtn];
    
    // count
    UITextField *buyNumsLbl = [[UITextField alloc] init];
    buyNumsLbl.text = [NSString stringWithFormat:@"%d", self.buyNum];
    buyNumsLbl.textAlignment = NSTextAlignmentCenter;
    buyNumsLbl.layer.borderWidth = 1;
    buyNumsLbl.layer.borderColor = LXBorderColor.CGColor;
    buyNumsLbl.delegate = self;
    CGFloat buyNumsLblW = minusBtnWH * 2;
    CGFloat buyNumsLblH = minusBtnWH;
    CGFloat buyNumsLblX = CGRectGetMaxX(minusBtn.frame) - 1+kSmallMargin;
    CGFloat buyNumsLblY = minusBtnY;
    buyNumsLbl.frame = CGRectMake(buyNumsLblX, buyNumsLblY, buyNumsLblW, buyNumsLblH);
    [self.specView addSubview:buyNumsLbl];
    self.buyNumsLbl = buyNumsLbl;
    
    // +
    UIButton *plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [plusBtn setTitle:@"+" forState:UIControlStateNormal];
    CGFloat plusBtnWH = 35;
    CGFloat plusBtnX = CGRectGetMaxX(buyNumsLbl.frame)+kSmallMargin;
    CGFloat plusBtnY = minusBtnY;
    plusBtn.frame = CGRectMake(plusBtnX, plusBtnY, plusBtnWH, plusBtnWH);
    [plusBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [plusBtn setTitleColor:HX_RGB(125, 125, 125) forState:UIControlStateHighlighted];
    plusBtn.layer.borderColor = LXBorderColor.CGColor;
    plusBtn.layer.cornerRadius = 1;
    [plusBtn setBackgroundImage:[self buttonImageFromColor:HX_RGB(136, 137, 138)] forState:UIControlStateNormal];
    [plusBtn setBackgroundImage:[self buttonImageFromColor:kMAINCOLOR] forState:UIControlStateHighlighted];
    [plusBtn addTarget:self action:@selector(plusBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.specView addSubview:plusBtn];
    
    self.specView.height = CGRectGetMaxY(plusBtn.frame)+kBigMargin;
    
}

- (void)makeConstraints {
    WEAKSELF
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.top.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf.mas_bottom);
//        make.height.mas_equalTo(40);
    }];
    
    [self.chosenTitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(40);
        make.top.equalTo(weakSelf.bgView.mas_top).with.offset(10);
    }];
    
    [self.chosenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.chosenTitLabel.mas_right).with.offset(20);
        make.top.equalTo(weakSelf.bgView.mas_top).with.offset(10);
    }];
    
    [self.openSpecViewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.bgView.mas_right).with.offset(-16);
        make.top.equalTo(weakSelf.bgView.mas_top).with.offset(10);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(20);
    }];

}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectZero];
        _bgView.backgroundColor = [UIColor whiteColor];
        //        _bgView.userInteractionEnabled = YES;
    }
    return _bgView;
}

- (UILabel *)chosenTitLabel {
    if (!_chosenTitLabel) {
        _chosenTitLabel = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor blackColor]];
    }
    return _chosenTitLabel;
}

- (UILabel *)chosenLabel {
    if (!_chosenLabel) {
        _chosenLabel = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor blackColor]];
    }
    return _chosenLabel;
}

- (UIButton *)openSpecViewBtn {
    if (!_openSpecViewBtn) {
        _openSpecViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _openSpecViewBtn.titleLabel.font = [UIFont systemFontOfSize:kFontNum11];
        _openSpecViewBtn.backgroundColor = [UIColor clearColor];
        [_openSpecViewBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_openSpecViewBtn addTarget:self action:@selector(openSpecViewBtnButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _openSpecViewBtn;
}

#pragma mark - 展开选择页面 点击
- (void)openSpecViewBtnButtonClick {
    WEAKSELF
    NSLog(@"展开选择页面");
    if(self.isOpen){
        NSLog(@"收起");
        
        if(self.specDict){
            NSArray *valueArr = [self.specDict allValues];
            NSString *chosenString = nil;
            if(self.goodAttrsArr.count == valueArr.count){
                self.isOpen = NO;
                [self.openSpecViewBtn setImage:kDownImg forState:UIControlStateNormal];
                weakSelf.chosenTitLabel.text = @"已选择:";
                for(int i=0;i<valueArr.count;i++){
                    if(i==0){
                        chosenString = [NSString stringWithFormat:@"\"%@\"、",valueArr[i]];
                    }else{
                        chosenString = [chosenString stringByAppendingString:[NSString stringWithFormat:@"\"%@\"、",valueArr[i]]];
                    }
                }
                chosenString = [chosenString stringByAppendingString:[NSString stringWithFormat:@"数量:%d",self.buyNum]];
                weakSelf.chosenLabel.text = chosenString;
                //            weakSelf.chosenLabel.text = [NSString stringWithFormat:@"\"%@\"、\"%@\"、数量:%@",,,self.buyNum];
                [self.specView removeFromSuperview];
                [self closeView];
            }else{
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.superview animated:YES];
                hud.detailsLabelText = @"您还有未选择的规格";
                hud.mode = MBProgressHUDModeText;
                [hud hide:YES afterDelay:1.0];
            }
            }
    }else{
        NSLog(@"展开");
        self.isOpen = YES;
        [self.openSpecViewBtn setImage:kUpImg forState:UIControlStateNormal];
        [self createAttributesViewWith:self.goodAttrsArr];
        [self openView];
    }
}

-(void)openView{
    !_openViewClickBlock ? : _openViewClickBlock();
}

-(void)closeView{
    !_closeViewClickBlock ? : _closeViewClickBlock();
}

- (UIImage *) buttonImageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (void)minusBtnClick {
    if (self.buyNum == 1) return;
    
    self.buyNumsLbl.text = [NSString stringWithFormat:@"%d", --self.buyNum];
}

- (void)plusBtnClick {
    self.buyNumsLbl.text = [NSString stringWithFormat:@"%d", ++self.buyNum];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.buyNum = [self.buyNumsLbl.text intValue];
}

//规格选择
-(void)Attribute_View:(AttributeView *)view didClickBtn:(UIButton *)btn{
    ADProsModel *model = (ADProsModel *)view.textsArr[btn.tag];
    [self.specDict setValue:model.pro_value forKey:view.titleString];
    NSLog(@"self.specDict = %@",self.specDict);
}

-(NSMutableDictionary *)specDict{
    if (!_specDict) {
        _specDict = [NSMutableDictionary dictionary];
    }
    return _specDict;
}

-(NSMutableArray *)goodAttrsArr{
    if (!_goodAttrsArr) {
        _goodAttrsArr = [NSMutableArray array];
    }
    return _goodAttrsArr;
}
@end
