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
#import "ADAdvertModel.h"//广告轮播图模型
#import "ADStarGoodsModel.h"//智能硬件模型
#import "ADCountDownGoodsModel.h"//限时秒杀模型

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
///* 智能硬件图片数组 */
//@property (copy , nonatomic)NSArray *goodExceedArray;
/** 智能硬件第一张图路径 */
@property(nonatomic,copy)NSString *exceedPath;
//
/* 智能硬件数据数组 */
@property (strong , nonatomic)NSMutableArray<ADStarGoodsModel *> *goodExceedItem;
/** 数据模型 */
@property(nonatomic,strong)ADStarGoodsModel *model;

/* 轮播图数组 */
@property (copy , nonatomic)NSArray *imageGroupArray;
/* 轮播图数据数组 */
@property (strong , nonatomic)NSMutableArray<ADAdvertModel *> *advertItem;

/* 抢购商品数组 */
@property (strong , nonatomic)NSMutableArray<ADCountDownGoodsModel *> *countDownItem;

/* 明星产品数据数组 */
@property (strong , nonatomic)NSMutableArray<ADStarGoodsModel *> *starGoodsItem;

/* 为您推荐数据数组 */
@property (strong , nonatomic)NSMutableArray<ADStarGoodsModel *> *recommendItem;
/* 为您推荐数组 */
@property (copy , nonatomic)NSArray *recommendArray;
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
//static NSString *const DCSlideshowHeadViewID = @"DCSlideshowHeadView";
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
    
    //商品详情的商品id
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getStarGoodsID:) name:@"starGoodsID" object:nil];
    
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

//跳转到商品详情页面
-(void)getStarGoodsID:(NSNotification *)text{
    ADGoodsDetailViewController *detailVC = [[ADGoodsDetailViewController alloc] init];
//    [detailVC loadDataWithGoodsID:text.userInfo[@"starGoodsID"]];
    detailVC.goodsID = text.userInfo[@"starGoodsID"];
    
    [self.navigationController pushViewController:detailVC animated:YES];
}


-(void)loadData{

    //(智能硬件)
    [RequestTool getFloorData:@{@"floorSize":@"1"} withSuccessBlock:^(NSDictionary *result) {
        NSLog(@"获取首页楼层数据result = %@",result);
        if([result[@"code"] integerValue] == 1){
            [self withNSDictionary:result];
        }
    } withFailBlock:^(NSString *msg) {
        NSLog(@"获取首页楼层数据msg = %@",msg);
    }];
    
    [RequestTool getImagePathForAD:@{@"advert_id":@"1"} withSuccessBlock:^(NSDictionary *result) {
        NSLog(@"获取轮播图result = %@",result);
        if([result[@"code"] integerValue] == 1){
            [self getSlideshowWithNSDictionary:result];
        }else{
            NSMutableArray *tempAdvertArr = [NSMutableArray array];
            self.imageGroupArray = tempAdvertArr;
        }
    } withFailBlock:^(NSString *msg) {
        NSLog(@"msg = %@",msg);
        NSMutableArray *tempAdvertArr = [NSMutableArray array];
        self.imageGroupArray = tempAdvertArr;
    }];

    [RequestTool getGoodsForFlashSale:nil withSuccessBlock:^(NSDictionary *result) {
        NSLog(@"限时秒杀result = %@",result);
        if([result[@"code"] integerValue] == 1){
            [self getCountDownWithNSDictionary:result];
        }
    } withFailBlock:^(NSString *msg) {
        NSLog(@"限时秒杀msg = %@",msg);
    }];

    [RequestTool getStarGoods:nil withSuccessBlock:^(NSDictionary *result) {
        NSLog(@"明星产品result = %@",result);
        if([result[@"code"] integerValue] == 1){
            [self getStarGoodsWithNSDictionary:result];
        }
    } withFailBlock:^(NSString *msg) {
        NSLog(@"明星产品msg = %@",msg);
    }];

    [RequestTool getRecommendData:nil withSuccessBlock:^(NSDictionary *result) {
        NSLog(@"为您推荐result = %@",result);

        if([result[@"code"] integerValue] == 1){
            [self getRecommendWithNSDictionary:result];
        }else{
            NSMutableArray *tempAdvertArr = [NSMutableArray array];
            self.recommendArray = tempAdvertArr;
        }

    } withFailBlock:^(NSString *msg) {
        NSLog(@"为您推荐msg = %@",msg);
        NSMutableArray *tempAdvertArr = [NSMutableArray array];
        self.recommendArray = tempAdvertArr;
    }];
    
}

//获取轮播图数据
-(void)getSlideshowWithNSDictionary:(NSDictionary *)dict
{
    NSArray *dataInfo = dict[@"data"][@"advert"];
    NSMutableArray *tempAdvertArr = [NSMutableArray array];
    _advertItem = [ADAdvertModel mj_objectArrayWithKeyValuesArray:dataInfo];
    for (ADAdvertModel *model in _advertItem) {
        //            NSLog(@"model = %@",model.mj_keyValues);
        [tempAdvertArr addObject:model.ad_image_path];
    }
    self.imageGroupArray = tempAdvertArr;
    self.exceedPath = self.imageGroupArray[0];
    [self.collectionView reloadData];
//    NSLog(@"self.imageGroupArray = %@",self.imageGroupArray);
}

//限时秒杀
-(void)getCountDownWithNSDictionary:(NSDictionary *)dict
{
    NSArray *dataInfo = dict[@"data"][@"group_goodsList"][@"resultList"];
    //    NSLog(@"抢购dataInfo = %@",dataInfo);
    _countDownItem = [ADCountDownGoodsModel mj_objectArrayWithKeyValuesArray:dataInfo];
    [self.collectionView reloadData];
}

//获取明星产品数据
-(void)getStarGoodsWithNSDictionary:(NSDictionary *)dict
{
    NSArray *dataInfo = dict[@"data"][@"goodsList"];
    _starGoodsItem = [ADStarGoodsModel mj_objectArrayWithKeyValuesArray:dataInfo];
    [self.collectionView reloadData];
}

//获取为您推荐数据
-(void)getRecommendWithNSDictionary:(NSDictionary *)dict
{
    NSArray *dataInfo = dict[@"data"][@"goodsList"];
    NSMutableArray *tempAdvertArr = [NSMutableArray array];
    _recommendItem = [ADStarGoodsModel mj_objectArrayWithKeyValuesArray:dataInfo];
    for (ADStarGoodsModel *model in _recommendItem) {
        NSLog(@"model = %@",model.mj_keyValues);
        [tempAdvertArr addObject:model.goods_image_path];
    }
    self.recommendArray = tempAdvertArr;
    [self.collectionView reloadData];
    //    NSLog(@"self.imageGroupArray = %@",self.imageGroupArray);
}

//获取首页楼层数据(智能硬件)
-(void)withNSDictionary:(NSDictionary *)dict
{

    NSArray *data= dict[@"data"][@"result"];
    NSArray *dataInfo = data[0][@"goodsList"];
//    NSMutableArray *tempAdvertArr = [NSMutableArray array];
    _goodExceedItem = [ADStarGoodsModel mj_objectArrayWithKeyValuesArray:dataInfo];
    
    
    
//    NSLog(@"_goodExceedItem = %lu",_goodExceedItem.count);
//    for (ADStarGoodsModel *model in _goodExceedItem) {
//        //        NSLog(@"model = %@",model.mj_keyValues);
//        [tempAdvertArr addObject:model.goods_image_path];
//    }
//    self.goodExceedArray = tempAdvertArr;
    [self.collectionView reloadData];
    
//    NSArray *dataInfo = dict[@"data"][@"result"];
//    _floorDataItem = [ADFloorModel mj_objectArrayWithKeyValuesArray:dataInfo];
//    for (ADFloorModel *model in _floorDataItem) {
//        if([model.floorId isEqualToString:@"1"]){
//            [self loadDataWithFloorID:model.floorId];
//        }
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
    [self loadData];

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
            [cell loadDataWithArray:self.countDownItem];
//            cell.lookDetailBlock = ^{
//                //进入抢购商品详情页面
//            };
        gridcell = cell;
    }
    else if (indexPath.section == 2) {//明星产品
        ADStarGoodsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ADStarGoodsCellID forIndexPath:indexPath];
        [cell loadDataWithArray:self.starGoodsItem];
//        cell.lookDetailBlock = ^{
//            ADGoodsDetailViewController *detailVC = [[ADGoodsDetailViewController alloc] init];
//            [self.navigationController pushViewController:detailVC animated:YES];
//        };
        gridcell = cell;
    }else if (indexPath.section == 3) {//智能硬件
        DCExceedApplianceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCExceedApplianceCellID forIndexPath:indexPath];
        [cell loadDataWithNSString:self.exceedPath and:self.goodExceedItem];
//        cell.goodExceedArray = GoodsRecommendArray;

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
        [cell loadDataWithArray:self.recommendArray and:self.recommendItem];
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
            [headerView loadDataWithArray:self.imageGroupArray];
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
                goodsListVC.keyWord = @"明星产品";
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
                goodsListVC.keyWord = @"智能硬件";
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
                goodsListVC.keyWord = @"为您推荐";
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
    if (indexPath.section == 3) {//智能硬件350
        return CGSizeMake(kScreenWidth,500);
    }
    if (indexPath.section == 4) {//按钮
        return CGSizeMake(kScreenWidth,40);
    }
    if (indexPath.section == 5) {//为您推荐
        return CGSizeMake(kScreenWidth,350);
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
