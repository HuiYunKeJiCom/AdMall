//
//  ADGoodsDetailViewController.m
//  AdelMall
//
//  Created by apple on 2018/4/11.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import "ADGoodsDetailViewController.h"
#import "PageSelectBar.h"
#import "ADDetailViewModel.h"
#import "ADParameterView.h"
#import "ADGoodsParameterViewModel.h"
#import "ADUserEvaluationViewModel.h"
#import "ADRelatedGoodsViewModel.h"
#import "ADGoodsDetailModel.h"
#import "DCClassGoodsItem.h"
#import "ADGoodsModel.h"

#import "ADTopLoginView.h"
#import "ADOrderTopToolView.h"
#import "ADPlaceOrderViewController.h"
#import "DCTabBarController.h"
#import "ADGoodsSpecModel.h"
#import "AttributeView.h"//规格
#import "UIView+Extension.h"
#import "ADProsModel.h"
#import "ADAdvertModel.h"

@interface ADGoodsDetailViewController ()<AttributeViewDelegate,UITextFieldDelegate>
@property (nonatomic,strong)PageSelectBar *pageSelectBar;//标签页选择bar
@property (nonatomic,strong)UIScrollView *mainScrollView;//主scrollView
@property (nonatomic,strong)NSMutableArray *shellViews;//shellViews数组

@property (nonatomic,strong)ADDetailViewModel *detailViewModel;//
//@property (nonatomic,strong)ADParameterView *detailParameterView;//
@property (nonatomic,strong)ADGoodsParameterViewModel *parameterViewModel;//
@property (nonatomic,strong)ADUserEvaluationViewModel *userEvaluationiViewModel;//
@property (nonatomic,strong)ADRelatedGoodsViewModel *relatedGoodsViewModel;//
/* 去登录页面 */
@property (strong , nonatomic)ADTopLoginView *toLoginView;
/* 顶部Nva */
@property (strong , nonatomic)ADOrderTopToolView *topToolView;

/** 规格选择View  */
@property (strong , nonatomic)UIView *specShowView;
/* 商品规格数组 */
@property (strong , nonatomic)NSMutableArray<ADGoodsSpecModel *> *specItem;
/** 规格选择View  */
@property (strong , nonatomic)UIView *specView;
/** 购买数量Lbl */
@property (nonatomic, weak) UITextField *buyNumsLbl;
/** 规格字典 */
@property(nonatomic,strong)NSMutableDictionary *specDict;
/** 规格id字典 */
@property(nonatomic,strong)NSMutableDictionary *specIdDict;
/** 商品模型 */
@property(nonatomic,strong)ADGoodsDetailModel *dataModel;
/* 相关商品数据数组 */
@property (strong , nonatomic)NSMutableArray<ADGoodsModel *> *relatedGoodsItem;

@end

@implementation ADGoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _shellViews = [NSMutableArray array];
    self.relatedGoodsItem = [NSMutableArray array];
    _detailViewModel = [[ADDetailViewModel alloc]init];
    _userEvaluationiViewModel = [[ADUserEvaluationViewModel alloc]init];
    _relatedGoodsViewModel = [[ADRelatedGoodsViewModel alloc]init];
    
    self.view.backgroundColor = kBACKGROUNDCOLOR;
    self.buyNum = 1;
    [self buildUI];
    [self setUpNavTopView];
    [self setUpBottomButton];
    [self.view addSubview:self.toLoginView];
//    self.goodsID = @"98461";//测试用商品ID
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self requestGoodsDetailInfo];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
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

-(void)hideToLoginView{
    [UIView animateWithDuration:0.5 animations:^{
        self.toLoginView.alpha = 0.0;
//        _headView.frame = CGRectMake(0, 64, kScreenWidth, 40);
        _pageSelectBar.frame = CGRectMake(0, 64, kScreenWidth, 40);
        _mainScrollView.top = _pageSelectBar.bottom;
    }];
    
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
                    
                    NSArray *specValueArr = [self.specDict allValues];
                    [self.detailViewModel.specValueArr removeAllObjects];
                    self.detailViewModel.specValueArr = [NSMutableArray arrayWithArray:specValueArr];
                    [self.detailViewModel.detailView reloadData];
                    
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

- (void)showAttributeView {
    __weak typeof(self) _weakSelf = self;
    self.specView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 0.7*kScreenHeight);;
    
    [UIView animateWithDuration:0.3 animations:^{
        _weakSelf.specShowView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        _weakSelf.specShowView.alpha = 1.0;
        _weakSelf.specView.frame = CGRectMake(0, 0.3*kScreenHeight, kScreenWidth, 0.7*kScreenHeight);
    }];
}



- (void)buildUI{
    //副标题
    _pageSelectBar = [[PageSelectBar alloc]initWithFrame:CGRectMake(0, 40, kScreenWidth, 40) options:@[@"详情",@"参数",@"用户评论",@"相关商品"] selectBlock:^(NSString *option, NSInteger index) {
        _mainScrollView.contentOffset = CGPointMake((_mainScrollView.contentSize.width/4) * index, 0);
    }];
//    _pageSelectBar.backgroundColor = [UIColor redColor];
    _pageSelectBar.top = TopBarHeight+40;
    _pageSelectBar.left = 0;
    [self.view addSubview:_pageSelectBar];
    
    _mainScrollView = [UIScrollView new];
    _mainScrollView.size = CGSizeMake(kScreenWidth, AppHeight - _pageSelectBar.bottom);
    _mainScrollView.left = 0;
    _mainScrollView.top = _pageSelectBar.bottom;
    _mainScrollView.contentSize = CGSizeMake(_mainScrollView.width * 4, _mainScrollView.height);
    _mainScrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _mainScrollView.showsVerticalScrollIndicator = NO;
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    _mainScrollView.alwaysBounceHorizontal = YES;
    _mainScrollView.pagingEnabled = YES;
    _mainScrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_mainScrollView];
    
    for (int i = 0; i < 4; i++) {
        UIView *shellView = [[UIView alloc]init];
        shellView.size = _mainScrollView.size;
        shellView.top = 0;
        shellView.left = _mainScrollView.width * i;
        shellView.backgroundColor = [UIColor whiteColor];
        [_mainScrollView addSubview:shellView];
        [_shellViews addObject:shellView];
    }
    
    _detailViewModel.detailView.frame = ((UIView *)_shellViews[0]).bounds;
    [(UIView *)_shellViews[0] addSubview:_detailViewModel.detailView];
    
//    _detailParameterView = [[ADParameterView alloc]initWithFrame:((UIView *)_shellViews[1]).bounds];
//    [(UIView *)_shellViews[1] addSubview:_detailParameterView];
    _parameterViewModel = [[ADGoodsParameterViewModel alloc]init];
    _parameterViewModel.parameterView.frame = ((UIView *)_shellViews[1]).bounds;
    [(UIView *)_shellViews[1] addSubview:_parameterViewModel.parameterView];
    
    
    _userEvaluationiViewModel.userEvaluationListView.frame = ((UIView *)_shellViews[2]).bounds;
    [(UIView *)_shellViews[2] addSubview:_userEvaluationiViewModel.userEvaluationListView];
    
    _relatedGoodsViewModel.goodsListView.frame = ((UIView *)_shellViews[3]).bounds;
    [(UIView *)_shellViews[3] addSubview:_relatedGoodsViewModel.goodsListView];
    
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

- (void)requestGoodsDetailInfo{
//    NSLog(@"self.goodsID = %@",self.goodsID);
//    self.goodsID = @"98461";
    WEAKSELF
    [RequestTool getGoods:@{@"id":self.goodsID} withSuccessBlock:^(NSDictionary *result) {
        NSLog(@"self.goodsID : %@",self.goodsID);
        NSLog(@"商品详情result : %@",result);

        [weakSelf getDataWithNSDictionary:result];
        [self.detailViewModel.imageGroupArray removeAllObjects];
        NSDictionary *dataDic = result[@"data"];
        self.dataModel = [ADGoodsDetailModel mj_objectWithKeyValues:dataDic[@"goods"]];
        self.detailViewModel.dataModel = self.dataModel;
        self.detailViewModel.imageGroupArray = dataDic[@"picPaths"];
        [self.detailViewModel.detailView reloadData];
        [_parameterViewModel layoutWithProperty:self.dataModel.goods_property];
        
//        NSString *gc_id = @"17";
        
//        [RequestTool getGoodsCategory:@{@"parentId":gc_id} withSuccessBlock:^(NSDictionary *result) {
//            DCClassGoodsItem *categoryInfo = result[@"data"][@"result"];
//            [_relatedGoodsViewModel loadGoodsData:categoryInfo.children];
//
//        } withFailBlock:^(NSString *msg) {
//
//        }];
//        NSLog(@"self.dataModel.gc_id =%@",self.dataModel.gc_id);
        [RequestTool getGoodsList:@{@"parentId":self.dataModel.gc_id} withSuccessBlock:^(NSDictionary *result) {
            NSLog(@"相关商品数据result = %@",result);
            [weakSelf handleTransferResult:result];
        } withFailBlock:^(NSString *msg) {
            NSLog(@"相关商品数据msg = %@",msg);
        }];
        
        
    } withFailBlock:^(NSString *msg) {
        
    }];
    
}

- (void)handleTransferResult:(NSDictionary *)result{
    
    NSArray *dataInfo = [NSArray array];
    if ([result isKindOfClass:[NSDictionary class]]) {
        //        NSLog(@"来这里了吗");
         dataInfo = result[@"data"][@"goodsList"];
        [self.relatedGoodsItem removeAllObjects];
        for (NSDictionary *dic in dataInfo) {
            ADGoodsModel *model = [ADGoodsModel mj_objectWithKeyValues:dic];
            [self.relatedGoodsItem addObject:model];
        }
    }
    [self.relatedGoodsViewModel loadGoodsData:self.relatedGoodsItem];
}

-(void)getDataWithNSDictionary:(NSDictionary *)dict
{
    //规格页面
    NSArray *specArr = dict[@"data"][@"specs"];
    NSLog(@"specArr = %@",specArr);
    if(specArr){
        _specItem = [ADGoodsSpecModel mj_objectArrayWithKeyValuesArray:specArr];
        for(int i=0;i<_specItem.count;i++){
            ADGoodsSpecModel *model = _specItem[i];
            model.pros = [ADProsModel mj_objectArrayWithKeyValuesArray:model.pros];
            [self createAttributesViewWith:self.specItem];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.buyNum = [self.buyNumsLbl.text intValue];
}


@end
