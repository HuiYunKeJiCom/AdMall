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


@interface ADGoodsDetailViewController ()<UIScrollViewDelegate>{
    UIScrollView *_scrollView;
    orderHeader *_headView;
    BOOL _isup;
}
/* 去登录页面 */
@property (strong , nonatomic)ADTopLoginView *toLoginView;
/* 顶部Nva */
@property (strong , nonatomic)ADOrderTopToolView *topToolView;
/** 商品详情-用户评论 */
@property(nonatomic,strong)ADUserEvaluationViewController *evaluationvc;
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
    
    [self addViewControllsToScrollView];
    
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
        }
            break;
        case 3:{
            NSLog(@"去支付");
            //跳转到 下单页面
            ADPlaceOrderViewController *placeOrderVC = [[ADPlaceOrderViewController alloc] init];
            [self.navigationController pushViewController:placeOrderVC animated:YES];
        }
            break;
            
        default:
            break;
    }
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


@end
