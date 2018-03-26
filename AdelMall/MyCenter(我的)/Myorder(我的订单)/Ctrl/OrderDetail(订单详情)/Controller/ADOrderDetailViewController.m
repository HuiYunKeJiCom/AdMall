//
//  ADOrderDetailViewController.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/2/6.
//  Copyright © 2018年 Adel. All rights reserved.
//  订单详情

#import "ADOrderDetailViewController.h"
#import "ADOrderTopToolView.h"
#import "DCHomeRefreshGifHeader.h"
#import "ADOrderStateView.h"
#import "ADOrderBasicViewCell.h"
#import "ADInvoiceViewCell.h"
#import "ADDeliveryViewCell.h"
#import "ADPolicyViewCell.h"
#import "ADOrderListViewCell.h"


@interface ADOrderDetailViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
/* collectionView */
@property (strong , nonatomic)UICollectionView *collectionView;

/* 顶部Nva */
@property (strong , nonatomic)ADOrderTopToolView *topToolView;

@end

static NSString *const ADOrderStateViewID = @"ADOrderStateView";
static NSString *const ADOrderBasicViewCellID = @"ADOrderBasicViewCell";
static NSString *const ADInvoiceViewCellID = @"ADInvoiceViewCell";
static NSString *const ADDeliveryViewCellID = @"ADDeliveryViewCell";
static NSString *const ADPolicyViewCellID = @"ADPolicyViewCell";
static NSString *const ADOrderListViewCellID = @"ADOrderListViewCell";

@implementation ADOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = k_UIColorFromRGB(0xffffff);
    [self setUpBase];
    [self setUpGIFRrfresh];
    [self setUpNavTopView];
    [self setUpToPayButton];
}

#pragma mark - 导航栏处理
- (void)setUpNavTopView
{
    _topToolView = [[ADOrderTopToolView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    _topToolView.hidden = NO;
    [_topToolView setTopTitleWithNSString:KLocalizableStr(@"订单详情")];
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

#pragma mark - LazyLoad
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight - 50-64);
        _collectionView.showsVerticalScrollIndicator = NO;        //注册
        [_collectionView registerClass:[ADOrderBasicViewCell class] forCellWithReuseIdentifier:ADOrderBasicViewCellID];
        [_collectionView registerClass:[ADInvoiceViewCell class] forCellWithReuseIdentifier:ADInvoiceViewCellID];
        [_collectionView registerClass:[ADDeliveryViewCell class] forCellWithReuseIdentifier:ADDeliveryViewCellID];
        [_collectionView registerClass:[ADPolicyViewCell class] forCellWithReuseIdentifier:ADPolicyViewCellID];
        [_collectionView registerClass:[ADOrderListViewCell class] forCellWithReuseIdentifier:ADOrderListViewCellID];
        [_collectionView registerClass:[ADOrderStateView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ADOrderStateViewID];
//        [_collectionView registerClass:[ADVideoViewCell class] forCellWithReuseIdentifier:ADVideoViewCellID];
        
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

#pragma mark - initialize
- (void)setUpBase
{
    self.collectionView.backgroundColor = kBACKGROUNDCOLOR;
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

#pragma mark - 去支付
- (void)setUpToPayButton
{
//    NSArray *imagesNor = @[@"tabr_08gouwuche"];
    //    NSArray *imagesSel = @[@"tabr_08gouwuche"];
    CGFloat buttonW = kScreenWidth;
    CGFloat buttonH = 50;
    CGFloat buttonY = kScreenHeight - buttonH;
    
//    for (NSInteger i = 0; i < imagesNor.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor redColor];
//        button.tag = i;
//        [button addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//        CGFloat buttonX = (buttonW * i);
        [button setTitle:@"去支付" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.frame = CGRectMake(0, buttonY, buttonW, buttonH);
        button.layer.borderWidth=0.5;
        button.layer.borderColor=[UIColor grayColor].CGColor;
        [self.view addSubview:button];
//    }
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
    return 5;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *gridcell = nil;
    if (indexPath.section == 0) {
        ADOrderBasicViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ADOrderBasicViewCellID forIndexPath:indexPath];
        //            cell.gridItem = _gridItem[indexPath.row];
        cell.backgroundColor = [UIColor whiteColor];
        gridcell = cell;

    }else if (indexPath.section == 1) {//发票信息
        ADInvoiceViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ADInvoiceViewCellID forIndexPath:indexPath];
        //            cell.gridItem = _gridItem[indexPath.row];
        cell.backgroundColor = [UIColor whiteColor];
        gridcell = cell;
    }else if (indexPath.section == 2) {//发货信息
        ADDeliveryViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ADDeliveryViewCellID forIndexPath:indexPath];
        //            cell.gridItem = _gridItem[indexPath.row];
        cell.backgroundColor = [UIColor whiteColor];
        gridcell = cell;
    }else if (indexPath.section == 3) {//保险单信息
        ADPolicyViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ADPolicyViewCellID forIndexPath:indexPath];
        //            cell.gridItem = _gridItem[indexPath.row];
        cell.backgroundColor = [UIColor whiteColor];
        gridcell = cell;
    }else if (indexPath.section == 4) {//商品清单
        ADOrderListViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ADOrderListViewCellID forIndexPath:indexPath];
        //            cell.gridItem = _gridItem[indexPath.row];
        cell.backgroundColor = [UIColor whiteColor];
        gridcell = cell;
    }
    return gridcell;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableview = nil;
    if (indexPath.section == 0) {
        ADOrderStateView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ADOrderStateViewID forIndexPath:indexPath];
//        headerView.imageGroupArray = GoodsHomeSilderImagesArray;
        reusableview = headerView;
    }
    return reusableview;
}

//这里我为了直观的看出每组的CGSize设置用if 后续我会用简洁的三元表示
#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {//基本信息
        return CGSizeMake(kScreenWidth, 150);
    }
    if (indexPath.section == 1) {//发票信息
        return CGSizeMake(kScreenWidth, 90);
    }
    if (indexPath.section == 2) {//发货信息
        return CGSizeMake(kScreenWidth, 110);
    }
    if (indexPath.section == 3) {//保险单信息
        return CGSizeMake(kScreenWidth, 40);
    }
    if (indexPath.section == 4) {//商品清单
        return CGSizeMake(kScreenWidth, 50+109*2+110);
    }
    return CGSizeZero;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    return layoutAttributes;
}

#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {//
        return CGSizeMake(kScreenWidth, 40);
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
