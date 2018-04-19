//
//  ADScoreViewCell.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/12.
//  Copyright © 2018年 Adel. All rights reserved.
//  评价晒单页面

#import "ADScoreViewCell.h"
#import "ADStarView.h"//评分view
#import "UITextView+ZWPlaceHolder.h"
#import <ZWLimitCounter/UITextView+ZWLimitCounter.h>
#import "ADAddImage.h"//上传图片

#import "ADLabelModel.h"//评价标签

@interface ADScoreViewCell()<UITextViewDelegate>
@property (nonatomic, strong) UIView           *bgView;
/** 包装 标题 */
@property(nonatomic,strong)UILabel *packingTItLab;
/** 包装评分 */
@property(nonatomic,strong)ADStarView *packingScoreV;
/** 包装 喜欢 */
@property(nonatomic,strong)UILabel *packingFavorLab;
/** 师傅服务 标题 */
@property(nonatomic,strong)UILabel *masterServiceTItLab;
/** 师傅服务评分 */
@property(nonatomic,strong)ADStarView *masterServiceScoreV;
/** 师傅服务 喜欢 */
@property(nonatomic,strong)UILabel *masterServiceFavorLab;
/** 外观 标题 */
@property(nonatomic,strong)UILabel *surfaceTItLab;
/** 外观评分 */
@property(nonatomic,strong)ADStarView *surfaceScoreV;
/** 外观 喜欢 */
@property(nonatomic,strong)UILabel *surfaceFavorLab;
/** 送货速度 标题 */
@property(nonatomic,strong)UILabel *deliverySpeedTItLab;
/** 送货速度评分 */
@property(nonatomic,strong)ADStarView *deliverySpeedScoreV;
/** 送货速度 喜欢 */
@property(nonatomic,strong)UILabel *deliverySpeedFavorLab;
/** 横线 */
@property(nonatomic,strong)UIView *lineView;
/** 评价内容 */
@property(nonatomic,strong)UITextView *evaluatedContentTV;
/** 图片数组 */
@property(nonatomic,strong)NSMutableArray *imageViewArray;
///** 删除按钮数组 */
//@property(nonatomic,strong)NSMutableArray *buttonArray;
/** 评论按钮 */
@property(nonatomic,strong)UIButton *evaluateBtn;
/** 上传图片view */
@property(nonatomic,strong)ADAddImage *addImageView;


/** 自定义标签的高度 */
@property(nonatomic)float btnHeight;
/** 标签数组 */
@property(nonatomic,strong)NSArray *labelArray;
@end

@implementation ADScoreViewCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.imageViewArray = [NSMutableArray array];
        self.labelArray = [NSArray array];
//        self.buttonArray = [NSMutableArray array];
        self.scoreDict = [NSMutableDictionary dictionary];
        [self setUpUI];
        [self setUpData];
    }
    return self;
}

- (void)setUpUI{
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.packingTItLab];
    [self.bgView addSubview:self.packingScoreV];
    [self.bgView addSubview:self.packingFavorLab];
    [self.bgView addSubview:self.masterServiceTItLab];
    [self.bgView addSubview:self.masterServiceScoreV];
    [self.bgView addSubview:self.masterServiceFavorLab];
    [self.bgView addSubview:self.surfaceTItLab];
    [self.bgView addSubview:self.surfaceScoreV];
    [self.bgView addSubview:self.surfaceFavorLab];
    [self.bgView addSubview:self.deliverySpeedTItLab];
    [self.bgView addSubview:self.deliverySpeedScoreV];
    [self.bgView addSubview:self.deliverySpeedFavorLab];
    [self.bgView addSubview:self.lineView];
    [self.bgView addSubview:self.evaluatedContentTV];
    [self.bgView addSubview:self.addImageView];
    
    [self makeConstraints];
//    [self createLabelAndButton];
//    [self createImageViewAndButton];
    
    //抢购详情的商品id
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getScore:) name:@"score" object:nil];
    
}

//跳转到抢购详情页面
-(void)getScore:(NSNotification *)text{
    [self.scoreDict setValue:[[text.userInfo allValues] firstObject] forKey:[[text.userInfo allKeys] firstObject]];
//    NSLog(@"self.scoreDict = %@",self.scoreDict);
    [self createNotificationWithNSDictionary:self.scoreDict];
}

-(void)createLabelAndButtonWithNSArray:(NSArray *)array{
    self.labelArray = array;
    for(int i=0;i<array.count;i++){
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        if(i == array.count){
            button.backgroundColor = [UIColor whiteColor];
            [button addTarget:self action:@selector(customLabelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [button setTitle:@"+ 自定义标签" forState:UIControlStateNormal];
        }else{
            ADLabelModel *model = array[i];
            button.backgroundColor = kBACKGROUNDCOLOR;
            [button addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [button setTitle:model.label_name forState:UIControlStateNormal];
        }
        button.tag = i;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:kFontNum14];
        CGFloat buttonW = kScreenWidth/3.5;
        CGFloat buttonH = 25;
        CGFloat buttonX = (20+(buttonW +10)* (i%3));
        CGFloat buttonY = (210+30 * (i/3));
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        button.layer.borderWidth=0.5;
        button.layer.borderColor=[UIColor grayColor].CGColor;
        // 设置圆角的大小
        button.layer.cornerRadius = 5;
        [button.layer setMasksToBounds:YES];
        [self.bgView addSubview:button];
        
        self.btnHeight = buttonY + buttonH;
    }
    [self changeFrame];
}

//标签按钮点击事件
-(void)bottomButtonClick:(UIButton *)btn{
    
    btn.selected = !btn.selected;
    if(btn.selected){
        btn.backgroundColor = [UIColor cyanColor];
        
        ADLabelModel *model = self.labelArray[btn.tag];
        NSArray *keyArray = [self.scoreDict allKeys];
        if([keyArray containsObject:@"evaluateLabelId"]){
            NSString *valueStr = [self.scoreDict valueForKey:@"evaluateLabelId"];
            valueStr = [valueStr stringByAppendingFormat:@",%@",model.label_id];
            
            [self.scoreDict setValue:valueStr forKey:@"evaluateLabelId"];
        }else{
            [self.scoreDict setValue:model.label_id forKey:@"evaluateLabelId"];
        }
    }else{
        btn.backgroundColor = kBACKGROUNDCOLOR;
        
        ADLabelModel *model = self.labelArray[btn.tag];
        NSArray *keyArray = [self.scoreDict allKeys];
        if([keyArray containsObject:@"evaluateLabelId"]){
            NSString *valueStr = [self.scoreDict valueForKey:@"evaluateLabelId"];
            NSArray *tempArr = [valueStr componentsSeparatedByString:@","];
            NSMutableArray *valueArray = [NSMutableArray arrayWithArray:tempArr];
            if(tempArr.count == 0){
                [self.scoreDict removeObjectForKey:@"evaluateLabelId"];
            }else if([tempArr containsObject:model.label_id]){
                [valueArray removeObject:model.label_id];
                NSString *newValue;
                for(int i=0;i<valueArray.count;i++){
                    if(i==0){
                        newValue = valueArray[0];
                    }else{
                        newValue = [newValue stringByAppendingFormat:@",%@",valueArray[i]];
                    }
                }
                [self.scoreDict setValue:newValue forKey:@"evaluateLabelId"];
            }
        }
    }
    [self createNotificationWithNSDictionary:self.scoreDict];
}

-(void)customLabelButtonClick:(UIButton *)btn{
    NSLog(@"自定义标签");
    !_addLabelButtonClickBlock ? : _addLabelButtonClickBlock();
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}

#pragma mark - 填充数据
-(void)setUpData{
    self.packingTItLab.text = @"包装";
    self.masterServiceTItLab.text = @"师傅服务";
    self.surfaceTItLab.text = @"外观";
    self.deliverySpeedTItLab.text = @"送货速度";
    self.packingFavorLab.text = @"喜欢";
    self.masterServiceFavorLab.text = @"喜欢";
    self.surfaceFavorLab.text = @"喜欢";
    self.deliverySpeedFavorLab.text = @"喜欢";
}

-(void)changeFrame{
//    NSLog(@"btnHeight = %.2f",self.btnHeight);
    WEAKSELF
    [self.evaluatedContentTV mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.bgView.mas_centerX);
        make.top.equalTo(weakSelf.bgView.mas_top).with.offset(self.btnHeight+10);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth-40, 120));
    }];
    
    [self.addImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(15);
        make.top.equalTo(weakSelf.evaluatedContentTV.mas_bottom).with.offset(10);
        make.width.mas_equalTo(kScreenWidth-30);
        make.height.mas_equalTo(kScreenWidth-60);
        //        make.left.right.top.bottom.mas_equalTo(weak_self.view);
    }];
}

- (void)makeConstraints {
//    NSLog(@"btnHeight = %.2f",self.btnHeight);
    WEAKSELF
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.top.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf.mas_bottom);
    }];
    
    [self.packingTItLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(20);
        make.top.equalTo(weakSelf.bgView.mas_top).with.offset(20);
    }];
    
    [self.packingScoreV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(100);
        make.top.equalTo(weakSelf.bgView.mas_top);
        make.size.mas_equalTo(CGSizeMake(210, 50));
        
        //        make.left.right.top.bottom.mas_equalTo(weak_self.view);
    }];
    
    [self.packingFavorLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.bgView.mas_right).with.offset(-30);
        make.top.equalTo(weakSelf.bgView.mas_top).with.offset(20);
    }];
    
    [self.masterServiceTItLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(20);
        make.top.equalTo(weakSelf.bgView.mas_top).with.offset(70);
    }];
    
    [self.masterServiceScoreV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(100);
        make.top.equalTo(weakSelf.bgView.mas_top).with.offset(50);
        make.size.mas_equalTo(CGSizeMake(210, 50));
        
        //        make.left.right.top.bottom.mas_equalTo(weak_self.view);
    }];
    
    [self.masterServiceFavorLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.bgView.mas_right).with.offset(-30);
        make.top.equalTo(weakSelf.bgView.mas_top).with.offset(70);
    }];
    
    [self.surfaceTItLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(20);
        make.top.equalTo(weakSelf.bgView.mas_top).with.offset(120);
    }];
    
    [self.surfaceScoreV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(100);
        make.top.equalTo(weakSelf.bgView.mas_top).with.offset(100);
        make.size.mas_equalTo(CGSizeMake(210, 50));
        
        //        make.left.right.top.bottom.mas_equalTo(weak_self.view);
    }];
    
    [self.surfaceFavorLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.bgView.mas_right).with.offset(-30);
        make.top.equalTo(weakSelf.bgView.mas_top).with.offset(120);
    }];
    
    [self.deliverySpeedTItLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(20);
        make.top.equalTo(weakSelf.bgView.mas_top).with.offset(170);
    }];
    
    [self.deliverySpeedScoreV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(100);
        make.top.equalTo(weakSelf.bgView.mas_top).with.offset(150);
        make.size.mas_equalTo(CGSizeMake(210, 50));
        
        //        make.left.right.top.bottom.mas_equalTo(weak_self.view);
    }];
    
    [self.deliverySpeedFavorLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.bgView.mas_right).with.offset(-30);
        make.top.equalTo(weakSelf.bgView.mas_top).with.offset(170);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
        make.bottom.equalTo(weakSelf.deliverySpeedScoreV.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth-40, 1));
    }];
    
    [self.evaluatedContentTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.bgView.mas_centerX);
        make.top.equalTo(weakSelf.bgView.mas_top).with.offset(self.btnHeight+10);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth-40, 120));
    }];
    
    [self.addImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(15);
        make.top.equalTo(weakSelf.evaluatedContentTV.mas_bottom).with.offset(10);
        make.width.mas_equalTo(kScreenWidth-30);
        make.height.mas_equalTo(kScreenWidth-60);
        //        make.left.right.top.bottom.mas_equalTo(weak_self.view);
    }];
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectZero];
        _bgView.backgroundColor = k_UIColorFromRGB(0xffffff);
    }
    return _bgView;
}

- (UILabel *)packingTItLab {
    if (!_packingTItLab) {
        _packingTItLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor blackColor]];
    }
    return _packingTItLab;
}

- (ADStarView *)packingScoreV {
    if (!_packingScoreV) {
        _packingScoreV = [[ADStarView alloc] init];
        _packingScoreV.tag = 1;
//        _packingScoreV.backgroundColor = [UIColor greenColor];
    }
    return _packingScoreV;
}

- (UILabel *)packingFavorLab {
    if (!_packingFavorLab) {
        _packingFavorLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor blackColor]];
    }
    return _packingFavorLab;
}

- (UILabel *)masterServiceTItLab {
    if (!_masterServiceTItLab) {
        _masterServiceTItLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor blackColor]];
    }
    return _masterServiceTItLab;
}

- (ADStarView *)masterServiceScoreV {
    if (!_masterServiceScoreV) {
        _masterServiceScoreV = [[ADStarView alloc] init];
        _masterServiceScoreV.tag = 2;
//        _masterServiceScoreV.backgroundColor = [UIColor greenColor];
    }
    return _masterServiceScoreV;
}

- (UILabel *)masterServiceFavorLab {
    if (!_masterServiceFavorLab) {
        _masterServiceFavorLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor blackColor]];
    }
    return _masterServiceFavorLab;
}

- (UILabel *)surfaceTItLab {
    if (!_surfaceTItLab) {
        _surfaceTItLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor blackColor]];
    }
    return _surfaceTItLab;
}

- (ADStarView *)surfaceScoreV {
    if (!_surfaceScoreV) {
        _surfaceScoreV = [[ADStarView alloc] init];
        _surfaceScoreV.tag = 3;
//        _surfaceScoreV.backgroundColor = [UIColor greenColor];
    }
    return _surfaceScoreV;
}

- (UILabel *)surfaceFavorLab {
    if (!_surfaceFavorLab) {
        _surfaceFavorLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor blackColor]];
    }
    return _surfaceFavorLab;
}

- (UILabel *)deliverySpeedTItLab {
    if (!_deliverySpeedTItLab) {
        _deliverySpeedTItLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor blackColor]];
    }
    return _deliverySpeedTItLab;
}

- (ADStarView *)deliverySpeedScoreV {
    if (!_deliverySpeedScoreV) {
        _deliverySpeedScoreV = [[ADStarView alloc] init];
        _deliverySpeedScoreV.tag = 4;
//        _deliverySpeedScoreV.backgroundColor = [UIColor greenColor];
    }
    
    return _deliverySpeedScoreV;
}

- (UILabel *)deliverySpeedFavorLab {
    if (!_deliverySpeedFavorLab) {
        _deliverySpeedFavorLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor blackColor]];
    }
    return _deliverySpeedFavorLab;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectZero];
        _lineView.backgroundColor = [UIColor blackColor];
    }
    return _lineView;
}

- (UITextView *)evaluatedContentTV {
    if (!_evaluatedContentTV) {
        _evaluatedContentTV = [[UITextView alloc] initWithFrame:CGRectZero];
//        _evaluatedContentTV.clearButtonMode = UITextFieldViewModeWhileEditing;
//        _evaluatedContentTV.placeholder = @"回复楼主";
        _evaluatedContentTV.textColor = [UIColor lightGrayColor];
        _evaluatedContentTV.backgroundColor = [UIColor whiteColor];
        _evaluatedContentTV.layer.borderWidth = 1;
        _evaluatedContentTV.font = [UIFont systemFontOfSize:14];
        _evaluatedContentTV.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _evaluatedContentTV.delegate = self;
        //文字设置居右、placeHolder会跟随设置
        //    textView.textAlignment = NSTextAlignmentRight;
        _evaluatedContentTV.zw_placeHolder = @"请从产品质量、师傅服务质量、物流货运评价";
//        _evaluatedContentTV.zw_limitCount = 150;//字数限制
        _evaluatedContentTV.zw_placeHolderColor = [UIColor lightGrayColor];
        _evaluatedContentTV.layer.cornerRadius = 5;
        [_evaluatedContentTV.layer setMasksToBounds:YES];
    }
    return _evaluatedContentTV;
}

- (ADAddImage *)addImageView {
    if (!_addImageView) {
        _addImageView = [[ADAddImage alloc] initWithFrame:CGRectZero];
        _addImageView.backgroundColor = k_UIColorFromRGB(0xffffff);//k_UIColorFromRGB(0xffffff)
    }
    return _addImageView;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
//    NSLog(@"textViewDidEndEditing");
    if(![textView.text isEmptyOrNull]){
        [self.scoreDict setValue:textView.text forKey:@"evaluateInfo"];
    }else{
        [self.scoreDict removeObjectForKey:@"evaluateInfo"];
    }
    [self createNotificationWithNSDictionary:self.scoreDict];
    
//    NSLog(@"self.scoreDict = %@",self.scoreDict);
}

-(void)createNotificationWithNSDictionary:(NSDictionary *)dict{
        //创建通知
        NSNotification *notification =[NSNotification notificationWithName:@"scoreDict" object:nil userInfo:dict];
        //通过通知中心发送通知
        NSLog(@"评价字典发通知了");
        [[NSNotificationCenter defaultCenter] postNotification:notification];
}

@end
