//
//  ADFlashSaleViewController.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/6.
//  Copyright © 2018年 Adel. All rights reserved.
//  首页-限时抢购

#import "ADFlashSaleViewController.h"
#import "ADOrderTopToolView.h"
//#import "orderHeader.h"
#import "ADSallingViewController.h"//正在抢购
#import "ADSecondaryHeaderView.h"

@interface ADFlashSaleViewController ()<UIScrollViewDelegate>{
    UIScrollView *_scrollView;
    ADSecondaryHeaderView *_headView;
    BOOL _isup;
}
/* 顶部Nva */
@property (strong , nonatomic)ADOrderTopToolView *topToolView;
@end

@implementation ADFlashSaleViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.view.backgroundColor = kBACKGROUNDCOLOR;
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
//    NSLog(@"这里时间字典 = %@",self.timeDict);
}


-(void)createUI{
    //消除强引用
    __weak typeof(self) weakSelf = self;
    _headView = [[ADSecondaryHeaderView alloc]init];
    //    _headView.items = @[@"全部",@"待付款",@"待发货",@"待收货",@"待评价"];
    _headView.frame = CGRectMake(0, 65, kScreenWidth, 46);
//    _headView.items = @[@"正在抢购",@"即将开始"];
//    NSLog(@"时间字典 = %@",self.timeDict);
    
    NSString *beginTime = self.timeDict[@"startTime"];
    NSArray *tempArr = [beginTime componentsSeparatedByString:@" "];
    NSArray *hourAndMinuteArr = [tempArr[1] componentsSeparatedByString:@":"];
    NSString *hourAndMinute = [NSString stringWithFormat:@"%@:%@",hourAndMinuteArr[0],hourAndMinuteArr[1]];
    
    _headView.items = @[@{@"time":hourAndMinute,@"title":@"正在抢购",@"detail":[NSString stringWithFormat:@"距结束%@:%@:%@",self.timeDict[@"hour"],self.timeDict[@"minute"],self.timeDict[@"second"]]},@{@"time":hourAndMinute,@"title":@"即将开始",@"detail":[NSString stringWithFormat:@"距结束%@:%@:%@",self.timeDict[@"hour"],self.timeDict[@"minute"],self.timeDict[@"second"]]}];
    _headView.backgroundColor = k_UIColorFromRGB(0xffffff);
    _headView.itemClickAtIndex = ^(NSInteger index){
        [weakSelf adjustScrollView:index];
    };
    [self.view addSubview:_headView];
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_headView.frame),kScreenWidth,kScreenHeight-64-40)];
    _scrollView.backgroundColor = kBACKGROUNDCOLOR;
    _scrollView.contentSize = CGSizeMake(_scrollView.bounds.size.width*2, _scrollView.bounds.size.height);
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
    [_topToolView setTopTitleWithNSString:KLocalizableStr(@"限时抢购")];
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
    ADSallingViewController * sallingvc = [[ADSallingViewController alloc]init];
    sallingvc.view.frame = CGRectMake(0, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height);
    [_scrollView addSubview:sallingvc.view];
    [self addChildViewController:sallingvc];

//    ADGoodsParameterViewController * paravc = [[ADGoodsParameterViewController alloc]init];
//    paravc.view.frame = CGRectMake(_scrollView.bounds.size.width, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height);
//    //    payvc.view.backgroundColor = [UIColor greenColor];
//    [_scrollView addSubview:paravc.view];
//    [self addChildViewController:paravc];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
