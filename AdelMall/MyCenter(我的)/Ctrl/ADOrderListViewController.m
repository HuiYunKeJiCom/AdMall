//
//  DWQOrderListViewController.m
//  DWQListOfDifferentOrderStatus
//
//  Created by 杜文全 on 15/11/1.
//  Copyright © 2015年 com.iOSDeveloper.duwenquan. All rights reserved.
//  我的订单

#import "ADOrderListViewController.h"
#import "ADOrderTopToolView.h"
#import "orderHeader.h"
#import "ADAllOrderViewController.h"
#import "ADWaitingPayViewController.h"
#import "ADWaitingReceiveViewController.h"
#import "ADOrderClosedViewController.h"

@interface ADOrderListViewController ()<UIScrollViewDelegate>{
    UIScrollView *_scrollView;
    orderHeader *_headView;
    BOOL _isup;
}
/* 顶部Nva */
@property (strong , nonatomic)ADOrderTopToolView *topToolView;

@end

@implementation ADOrderListViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    if (self.index) {
        
        [self changeScrollview:self.index];
        
        //UIScrollViewDecelerationRateFast;
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    [self setUpNavTopView];
}

-(void)createUI{
    self.view.backgroundColor=kBACKGROUNDCOLOR;
    //消除强引用
    __weak typeof(self) weakSelf = self;
    _headView = [[orderHeader alloc]initWithFrame:CGRectMake(0, 65, self.view.bounds.size.width, 40)];
    _headView.items = @[@"全部有效订单",@"待支付",@"待收货",@"已完成"];
    _headView.itemClickAtIndex = ^(NSInteger index){
        [weakSelf adjustScrollView:index];
    };
    [self.view addSubview:_headView];
    
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_headView.frame),kScreenWidth,kScreenHeight-64-40)];
    _scrollView.backgroundColor = kBACKGROUNDCOLOR;
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
    _topToolView.backgroundColor = [UIColor whiteColor];
    [_topToolView setTopTitleWithNSString:KLocalizableStr(@"我的订单")];
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
    ADAllOrderViewController * allvc = [[ADAllOrderViewController alloc]init];
    allvc.view.frame = CGRectMake(0, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height);
    [_scrollView addSubview:allvc.view];
    [self addChildViewController:allvc];

    ADWaitingPayViewController * payvc = [[ADWaitingPayViewController alloc]init];
    payvc.view.frame = CGRectMake(_scrollView.bounds.size.width, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height);
    [_scrollView addSubview:payvc.view];
    [self addChildViewController:payvc];

    ADWaitingReceiveViewController * receivevc = [[ADWaitingReceiveViewController alloc]init];
    receivevc.view.frame = CGRectMake(_scrollView.bounds.size.width*2, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height);
    [_scrollView addSubview:receivevc.view];
    [self addChildViewController:receivevc];
    
    ADOrderClosedViewController * closedvc = [[ADOrderClosedViewController alloc]init];
    closedvc.view.frame = CGRectMake(_scrollView.bounds.size.width*3, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height);
    [_scrollView addSubview:closedvc.view];
    [self addChildViewController:closedvc];
    
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
