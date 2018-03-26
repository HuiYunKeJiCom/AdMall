//
//  ADAfterSaleServiceDetailViewController.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/2.
//  Copyright © 2018年 Adel. All rights reserved.
//  售后服务单详情

#import "ADAfterSaleServiceDetailViewController.h"
#import "ADOrderTopToolView.h"
#import "DCHomeRefreshGifHeader.h"
#import "ADServiceStateView.h"
#import "ADServiceFlowViewCell.h" //售后流程
#import "ADOrderBasicViewCell.h"  //订单基本信息
#import "ADExpressInformationViewCell.h"//快递单信息
#import "ADShipAddressViewCell.h"//发货地址
#import "ADApplicationRecordViewCell.h"//售后申请记录

@interface ADAfterSaleServiceDetailViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
/* collectionView */
@property (strong , nonatomic)UICollectionView *collectionView;

/* 顶部Nva */
@property (strong , nonatomic)ADOrderTopToolView *topToolView;

@end

static NSString *const ADServiceStateViewID = @"ADServiceStateView";
static NSString *const ADServiceFlowViewCellID = @"ADServiceFlowViewCell";
static NSString *const ADOrderBasicViewCellID = @"ADOrderBasicViewCell";
static NSString *const ADExpressInformationViewCellID = @"ADExpressInformationViewCell";
static NSString *const ADShipAddressViewCellID = @"ADShipAddressViewCell";
static NSString *const ADApplicationRecordViewCellID = @"ADApplicationRecordViewCell";


@implementation ADAfterSaleServiceDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = k_UIColorFromRGB(0xffffff);
    [self setUpBase];
    [self setUpGIFRrfresh];
    [self setUpNavTopView];
}

#pragma mark - 导航栏处理
- (void)setUpNavTopView
{
    _topToolView = [[ADOrderTopToolView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    _topToolView.hidden = NO;
    [_topToolView setTopTitleWithNSString:KLocalizableStr(@"售后服务单详情")];
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
        _collectionView.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight -64);
        _collectionView.showsVerticalScrollIndicator = NO;        //注册
        [_collectionView registerClass:[ADServiceFlowViewCell class] forCellWithReuseIdentifier:ADServiceFlowViewCellID];
        [_collectionView registerClass:[ADOrderBasicViewCell class] forCellWithReuseIdentifier:ADOrderBasicViewCellID];
        [_collectionView registerClass:[ADExpressInformationViewCell class] forCellWithReuseIdentifier:ADExpressInformationViewCellID];
        [_collectionView registerClass:[ADShipAddressViewCell class] forCellWithReuseIdentifier:ADShipAddressViewCellID];
        [_collectionView registerClass:[ADApplicationRecordViewCell class] forCellWithReuseIdentifier:ADApplicationRecordViewCellID];
        
            [_collectionView registerClass:[ADServiceStateView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ADServiceStateViewID];
        
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
        ADServiceFlowViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ADServiceFlowViewCellID forIndexPath:indexPath];
        //            cell.gridItem = _gridItem[indexPath.row];
        cell.backgroundColor = [UIColor whiteColor];
        gridcell = cell;

    }else if (indexPath.section == 1) {//订单基本信息
        ADOrderBasicViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ADOrderBasicViewCellID forIndexPath:indexPath];
        //            cell.gridItem = _gridItem[indexPath.row];
        cell.backgroundColor = [UIColor whiteColor];
        gridcell = cell;
    }
    else if (indexPath.section == 2) {//快递单信息
        ADExpressInformationViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ADExpressInformationViewCellID forIndexPath:indexPath];
        //            cell.gridItem = _gridItem[indexPath.row];
        cell.backgroundColor = [UIColor whiteColor];
        gridcell = cell;
    }else if (indexPath.section == 3) {//发货地址
        ADShipAddressViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ADShipAddressViewCellID forIndexPath:indexPath];
        //            cell.gridItem = _gridItem[indexPath.row];
        cell.backgroundColor = [UIColor whiteColor];
        gridcell = cell;
    }else if (indexPath.section == 4) {//售后申请记录
        ADApplicationRecordViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ADApplicationRecordViewCellID forIndexPath:indexPath];
        //            cell.gridItem = _gridItem[indexPath.row];
        cell.backgroundColor = [UIColor whiteColor];
        gridcell = cell;
    }
    return gridcell;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableview = nil;
    if (indexPath.section == 0) {
        ADServiceStateView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ADServiceStateViewID forIndexPath:indexPath];
        //        headerView.imageGroupArray = GoodsHomeSilderImagesArray;
        reusableview = headerView;
    }
    return reusableview;
}

//这里我为了直观的看出每组的CGSize设置用if 后续我会用简洁的三元表示
#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {//售后流程
        return CGSizeMake(kScreenWidth, 150);
    }
    if (indexPath.section == 1) {//基本信息
        return CGSizeMake(kScreenWidth, 150);
    }
    if (indexPath.section == 2) {//快递单信息
        return CGSizeMake(kScreenWidth, 190);
    }
    if (indexPath.section == 3) {//发货地址
        return CGSizeMake(kScreenWidth, 145);
    }
    if (indexPath.section == 4) {//售后申请记录
        return CGSizeMake(kScreenWidth, 185);
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
