//
//  ADHomePageViewController.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/1/30.
//  Copyright © 2018年 Adel. All rights reserved.
//  首页

#import "ADHomePageViewController.h"
#import "DCHomeRefreshGifHeader.h"
#import "ADGoodsDetailViewController.h"//商品详情
#import "ADGoodsListViewController.h"//分类列表
/* cell */
#import "DCGoodsCountDownCell.h" //倒计时商品
#import "ADStarGoodsCell.h" //明星产品商品
/* head */
#import "DCSlideshowHeadView.h"  //轮播图
#import "DCCountDownHeadView.h"  //限时秒杀
#import "ADStarProductHeadView.h" //明星产品
#import "DCExceedApplianceCell.h" //智能硬件
#import "ADRecommendCell.h" //为您推荐
#import "ADButtonViewCell.h"  //按钮
#import "DCHomeTopToolView.h"  //头部
#import "ADHomeSearchView.h"  //搜索框
#import "ADFlashSaleViewController.h"//限时抢购
#import "ADSallGoodsDetailViewController.h"//抢购商品详情

#import "ADCountDownActivityModel.h"
#import "ADFloorModel.h"

//#import "ADGoodsTempModel.h"

@interface ADHomePageViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
/* collectionView */
@property (strong , nonatomic)UICollectionView *collectionView;
/* 顶部工具View */
@property (nonatomic, strong) DCHomeTopToolView *topToolView;
/* 顶部searchView */
@property (nonatomic, strong) ADHomeSearchView *topSearchView;

/** 抢购倒计时时间 */
@property(nonatomic,strong)NSDictionary *dict;
/** 抢购商品id */
@property(nonatomic,copy)NSString *goodsID;
/* 首页楼层数据数组 */
@property (strong , nonatomic)NSMutableArray<ADFloorModel *> *floorDataItem;
///* floorId数组 */
//@property (copy , nonatomic)NSMutableArray *floorIdArray;
@end

/* cell */
static NSString *const DCGoodsCountDownCellID = @"DCGoodsCountDownCell";
static NSString *const ADStarGoodsCellID = @"ADStarGoodsCell";
static NSString *const DCExceedApplianceCellID = @"DCExceedApplianceCell";
static NSString *const ADButtonViewCellID = @"ADButtonViewCell";
static NSString *const ADRecommendCellID = @"ADRecommendCell";
/* head */
static NSString *const DCSlideshowHeadViewID = @"DCSlideshowHeadView";
static NSString *const DCCountDownHeadViewID = @"DCCountDownHeadView";
static NSString *const ADStarProductHeadViewID = @"ADStarProductHeadView";


@implementation ADHomePageViewController

#pragma mark - LazyLoad
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight - DCBottomTabH-64);
        _collectionView.showsVerticalScrollIndicator = NO;        //注册
        _collectionView.backgroundColor = kBACKGROUNDCOLOR;
        
        [_collectionView registerClass:[DCGoodsCountDownCell class] forCellWithReuseIdentifier:DCGoodsCountDownCellID];
        [_collectionView registerClass:[ADStarGoodsCell class] forCellWithReuseIdentifier:ADStarGoodsCellID];
        [_collectionView registerClass:[DCExceedApplianceCell class] forCellWithReuseIdentifier:DCExceedApplianceCellID];
        [_collectionView registerClass:[ADButtonViewCell class] forCellWithReuseIdentifier:ADButtonViewCellID];
        [_collectionView registerClass:[ADRecommendCell class] forCellWithReuseIdentifier:ADRecommendCellID];
        
        [_collectionView registerClass:[DCSlideshowHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCSlideshowHeadViewID];
        [_collectionView registerClass:[DCCountDownHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCCountDownHeadViewID];
         [_collectionView registerClass:[ADStarProductHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ADStarProductHeadViewID];
        
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

- (NSDictionary *)dict
{
    if (!_dict) {
        _dict = [NSDictionary dictionary];
    }
    return _dict;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.floorIdArray = [NSMutableArray array];
    [self setUpBase];
    
    [self setUpTopToolView];
    [self setUpTopSearchView];
    
    [self setUpGIFRrfresh];
    
//    //限时秒杀的时间
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getTime:) name:@"countDownTime" object:nil];
    
    //抢购详情的商品id
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getGoodsID:) name:@"goodsID" object:nil];
    
    [self loadData];
}

//-(void)getTime:(NSNotification *)text{
//    self.dict = text.userInfo;
//}

//跳转到抢购详情页面
-(void)getGoodsID:(NSNotification *)text{
    ADSallGoodsDetailViewController *sallGoodsDetailVC = [[ADSallGoodsDetailViewController alloc] init];
    [sallGoodsDetailVC loadDataWithGoodsID:text.userInfo[@"goodsID"]];
    [self.navigationController pushViewController:sallGoodsDetailVC animated:YES];
}
-(void)loadData{
    [RequestTool getFloorData:nil withSuccessBlock:^(NSDictionary *result) {
        NSLog(@"获取首页楼层数据result = %@",result);
        if([result[@"code"] integerValue] == 1){
            [self withNSDictionary:result];
        }
    } withFailBlock:^(NSString *msg) {
        NSLog(@"获取首页楼层数据msg = %@",msg);
    }];
}

-(void)withNSDictionary:(NSDictionary *)dict
{
    NSArray *dataInfo = dict[@"data"][@"result"];
    _floorDataItem = [ADFloorModel mj_objectArrayWithKeyValuesArray:dataInfo];
//    for (ADFloorModel *model in _floorDataItem) {
//            NSLog(@"获取首页楼层数据model = %@",model.mj_keyValues);
//
//    }
}

- (NSMutableArray<ADFloorModel *> *)floorDataItem
{
    if (!_floorDataItem) {
        _floorDataItem = [NSMutableArray array];
    }
    return _floorDataItem;
}

#pragma mark - 导航栏
- (void)setUpTopToolView
{
    _topToolView = [[DCHomeTopToolView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    [_topToolView setTopTitleWithNSString:@"爱迪尔商城"];
    [self.view addSubview:_topToolView];
    
}

#pragma mark - 搜索框
- (void)setUpTopSearchView
{
    _topSearchView = [[ADHomeSearchView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 50)];
//    WEAKSELF
    _topSearchView.searchButtonClickBlock = ^{
        NSLog(@"点击了首页搜索");
    };
    [self.view addSubview:_topSearchView];
    
}

#pragma mark - initialize
- (void)setUpBase
{
    self.collectionView.backgroundColor = kBACKGROUNDCOLOR;
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
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
    return 6;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) { //10属性
        return 0;
    }
    return 1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *gridcell = nil;
        if (indexPath.section == 1) {//倒计时
        DCGoodsCountDownCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCGoodsCountDownCellID forIndexPath:indexPath];
//            cell.lookDetailBlock = ^{
//                //进入抢购商品详情页面
//            };
        gridcell = cell;
    }
    else if (indexPath.section == 2) {//明星产品
        ADStarGoodsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ADStarGoodsCellID forIndexPath:indexPath];
        cell.lookDetailBlock = ^{
            ADGoodsDetailViewController *detailVC = [[ADGoodsDetailViewController alloc] init];
            [self.navigationController pushViewController:detailVC animated:YES];
        };
        gridcell = cell;
    }else if (indexPath.section == 3) {//智能硬件
        DCExceedApplianceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCExceedApplianceCellID forIndexPath:indexPath];
//        cell.goodExceedArray = GoodsRecommendArray;
        for (ADFloorModel *model in _floorDataItem) {
            if([model.floorName isEqualToString:@"酒店门锁"]){
                [cell loadDataWithFloorID:model.floorId];
            }
        }
        cell.lookDetailBlock = ^{
            ADGoodsDetailViewController *detailVC = [[ADGoodsDetailViewController alloc] init];
            [self.navigationController pushViewController:detailVC animated:YES];
        };
//        cell.backgroundColor = [UIColor redColor];
        gridcell = cell;
        
    }else if (indexPath.section == 4) {//按钮
        ADButtonViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ADButtonViewCellID forIndexPath:indexPath];
//                cell.backgroundColor = [UIColor cyanColor];
        gridcell = cell;
        
    }
    else  if (indexPath.section == 5){//为您推荐
        ADRecommendCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ADRecommendCellID forIndexPath:indexPath];
//        cell.goodExceedArray = GoodsRecommendArray;
//        for (ADFloorModel *model in _floorDataItem) {
//            if([model.floorName isEqualToString:@"酒店门锁"]){
//                [cell loadDataWithFloorID:model.floorId];
//            }
//        }
        cell.lookDetailBlock = ^{
            ADGoodsDetailViewController *detailVC = [[ADGoodsDetailViewController alloc] init];
            [self.navigationController pushViewController:detailVC animated:YES];
        };
        gridcell = cell;
    }
    return gridcell;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableview = nil;
        if (indexPath.section == 0) {
            DCSlideshowHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCSlideshowHeadViewID forIndexPath:indexPath];
            [headerView loadDataWithAdvertID:@"1"];
//            headerView.imageGroupArray = GoodsHomeSilderImagesArray;
            reusableview = headerView;
        }else if(indexPath.section == 1){
//            限时秒杀
            DCCountDownHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCCountDownHeadViewID forIndexPath:indexPath];
            headerView.lookAllBlock = ^{
                //进入限时抢购页面
                ADFlashSaleViewController *flashSaleVC = [[ADFlashSaleViewController alloc] init];
                flashSaleVC.timeDict = self.dict;
                [self.navigationController pushViewController:flashSaleVC animated:YES];
            };
            
            
            reusableview = headerView;
        }else if(indexPath.section == 2){
            //            明星产品
            ADStarProductHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ADStarProductHeadViewID forIndexPath:indexPath];
            [headerView setTopTitleWithNSString:@"明星产品"];
            headerView.lookAllBlock = ^{
                //进入列表页面
                ADGoodsListViewController *goodsListVC = [[ADGoodsListViewController alloc] init];
                goodsListVC.titleString = @"明星产品";
                goodsListVC.index = 0;
                [self.navigationController pushViewController:goodsListVC animated:YES];
            };
            reusableview = headerView;
        }else if(indexPath.section == 3){
            //            智能硬件
            ADStarProductHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ADStarProductHeadViewID forIndexPath:indexPath];
            [headerView setTopTitleWithNSString:@"智能硬件"];
            headerView.lookAllBlock = ^{
                //进入列表页面
                ADGoodsListViewController *goodsListVC = [[ADGoodsListViewController alloc] init];
                goodsListVC.titleString = @"智能硬件";
                goodsListVC.index = 0;
                [self.navigationController pushViewController:goodsListVC animated:YES];
            };
            reusableview = headerView;
        }
        else if(indexPath.section == 5){
            //            为您推荐
            ADStarProductHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ADStarProductHeadViewID forIndexPath:indexPath];
            [headerView setTopTitleWithNSString:@"为您推荐"];
            headerView.lookAllBlock = ^{
                //进入列表页面
                ADGoodsListViewController *goodsListVC = [[ADGoodsListViewController alloc] init];
                goodsListVC.titleString = @"为您推荐";
                goodsListVC.index = 0;
                [self.navigationController pushViewController:goodsListVC animated:YES];
            };
            reusableview = headerView;
        }
    NSLog(@"reusableview = %@",reusableview);
    return reusableview;
}

//这里我为了直观的看出每组的CGSize设置用if 后续我会用简洁的三元表示
#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {//计时
        return CGSizeMake(kScreenWidth, 175);
    }
    if (indexPath.section == 2) {//明星产品
        return CGSizeMake(kScreenWidth,175);
    }
    if (indexPath.section == 3) {//智能硬件
        return CGSizeMake(kScreenWidth,350);
    }
    if (indexPath.section == 4) {//按钮
        return CGSizeMake(kScreenWidth,40);
    }
    if (indexPath.section == 5) {//为您推荐
        return CGSizeMake(kScreenWidth,220);
    }
    return CGSizeZero;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    if (indexPath.section == 4) {
        if (indexPath.row == 0) {
            layoutAttributes.size = CGSizeZero;
//            layoutAttributes.size = CGSizeMake(kScreenWidth, kScreenWidth * 0.38);
        }else if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5){
            layoutAttributes.size = CGSizeMake(kScreenWidth * 0.5, kScreenWidth * 0.24);
        }else{
            layoutAttributes.size = CGSizeMake(kScreenWidth * 0.25, kScreenWidth * 0.35);
        }
    }
    return layoutAttributes;
}

#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return CGSizeMake(kScreenWidth, 230); //图片滚动的宽高
    }
    if (section == 1 || section == 2 || section == 3 || section == 5) {//猜你喜欢的宽高
        return CGSizeMake(kScreenWidth, 40);  //推荐适合的宽高
    }
    return CGSizeZero;
}

#pragma mark - foot宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
#pragma mark - X间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return (section == 6) ? 4 : 0;
}
#pragma mark - Y间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return (section == 6) ? 4 : 0;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if(section == 4){
            return UIEdgeInsetsMake(0, 0, 0, 0);//分别为上、左、下、右
    }else{
            return UIEdgeInsetsMake(0, 0, 15, 0);//分别为上、左、下、右
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"有没有来这");
//    if(indexPath.section == 5){
//        NSLog(@"有没有来这里");
//        ADGoodsDetailViewController *detailVC = [[ADGoodsDetailViewController alloc] init];
//        [self.navigationController pushViewController:detailVC animated:YES];
//    }
//    if (indexPath.section == 0) {//10
//
//        DCGoodsSetViewController *goodSetVc = [[DCGoodsSetViewController alloc] init];
//        goodSetVc.goodPlisName = @"ClasiftyGoods.plist";
//        [self.navigationController pushViewController:goodSetVc animated:YES];
//        NSLog(@"点击了10个属性第%zd",indexPath.row);
//    }else if (indexPath.section == 5){
//        NSLog(@"点击了推荐的第%zd个商品",indexPath.row);
//
//        DCGoodDetailViewController *dcVc = [[DCGoodDetailViewController alloc] init];
//        dcVc.goodTitle = _youLikeItem[indexPath.row].main_title;
//        dcVc.goodPrice = _youLikeItem[indexPath.row].price;
//        dcVc.goodSubtitle = _youLikeItem[indexPath.row].goods_title;
//        dcVc.shufflingArray = _youLikeItem[indexPath.row].images;
//        dcVc.goodImageView = _youLikeItem[indexPath.row].image_url;
//
//        [self.navigationController pushViewController:dcVc animated:YES];
//    }
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _topSearchView.hidden = (scrollView.contentOffset.y > 0) ? YES : NO;//判断顶部工具View的显示和隐形
}

#pragma mark - collectionView滚回顶部
- (void)ScrollToTop
{
    [self.collectionView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
