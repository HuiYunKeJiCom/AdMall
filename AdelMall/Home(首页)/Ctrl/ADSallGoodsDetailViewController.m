//
//  ADSallGoodsDetailViewController.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/16.
//  Copyright © 2018年 Adel. All rights reserved.
//  抢购商品详情

#import "ADSallGoodsDetailViewController.h"
#import "DCHomeRefreshGifHeader.h"
#import "DCSlideshowHeadView.h"  //轮播图
#import "ADOrderTopToolView.h"//自定义导航栏
#import "DCTabBarController.h"
#import "ADPlaceOrderViewController.h"//下单页面
#import "ADOnSallDetailHeadView.h"//抢购中
#import "ADGoodsIntroduceCell.h"//商品介绍
#import "ADAddressCell.h"//收货地址
#import "ADGoodsSpecCell.h"//商品规格
#import "ADRelatedTableViewCell.h"//相关商品tableView
#import "ADGoodsDetailViewController.h"//商品详情

#import "ADFlashSaleModel.h"

@interface ADSallGoodsDetailViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
/* collectionView */
@property (strong , nonatomic)UICollectionView *collectionView;
/* 顶部Nva */
@property (strong , nonatomic)ADOrderTopToolView *topToolView;
/** 是否打开地址筛选框 */
@property(nonatomic,assign)BOOL isOpen;
/** 是否打开商品规格选择页面 */
@property(nonatomic,assign)BOOL isOpenSpec;
/** 抢购活动商品模型 */
@property(nonatomic,strong)ADFlashSaleModel *model;

@end

/* cell */
static NSString *const ADGoodsIntroduceCellID = @"ADGoodsIntroduceCell";
static NSString *const ADAddressCellID = @"ADAddressCell";
static NSString *const ADGoodsSpecCellID = @"ADGoodsSpecCell";
static NSString *const ADRelatedTableViewCellID = @"ADRelatedTableViewCell";
/* head */
static NSString *const DCSlideshowHeadViewID = @"DCSlideshowHeadView";
static NSString *const ADOnSallDetailHeadViewID = @"ADOnSallDetailHeadView";

@implementation ADSallGoodsDetailViewController

#pragma mark - LazyLoad
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.estimatedItemSize = CGSizeMake(kScreenWidth, 200);
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight - DCBottomTabH-64);
        _collectionView.showsVerticalScrollIndicator = NO;        //注册
        _collectionView.backgroundColor = kBACKGROUNDCOLOR;
        
        [_collectionView registerClass:[ADGoodsIntroduceCell class] forCellWithReuseIdentifier:ADGoodsIntroduceCellID];
        [_collectionView registerClass:[ADAddressCell class] forCellWithReuseIdentifier:ADAddressCellID];
        [_collectionView registerClass:[ADGoodsSpecCell class] forCellWithReuseIdentifier:ADGoodsSpecCellID];
        [_collectionView registerClass:[ADRelatedTableViewCell class] forCellWithReuseIdentifier:ADRelatedTableViewCellID];
        
        [_collectionView registerClass:[DCSlideshowHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCSlideshowHeadViewID];
        [_collectionView registerClass:[ADOnSallDetailHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ADOnSallDetailHeadViewID];
        
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isOpen = NO;
    self.isOpenSpec = NO;
    [self setUpBase];
    
    [self setUpNavTopView];
    [self setUpBottomButton];
    
    [self setUpGIFRrfresh];

}

-(void)loadDataWithGoodsID:(NSString *)goodsID{
    //    @"65680"
    NSLog(@"goodsID = %@",goodsID);
    [RequestTool getFlashSaleDetail:@{@"id":goodsID} withSuccessBlock:^(NSDictionary *result) {
        NSLog(@"抢购详情result = %@",result);
        
        if([result[@"code"] integerValue] == 1){
            [self withNSDictionary:result];
        }else{
//            NSMutableArray *tempAdvertArr = [NSMutableArray array];
//            self.goodExceedArray = tempAdvertArr;
        }
        
    } withFailBlock:^(NSString *msg) {
        NSLog(@"抢购详情msg = %@",msg);
//        NSMutableArray *tempAdvertArr = [NSMutableArray array];
//        self.goodExceedArray = tempAdvertArr;
    }];
}

-(void)withNSDictionary:(NSDictionary *)dict
{
    NSArray *dataInfo = dict[@"data"];
    self.model = [ADFlashSaleModel mj_objectWithKeyValues:dataInfo];
    NSLog(@"self.model = %@",self.model.mj_keyValues);
    NSLog(@"spec_name = %@",dict[@"data"][@"specs"]);
    [_topToolView setTopTitleWithNSString:KLocalizableStr(self.model.gg_name)];
    [self.collectionView reloadData];
}

#pragma mark - 导航栏处理
- (void)setUpNavTopView
{
    _topToolView = [[ADOrderTopToolView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    _topToolView.hidden = NO;
//    [_topToolView setTopTitleWithNSString:KLocalizableStr(@"3398型 智能门锁家庭酒店专用指纹智能门锁")];
    WEAKSELF
    _topToolView.backgroundColor = [UIColor whiteColor];
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
    NSArray *titles = @[@"加入购物车",@"立即购买"];
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
            NSLog(@"立即购买");
            //跳转到 下单页面
            ADPlaceOrderViewController *placeOrderVC = [[ADPlaceOrderViewController alloc] init];
            [self.navigationController pushViewController:placeOrderVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - initialize
- (void)setUpBase
{
    self.collectionView.backgroundColor =kBACKGROUNDCOLOR;
    
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
    //    return 6;
    return 5;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) { //10属性
        return 0;
    }
    //    if (section == 1 || section == 2 || section == 3) { //广告福利  倒计时  掌上专享
    //        return 1;
    //    }
    //    if (section == 4) { //推荐
    //        return GoodsHandheldImagesArray.count;
    //    }
    //    if (section == 5) { //猜你喜欢
    //        return _youLikeItem.count;
    //    }
    return 1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *gridcell = nil;
    if (indexPath.section == 1) {//抢购商品说明
        ADGoodsIntroduceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ADGoodsIntroduceCellID forIndexPath:indexPath];
        cell.model = self.model;
        gridcell = cell;
    }
    else if (indexPath.section == 2) {//收货地址
        ADAddressCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ADAddressCellID forIndexPath:indexPath];
//        cell.backgroundColor = [UIColor redColor];
        cell.openViewClickBlock = ^{
            self.isOpen = YES;
//            [collectionView reloadItemsAtIndexPaths:@[indexPath]];
            [collectionView reloadData];
        };
        cell.closeViewClickBlock = ^{
            self.isOpen = NO;
            [collectionView reloadData];
//            [collectionView reloadItemsAtIndexPaths:@[indexPath]];
        };
        gridcell = cell;
    }
    else if (indexPath.section == 3) {//商品规格
        ADGoodsSpecCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ADGoodsSpecCellID forIndexPath:indexPath];
        cell.openViewClickBlock = ^{
            self.isOpenSpec = YES;
            [collectionView reloadData];
        };
        cell.closeViewClickBlock = ^{
            self.isOpenSpec = NO;
            [collectionView reloadData];
        };
        gridcell = cell;

    }
    else if (indexPath.section == 4) {//相关商品
        ADRelatedTableViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ADRelatedTableViewCellID forIndexPath:indexPath];
        gridcell = cell;
        cell.imageViewBtnClickBlock = ^{
            //进入商品详情
            ADGoodsDetailViewController *detailVC = [[ADGoodsDetailViewController alloc] init];
            [self.navigationController pushViewController:detailVC animated:YES];
        };
    }
    return gridcell;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableview = nil;
    
    //    if (kind == UICollectionElementKindSectionHeader){
    if (indexPath.section == 0) {
        DCSlideshowHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCSlideshowHeadViewID forIndexPath:indexPath];
        headerView.imageGroupArray = self.model.picPaths;
//        [headerView loadDataWithAdvertID:@"1"];
        reusableview = headerView;
    }
    else if(indexPath.section == 1){
        //            抢购中
        ADOnSallDetailHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ADOnSallDetailHeadViewID forIndexPath:indexPath];
        headerView.model = self.model;
        reusableview = headerView;
    }
    return reusableview;
}

//这里我为了直观的看出每组的CGSize设置用if 后续我会用简洁的三元表示
#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    //    if (indexPath.section == 0) {//9宫格组
    //        return CGSizeMake(kScreenWidth/5 , kScreenWidth/5 + DCMargin);
    //    }
    //    if (indexPath.section == 0) {//广告
    //        return CGSizeMake(kScreenWidth, 180);
    //    }
    if (indexPath.section == 1) {//抢购商品描述
        return CGSizeMake(kScreenWidth, 85);
    }
    if (indexPath.section == 2) {//收货地址
        if(self.isOpen){
            return CGSizeMake(kScreenWidth,280);
        }else{
            return CGSizeMake(kScreenWidth,40);
        }
    }
    if (indexPath.section == 3) {//商品规格
        if(self.isOpenSpec){
            return CGSizeMake(kScreenWidth,333);
        }else{
            return CGSizeMake(kScreenWidth,40);
        }
    }
    if (indexPath.section == 4) {//相关商品
        return CGSizeMake(kScreenWidth,540);
    }
    if (indexPath.section == 5) {//为您推荐
        return CGSizeMake(kScreenWidth,220);
    }
    return CGSizeZero;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    if(indexPath.section == 2){
        layoutAttributes.size = CGSizeMake(kScreenWidth, 200);
    }
    return layoutAttributes;
}

#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return CGSizeMake(kScreenWidth, 230); //图片滚动的宽高
    }
    if (section == 1 || section == 5) {//猜你喜欢的宽高
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
    if(section == 0){
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
    //    NSLog(@"offset = %.2f",scrollView.contentOffset.y);
    //    _backTopButton.hidden = (scrollView.contentOffset.y > kScreenHeight) ? NO : YES;//判断顶部是否隐藏
    //    _topToolView.hidden = (scrollView.contentOffset.y > 0) ? YES : NO;//判断顶部工具View的显示和隐形
    //
    //    if (scrollView.contentOffset.y > DCNaviH) {
    //        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    //        [[NSNotificationCenter defaultCenter]postNotificationName:SHOWTOPTOOLVIEW object:nil];
    //    }else{
    //        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    //        [[NSNotificationCenter defaultCenter]postNotificationName:HIDETOPTOOLVIEW object:nil];
    //    }
}

#pragma mark - collectionView滚回顶部
- (void)ScrollToTop
{
    [self.collectionView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}

#pragma mark - 消息
- (void)messageItemClick
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
