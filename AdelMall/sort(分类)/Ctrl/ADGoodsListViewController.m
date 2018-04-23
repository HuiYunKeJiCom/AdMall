//
//  ADGoodsListViewController.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/13.
//  Copyright © 2018年 Adel. All rights reserved.
//  分类列表

#import "ADGoodsListViewController.h"
#import "ADOrderTopToolView.h"
#import "orderHeader.h"
#import "ADPriceGoodsViewController.h"//价格
#import "ADMoreEvaluatedGoodsViewController.h"//评论最多
#import "DCClassGoodsItem.h"

@interface ADGoodsListViewController ()<UIScrollViewDelegate>{
    UIScrollView *_scrollView;
    orderHeader *_headView;
    BOOL _isup;
}
/* 顶部Nva */
@property (strong , nonatomic)ADOrderTopToolView *topToolView;

@end

@implementation ADGoodsListViewController

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
    [self createUI];
}

-(void)createUI{
    //    self.view.backgroundColor=[UIColor whiteColor];
    //消除强引用
    __weak typeof(self) weakSelf = self;
    _headView = [[orderHeader alloc]init];
    //    _headView.items = @[@"全部",@"待付款",@"待发货",@"待收货",@"待评价"];
    _headView.frame = CGRectMake(0, 64, kScreenWidth, 40);
    _headView.items = @[@"价格↑",@"评论最多"];
    _headView.backgroundColor = k_UIColorFromRGB(0xffffff);
    _headView.itemClickAtIndex = ^(NSInteger index){
        [weakSelf adjustScrollView:index];
    };
    [self.view addSubview:_headView];
    
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_headView.frame),kScreenWidth,kScreenHeight-64-40-51)];
    _scrollView.backgroundColor = [UIColor lightGrayColor];
    _scrollView.contentSize = CGSizeMake(_scrollView.bounds.size.width*3, _scrollView.bounds.size.height);
    //    _scrollView.contentSize = CGSizeMake(_scrollView.bounds.size.width*4, kScreenHeight*2);
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.directionalLockEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    
    [self addViewControllsToScrollView];
    
}

#pragma mark - 导航栏处理
- (void)setUpNavTopView
{
    _topToolView = [[ADOrderTopToolView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    _topToolView.hidden = NO;
    _topToolView.backgroundColor = k_UIColorFromRGB(0xffffff);
    [_topToolView setTopTitleWithNSString:KLocalizableStr(self.titleString)];
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

#pragma mark-将4个controller添加到applecontroller上
-(void)addViewControllsToScrollView
{
    //价格
    ADPriceGoodsViewController * priceGoodsvc = [[ADPriceGoodsViewController alloc]init];
    //    allvc.view.backgroundColor = [UIColor redColor];
    priceGoodsvc.view.frame = CGRectMake(0, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height);
    priceGoodsvc.subItem = self.subItem;
    [priceGoodsvc loadDataWith:self.subItem andKeyword:self.keyWord];
    [_scrollView addSubview:priceGoodsvc.view];
    [self addChildViewController:priceGoodsvc];

    //评论最多
    ADMoreEvaluatedGoodsViewController * moreEvaluatedGoodsvc = [[ADMoreEvaluatedGoodsViewController alloc]init];
    moreEvaluatedGoodsvc.view.frame = CGRectMake(_scrollView.bounds.size.width, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height);
    //    payvc.view.backgroundColor = [UIColor greenColor];
    moreEvaluatedGoodsvc.subItem = self.subItem;
    [moreEvaluatedGoodsvc loadDataWith:self.subItem andKeyword:self.keyWord];
    [_scrollView addSubview:moreEvaluatedGoodsvc.view];
    [self addChildViewController:moreEvaluatedGoodsvc];
}
#pragma mark-通过点击button来改变scrollview的偏移量
-(void)adjustScrollView:(NSInteger)index
{
    [UIView animateWithDuration:0.2 animations:^{
        _scrollView.contentOffset = CGPointMake(index*_scrollView.bounds.size.width, 0);
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
