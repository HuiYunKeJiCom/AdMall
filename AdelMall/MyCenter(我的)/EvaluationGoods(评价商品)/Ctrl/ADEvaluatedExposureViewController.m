//
//  ADEvaluatedExposureViewController.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/12.
//  Copyright © 2018年 Adel. All rights reserved.
//  评价晒单

#import "ADEvaluatedExposureViewController.h"
#import "DCHomeRefreshGifHeader.h"
#import "ADOrderTopToolView.h"//自定义导航栏
#import "ADPaymentOrderBottonView.h"
#import "ADScoreViewCell.h"//评分View

@interface ADEvaluatedExposureViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate>
/* collectionView */
@property (strong , nonatomic)UICollectionView *collectionView;
/* 顶部Nva */
@property (strong , nonatomic)ADOrderTopToolView *topToolView;
/* 底部View */
@property (strong , nonatomic)ADPaymentOrderBottonView *bottomView;

@end

static NSString *const ADScoreViewCellID = @"ADScoreViewCell";

@implementation ADEvaluatedExposureViewController

#pragma mark - LazyLoad
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.frame = CGRectMake(0, 65, kScreenWidth, kScreenHeight - DCBottomTabH-65);
        _collectionView.showsVerticalScrollIndicator = NO;        //注册
        [_collectionView registerClass:[ADScoreViewCell class] forCellWithReuseIdentifier:ADScoreViewCellID];
        
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
    [self setUpBase];
    [self setUpNavTopView];
    [self setupCustomBottomView];
    [self setUpGIFRrfresh];
}

-(void)loadDataWithGoodsID:(NSString *)goodsID{
    WEAKSELF
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [RequestTool getEvaluateLabel:@{@"goodsId":goodsID} withSuccessBlock:^(NSDictionary *result) {
        NSLog(@"获取评价标签result = %@",result);
        NSArray *dataInfo = result[@"data"][@"result"];
        if([result[@"code"] integerValue] == 1){
                [hud hide:YES];
                [weakSelf handleTransferNSArray:dataInfo];
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
        }
        
    } withFailBlock:^(NSString *msg) {
        NSLog(@"获取评价标签msg = %@",msg);
        hud.detailsLabelText = msg;
        hud.mode = MBProgressHUDModeText;
        [hud hide:YES afterDelay:1.0];
    }];
}

- (void)handleTransferNSArray:(NSArray *)dataInfo{
    
}

#pragma mark - initialize
- (void)setUpBase
{
    self.collectionView.backgroundColor = kBACKGROUNDCOLOR;
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

#pragma mark - 导航栏处理
- (void)setUpNavTopView
{
    _topToolView = [[ADOrderTopToolView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    _topToolView.hidden = NO;
    _topToolView.backgroundColor = k_UIColorFromRGB(0xffffff);
    [_topToolView setTopTitleWithNSString:KLocalizableStr(@"评论晒单")];
    WEAKSELF
    _topToolView.leftItemClickBlock = ^{
        NSLog(@"点击了返回");
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    [self.view addSubview:_topToolView];
    
}

#pragma mark -- 自定义底部视图
- (void)setupCustomBottomView {
    //    WEAKSELF
    _bottomView = [[ADPaymentOrderBottonView alloc] initWithFrame:CGRectMake(0, kScreenHeight -  50, kScreenWidth, 50)];
    [_bottomView setTopTitleWithNSString:@"提交评价"];
    _bottomView.payBtnClickBlock = ^{
        NSLog(@"提交评价");
        //        //跳转到支付页面
        //        ADPaymentOrderViewController *placeOrderVC = [[ADPaymentOrderViewController alloc] init];
        //        [weakSelf.navigationController pushViewController:placeOrderVC animated:YES];
    };
    
    [self.view addSubview:_bottomView];
}



#pragma mark - 设置头部header
- (void)setUpGIFRrfresh
{
    self.collectionView.mj_header = [DCHomeRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(setUpRecData)];
}

#pragma mark - 刷新
- (void)setUpRecData
{
    WEAKSELF
    if (@available(iOS 10.0, *)) {
        UIImpactFeedbackGenerator *generator = [[UIImpactFeedbackGenerator alloc] initWithStyle: UIImpactFeedbackStyleHeavy];
        [generator prepare];
        [generator impactOccurred];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ //手动延迟
        [weakSelf.collectionView.mj_header endRefreshing];
    });
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *gridcell = nil;
    if (indexPath.section == 0) {
        ADScoreViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ADScoreViewCellID forIndexPath:indexPath];
        //            cell.gridItem = _gridItem[indexPath.row];
        
        cell.backgroundColor = [UIColor whiteColor];
        gridcell = cell;
        
    }
    return gridcell;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableview = nil;
    return reusableview;
}

//这里我为了直观的看出每组的CGSize设置用if 后续我会用简洁的三元表示
#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {//评论晒单
        return CGSizeMake(kScreenWidth, kScreenWidth+355);
    }

    
    return CGSizeZero;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    return layoutAttributes;
}

#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    return CGSizeZero;
}

#pragma mark - foot宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    
    return CGSizeZero;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
#pragma mark - X间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return (section == 5) ? 4 : 0;
}
#pragma mark - Y间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return (section == 5) ? 4 : 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 15, 0);//分别为上、左、下、右
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    NSLog(@"scrollView.contentOffset.y = %f",scrollView.contentOffset.y);
    //    NSLog(@"kScreenHeight = %f",kScreenHeight);
//    _backTopButton.hidden = (scrollView.contentOffset.y > 0) ? NO : YES;//判断回到顶部按钮是否隐藏
    //        _topToolView.hidden = (scrollView.contentOffset.y < 0) ? YES : NO;//判断顶部工具View的显示和隐形
    
    if (scrollView.contentOffset.y > DCNaviH) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        //            [[NSNotificationCenter defaultCenter]postNotificationName:SHOWTOPTOOLVIEW object:nil];
    }else{
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        //            [[NSNotificationCenter defaultCenter]postNotificationName:HIDETOPTOOLVIEW object:nil];
    }
}

#pragma mark - collectionView滚回顶部
- (void)ScrollToTop
{
    [self.collectionView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}

//#pragma mark - 消息
//- (void)messageItemClick
//{
//
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
