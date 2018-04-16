//
//  ADGoodsDetailViewController.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/2/6.
//  Copyright © 2018年 Adel. All rights reserved.
//  商品详情

#import "ADGoodsDetailViewController.h"
#import "ADOrderTopToolView.h"
#import "orderHeader.h"
#import "ADDetailViewController.h"//详情
#import "ADGoodsParameterViewController.h"//参数
#import "ADUserEvaluationViewController.h"//用户评论
#import "ADRelatedGoodsViewController.h"//相关商品
#import "ADTopLoginView.h"
#import "DCTabBarController.h"
#import "ADPlaceOrderViewController.h"

#import "ADGoodsDetailModel.h"//商品详情模型
#import "ADPropertyModel.h"//商品参数模型
#import "ADGoodsSpecModel.h"//规格模型
#import "ADProsModel.h"//规格值模型
#import "AttributeView.h"
#import "UIView+Extension.h"

@interface ADGoodsDetailViewController ()<UIScrollViewDelegate,AttributeViewDelegate,UITextFieldDelegate>{
    UIScrollView *_scrollView;
    orderHeader *_headView;
    BOOL _isup;
}
/** 商品id */
@property (nonatomic, copy) NSString *goodsID;
/* 去登录页面 */
@property (strong , nonatomic)ADTopLoginView *toLoginView;
/* 顶部Nva */
@property (strong , nonatomic)ADOrderTopToolView *topToolView;
/** 商品详情-用户评论 */
@property(nonatomic,strong)ADUserEvaluationViewController *evaluationvc;
/* 商品规格数组 */
@property (strong , nonatomic)NSMutableArray<ADGoodsSpecModel *> *specItem;

/** 商品详情模型 */
@property(nonatomic,strong)ADGoodsDetailModel *model;

/** 购买数量Lbl */
@property (nonatomic, weak) UITextField *buyNumsLbl;
/** 规格选择View  */
@property (strong , nonatomic)UIView *specShowView;
/** 规格选择View  */
@property (strong , nonatomic)UIView *specView;
/** 规格字典 */
@property(nonatomic,strong)NSMutableDictionary *specDict;
/** 规格id字典 */
@property(nonatomic,strong)NSMutableDictionary *specIdDict;
@end

@implementation ADGoodsDetailViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor lightGrayColor];
    if (self.index) {
        
        [self changeScrollview:self.index];
        
        //UIScrollViewDecelerationRateFast;
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.buyNum = 1;
//    self.view.userInteractionEnabled = YES;
    [self setUpNavTopView];
    [self.view addSubview:self.toLoginView];
    [self createUI];
    [self setUpBottomButton];
    [self.view bringSubviewToFront:self.toLoginView];
    
}

- (ADTopLoginView *)toLoginView
{
    WEAKSELF
    if (!_toLoginView) {
        _toLoginView = [[ADTopLoginView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 40)];
        _toLoginView.backgroundColor = [UIColor lightTextColor];
        _toLoginView.toLoginClickBlock = ^{
            NSLog(@"跳转到登录页面");
        };
        _toLoginView.closeClickBlock = ^{
            NSLog(@"关闭按钮");
            [weakSelf hideToLoginView];
        };
    }
    return _toLoginView;
}

-(void)loadDataWithGoodsID:(NSString *)goodsID{
//    NSLog(@"goodsID = %@",goodsID);
    goodsID = @"98461";
    self.goodsID = goodsID;
//    NSLog(@"self.goodsID = %@",self.goodsID);
    WEAKSELF
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [RequestTool getGoods:@{@"id":goodsID} withSuccessBlock:^(NSDictionary *result) {
        NSLog(@"商品详情result = %@",result);
        if([result[@"code"] integerValue] == 1){
            [hud hide:YES];
            [weakSelf getDataWithNSDictionary:result];
        }else if([result[@"code"] integerValue] == -2){
            hud.detailsLabelText = @"登录失效";
            hud.mode = MBProgressHUDModeText;
            [hud hide:YES afterDelay:1.0];
        }else if([result[@"code"] integerValue] == -1){
            hud.detailsLabelText = @"未登录";
            hud.mode = MBProgressHUDModeText;
            [hud hide:YES afterDelay:1.0];
        }else if([result[@"code"] integerValue] == 0){
            hud.detailsLabelText = @"失败";
            hud.mode = MBProgressHUDModeText;
            [hud hide:YES afterDelay:1.0];
        }else if([result[@"code"] integerValue] == 2){
            hud.detailsLabelText = @"无返回数据";
            hud.mode = MBProgressHUDModeText;
            [hud hide:YES afterDelay:1.0];
        }
    } withFailBlock:^(NSString *msg) {
        NSLog(@"商品详情msg = %@",msg);
        hud.detailsLabelText = msg;
        hud.mode = MBProgressHUDModeText;
        [hud hide:YES afterDelay:1.0];
    }];
    
}

-(void)getDataWithNSDictionary:(NSDictionary *)dict
{
    //规格页面
    NSArray *specArr = dict[@"data"][@"specs"];
//    NSLog(@"specArr = %@",specArr);
    if(specArr){
        _specItem = [ADGoodsSpecModel mj_objectArrayWithKeyValuesArray:specArr];
        for(int i=0;i<_specItem.count;i++){
            ADGoodsSpecModel *model = _specItem[i];
            model.pros = [ADProsModel mj_objectArrayWithKeyValuesArray:model.pros];
            [self createAttributesViewWith:self.specItem];
        }
        

        //商品数据
        NSArray *goodsArr = dict[@"data"][@"goods"];
        if(goodsArr){
            self.model = [ADGoodsDetailModel mj_objectWithKeyValues:goodsArr];
//            NSLog(@"商品详情model.goods_property = %@",self.model.goods_property);
            [self addViewControllsToScrollView];
        }
        
    }
}


-(void)hideToLoginView{
    [UIView animateWithDuration:0.5 animations:^{
        self.toLoginView.alpha = 0.0;
        _headView.frame = CGRectMake(0, 64, kScreenWidth, 40);
    }];

}

-(void)createUI{
//    self.view.backgroundColor=[UIColor whiteColor];
    //消除强引用
    __weak typeof(self) weakSelf = self;
    _headView = [[orderHeader alloc]init];
    //    _headView.items = @[@"全部",@"待付款",@"待发货",@"待收货",@"待评价"];
    if(self.toLoginView.alpha == 1.0){
        _headView.frame = CGRectMake(0, 64+40, kScreenWidth, 40);
    }else{
        _headView.frame = CGRectMake(0, 64, kScreenWidth, 40);
    }
    _headView.items = @[@"详情",@"参数",@"用户评论",@"相关商品"];
    _headView.backgroundColor = k_UIColorFromRGB(0xffffff);
    _headView.itemClickAtIndex = ^(NSInteger index){
        [weakSelf adjustScrollView:index];
    };
    [self.view addSubview:_headView];
    
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_headView.frame),kScreenWidth,kScreenHeight-64-40)];
    _scrollView.backgroundColor = [UIColor lightGrayColor];
    _scrollView.contentSize = CGSizeMake(_scrollView.bounds.size.width*4, _scrollView.bounds.size.height);
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.directionalLockEnabled = YES;
    [self.view addSubview:_scrollView];
    
}

#pragma mark - 导航栏处理
- (void)setUpNavTopView
{
    _topToolView = [[ADOrderTopToolView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    _topToolView.hidden = NO;
    _topToolView.backgroundColor = k_UIColorFromRGB(0xffffff);
    [_topToolView setTopTitleWithNSString:KLocalizableStr(@"商品详情")];
    WEAKSELF
    _topToolView.leftItemClickBlock = ^{
        NSLog(@"点击了返回");
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    //    _topToolView.rightItemClickBlock = ^{
    //        NSLog(@"点击设置");
    //    };
    
    [self.view addSubview:_topToolView];
    
}

#pragma mark - 底部按钮(收藏 购物车 加入购物车 立即购买)
- (void)setUpBottomButton
{
    [self setUpLeftTwoButton];//收藏 购物车
    
    [self setUpRightTwoButton];//加入购物车 立即购买
}
#pragma mark - 购物车
- (void)setUpLeftTwoButton
{
    NSArray *imagesNor = @[@"tabr_08gouwuche"];
//    NSArray *imagesSel = @[@"tabr_08gouwuche"];
    CGFloat buttonW = kScreenWidth * 0.2;
    CGFloat buttonH = 50;
    CGFloat buttonY = kScreenHeight - buttonH;
    
    for (NSInteger i = 0; i < imagesNor.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:imagesNor[i]] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor whiteColor];
//        [button setImage:[UIImage imageNamed:imagesSel[i]] forState:UIControlStateSelected];
        button.tag = i;
        [button addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat buttonX = (buttonW * i);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        button.layer.borderWidth=0.5;
        button.layer.borderColor=[UIColor grayColor].CGColor;
        [self.view addSubview:button];
    }
}
#pragma mark - 加入购物车 立即购买
- (void)setUpRightTwoButton
{
    NSArray *titles = @[@"加入购物车",@"去支付"];
    CGFloat buttonW = kScreenWidth * 0.4;
    CGFloat buttonH = 50;
    CGFloat buttonY = kScreenHeight - buttonH;
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = PFR16Font;
        if(i==0){
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }else{
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        [button addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i + 2;
        [button setTitle:titles[i] forState:UIControlStateNormal];
        button.backgroundColor = (i == 0) ? k_UIColorFromRGB(0xffffff) : [UIColor redColor];
        CGFloat buttonX = kScreenWidth * 0.2 + (buttonW * i);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        button.layer.borderWidth=0.5;
        button.layer.borderColor=[UIColor grayColor].CGColor;
        [self.view addSubview:button];
    }
}

-(void)bottomButtonClick:(UIButton *)button{
    switch (button.tag) {
        case 0:{
            NSLog(@"购物车");
            DCTabBarController *vc = [[DCTabBarController alloc]init];
            [vc goToSelectedViewControllerWith:2];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:{
            NSLog(@"加入购物车");
            if(!self.specShowView){
//                NSLog(@"有在创建吗");
                [self createAttributesViewWith:self.specItem];
            }
            [self showAttributeView];
        }
            break;
        case 3:{
            NSLog(@"去支付");
            //跳转到 下单页面
            ADPlaceOrderViewController *placeOrderVC = [[ADPlaceOrderViewController alloc] init];
            [placeOrderVC loadDataWithNSString:self.goodsID];
            [self.navigationController pushViewController:placeOrderVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}

- (void)showAttributeView {
    __weak typeof(self) _weakSelf = self;
    self.specView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 0.7*kScreenHeight);;
    
    [UIView animateWithDuration:0.3 animations:^{
        _weakSelf.specShowView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        _weakSelf.specShowView.alpha = 1.0;
        _weakSelf.specView.frame = CGRectMake(0, 0.3*kScreenHeight, kScreenWidth, 0.7*kScreenHeight);
    }];
}

- (void)removeView {
    __weak typeof(self) _weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        _weakSelf.specShowView.backgroundColor = [UIColor clearColor];
        _weakSelf.specView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 0.7*kScreenHeight);
    } completion:^(BOOL finished) {
        _weakSelf.specShowView.alpha = 0.0;
    }];
}

- (void)createAttributesViewWith:(NSMutableArray *)array {
    
    float height = 0;
    self.specShowView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.specShowView.alpha = 0.0;
    [self.view addSubview:self.specShowView];
    
    self.specView = [[UIView alloc] initWithFrame:CGRectMake(0, 0.3*kScreenHeight, kScreenWidth, 0.7*kScreenHeight)];
    self.specView.backgroundColor = [UIColor whiteColor];
    [self.specShowView addSubview:self.specView];

    for(int i=0;i<self.specItem.count;i++){
        ADGoodsSpecModel *model = self.specItem[i];
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
    
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.backgroundColor = kMAINCOLOR;
//    [sureBtn setBackgroundImage:[UIImage imageNamed:@"8预约上门时间"] forState:UIControlStateNormal];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureBtn.frame = CGRectMake(0, self.specView.frame.size.height - 40, kScreenWidth, 40);
    [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.specView addSubview:sureBtn];
    
//    specView.height = CGRectGetMaxY(plusBtn.frame)+kBigMargin;
    
}

#pragma mark - 按钮点击事件
- (void)sureBtnClick {

    if(self.specItem && ([self.specDict allValues].count < self.specItem.count)){
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.detailsLabelText = @"您还有未选择的规格";
        hud.mode = MBProgressHUDModeText;
        [hud hide:YES afterDelay:1.0];
    }else{
        NSString *proIds;
        NSArray *specIDArr = [self.specIdDict allValues];
        for(int i=0;i<specIDArr.count;i++){
            if(i==0){
                proIds = specIDArr[0];
            }else{
                proIds = [proIds stringByAppendingFormat:@",%@",specIDArr[i]];
            }
        }
        NSLog(@"加入购物车proIds = %@",proIds);
        
//        WEAKSELF
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        if(proIds){
            [RequestTool addCart:@{@"count":[NSString stringWithFormat:@"%d",self.buyNum],@"goodsId":self.goodsID,@"proIds":proIds} withSuccessBlock:^(NSDictionary *result) {
                NSLog(@"加入购物车result = %@",result);
                if([result[@"code"] integerValue] == 1){
                    hud.detailsLabelText = @"加入购物车成功";
                    hud.mode = MBProgressHUDModeText;
                    [hud hide:YES afterDelay:1.0];
                    
                    [self removeView];
                    [self.specDict removeAllObjects];
                    [self.specIdDict removeAllObjects];
                    [self.specView removeFromSuperview];
                    [self.specShowView removeFromSuperview];
                    self.specView = nil;
                    self.specShowView = nil;
                    self.buyNum = 1;
                    
                }else if([result[@"code"] integerValue] == -2){
                    hud.detailsLabelText = @"登录失效";
                    hud.mode = MBProgressHUDModeText;
                    [hud hide:YES afterDelay:1.0];
                }else if([result[@"code"] integerValue] == -1){
                    hud.detailsLabelText = @"未登录";
                    hud.mode = MBProgressHUDModeText;
                    [hud hide:YES afterDelay:1.0];
                }else if([result[@"code"] integerValue] == 0){
                    hud.detailsLabelText = @"失败";
                    hud.mode = MBProgressHUDModeText;
                    [hud hide:YES afterDelay:1.0];
                }else if([result[@"code"] integerValue] == 2){
                    hud.detailsLabelText = @"无返回数据";
                    hud.mode = MBProgressHUDModeText;
                    [hud hide:YES afterDelay:1.0];
                }
            } withFailBlock:^(NSString *msg) {
                NSLog(@"加入购物车msg = %@",msg);
                hud.detailsLabelText = msg;
                hud.mode = MBProgressHUDModeText;
                [hud hide:YES afterDelay:1.0];
            }];
        }else{
            [RequestTool addCart:@{@"count":[NSString stringWithFormat:@"%d",self.buyNum],@"goodsId":self.goodsID} withSuccessBlock:^(NSDictionary *result) {
                NSLog(@"加入购物车result = %@",result);
                if([result[@"code"] integerValue] == 1){
                    hud.detailsLabelText = @"加入购物车成功";
                    hud.mode = MBProgressHUDModeText;
                    [hud hide:YES afterDelay:1.0];
                    
                    [self removeView];
                    [self.specDict removeAllObjects];
                    [self.specIdDict removeAllObjects];
                    [self.specView removeFromSuperview];
                    [self.specShowView removeFromSuperview];
                    self.specView = nil;
                    self.specShowView = nil;
                    self.buyNum = 1;
                    
                }else if([result[@"code"] integerValue] == -2){
                    hud.detailsLabelText = @"登录失效";
                    hud.mode = MBProgressHUDModeText;
                    [hud hide:YES afterDelay:1.0];
                }else if([result[@"code"] integerValue] == -1){
                    hud.detailsLabelText = @"未登录";
                    hud.mode = MBProgressHUDModeText;
                    [hud hide:YES afterDelay:1.0];
                }else if([result[@"code"] integerValue] == 0){
                    hud.detailsLabelText = @"失败";
                    hud.mode = MBProgressHUDModeText;
                    [hud hide:YES afterDelay:1.0];
                }else if([result[@"code"] integerValue] == 2){
                    hud.detailsLabelText = @"无返回数据";
                    hud.mode = MBProgressHUDModeText;
                    [hud hide:YES afterDelay:1.0];
                }
            } withFailBlock:^(NSString *msg) {
                NSLog(@"加入购物车msg = %@",msg);
                hud.detailsLabelText = msg;
                hud.mode = MBProgressHUDModeText;
                [hud hide:YES afterDelay:1.0];
            }];
        }
        
        
        
    }
}

- (UIImage *) buttonImageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
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

//规格选择
-(void)Attribute_View:(AttributeView *)view didClickBtn:(UIButton *)btn{
    ADProsModel *model = (ADProsModel *)view.textsArr[btn.tag];
    [self.specDict setValue:model.pro_value forKey:view.titleString];
    [self.specIdDict setValue:model.pro_id forKey:view.titleString];
    NSLog(@"商品详情self.specDict = %@",self.specDict);
}

-(NSMutableDictionary *)specDict{
    if (!_specDict) {
        _specDict = [NSMutableDictionary dictionary];
    }
    return _specDict;
}

-(NSMutableDictionary *)specIdDict{
    if (!_specIdDict) {
        _specIdDict = [NSMutableDictionary dictionary];
    }
    return _specIdDict;
}

#pragma mark-将4个controller添加到applecontroller上
-(void)addViewControllsToScrollView
{
    ADDetailViewController * detailvc = [[ADDetailViewController alloc]init];
    //    allvc.view.backgroundColor = [UIColor redColor];
    detailvc.view.frame = CGRectMake(0, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height);
    [_scrollView addSubview:detailvc.view];
    [self addChildViewController:detailvc];
    
    ADGoodsParameterViewController * paravc = [[ADGoodsParameterViewController alloc]init];
    paravc.view.frame = CGRectMake(_scrollView.bounds.size.width, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height);
    [paravc transmitWithGoodsProperty:self.model.goods_property];
    //    payvc.view.backgroundColor = [UIColor greenColor];
    [_scrollView addSubview:paravc.view];
    [self addChildViewController:paravc];
    
    self.evaluationvc = [[ADUserEvaluationViewController alloc]init];
    self.evaluationvc.view.frame = CGRectMake(_scrollView.bounds.size.width*2, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height);
    //    receivevc.view.backgroundColor = [UIColor purpleColor];
    [_scrollView addSubview:self.evaluationvc.view];
    [self addChildViewController:self.evaluationvc];
    
    ADRelatedGoodsViewController * relatedvc = [[ADRelatedGoodsViewController alloc]init];
    relatedvc.view.frame = CGRectMake(_scrollView.bounds.size.width*3, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height);
    //    closedvc.view.backgroundColor = [UIColor purpleColor];
    [_scrollView addSubview:relatedvc.view];
    [self addChildViewController:relatedvc];
    
}
#pragma mark-通过点击button来改变scrollview的偏移量
-(void)adjustScrollView:(NSInteger)index
{
    [UIView animateWithDuration:0.2 animations:^{
        _scrollView.contentOffset = CGPointMake(index*_scrollView.bounds.size.width, 0);
        
        NSLog(@"index = %lu",index);
        NSLog(@"collectionViewHeight = %.2f",self.evaluationvc.collectionViewHeight);
        if(index == 2){
            NSLog(@"改变size");
            [_scrollView layoutIfNeeded];
            [self.evaluationvc.view layoutIfNeeded];
            _scrollView.contentSize = CGSizeMake(_scrollView.bounds.size.width*4, self.evaluationvc.collectionViewHeight+CGRectGetMaxY(_headView.frame)-50);
        }else{
            _scrollView.contentSize = CGSizeMake(_scrollView.bounds.size.width*4, _scrollView.bounds.size.height);
            NSLog(@"还原size");
        }
        NSLog(@"contentSize%@",NSStringFromCGSize(_scrollView.contentSize));

    }];
}


#pragma mark-选中scorllview来调整headvie的选中
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x/scrollView.bounds.size.width;
    [_headView setSelectAtIndex:index];
    
}


#pragma mark 测试用
-(void)changeScrollview:(NSInteger)index{
    
    [UIView animateWithDuration:0 animations:^{
        _scrollView.contentOffset = CGPointMake(index*_scrollView.bounds.size.width, 0);
    }];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.buyNum = [self.buyNumsLbl.text intValue];
}

@end
