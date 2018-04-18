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

@interface ADGoodsDetailViewController ()

@property (nonatomic,strong)PageSelectBar *pageSelectBar;//标签页选择bar
@property (nonatomic,strong)UIScrollView *mainScrollView;//主scrollView
@property (nonatomic,strong)NSMutableArray *shellViews;//shellViews数组

@property (nonatomic,strong)ADDetailViewModel *detailViewModel;//
//@property (nonatomic,strong)ADParameterView *detailParameterView;//
@property (nonatomic,strong)ADGoodsParameterViewModel *parameterViewModel;//
@property (nonatomic,strong)ADUserEvaluationViewModel *userEvaluationiViewModel;//
@property (nonatomic,strong)ADRelatedGoodsViewModel *relatedGoodsViewModel;//

@end

@implementation ADGoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _shellViews = [NSMutableArray array];
    
    _detailViewModel = [[ADDetailViewModel alloc]init];
    _userEvaluationiViewModel = [[ADUserEvaluationViewModel alloc]init];
    _relatedGoodsViewModel = [[ADRelatedGoodsViewModel alloc]init];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self buildUI];
    
    self.goodsID = @"98461";//测试用商品ID
    
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

- (void)buildUI{
    
    _pageSelectBar = [[PageSelectBar alloc]initWithFrame:CGRectMake(0, 0, AppWidth, 72) options:@[@"商品详情",@"商品参数",@"用户评论",@"推荐商品"] selectBlock:^(NSString *option, NSInteger index) {
        _mainScrollView.contentOffset = CGPointMake((_mainScrollView.contentSize.width/4) * index, 0);
    }];
    _pageSelectBar.top = TopBarHeight;
    _pageSelectBar.left = 0;
    [self.view addSubview:_pageSelectBar];
    
    _mainScrollView = [UIScrollView new];
    _mainScrollView.size = CGSizeMake(AppWidth, AppHeight - _pageSelectBar.bottom);
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
    
    _relatedGoodsViewModel.goodsTable.frame = ((UIView *)_shellViews[3]).bounds;
    [(UIView *)_shellViews[3] addSubview:_relatedGoodsViewModel.goodsTable];
    
}

- (void)requestGoodsDetailInfo{
    self.goodsID = @"98461";
    [RequestTool getGoods:@{@"id":self.goodsID} withSuccessBlock:^(NSDictionary *result) {
        NSLog(@"self.goodsID : %@",self.goodsID);
        NSLog(@"result : %@",result);
        
        NSDictionary *dataDic = result[@"data"];
        ADGoodsDetailModel *dataModel = [ADGoodsDetailModel mj_objectWithKeyValues:dataDic[@"goods"]];
//        ADGoodsDetailModel_YY *goodsInfo = [ADGoodsDetailModel_YY yy_modelWithJSON:dataDic[@"goods"]];
//
        [_parameterViewModel layoutWithProperty:dataModel.goods_property];
        
        
        
        NSLog(@"123321");
        
    } withFailBlock:^(NSString *msg) {
        
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
