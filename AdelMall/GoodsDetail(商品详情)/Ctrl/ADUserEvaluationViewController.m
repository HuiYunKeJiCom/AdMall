//
//  ADUserEvaluationViewController.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/2/7.
//  Copyright © 2018年 Adel. All rights reserved.
//  商品详情-用户评论

#import "ADUserEvaluationViewController.h"
#import "DCHomeRefreshGifHeader.h"
#import "ADEvaluateLabelViewCell.h"
#import "ADEvaluateViewCell.h"
#import "ADEvaluateDetailViewController.h"//评论详情

@interface ADUserEvaluationViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
/** 横线 */
@property(nonatomic,strong)UIView *lineView;
/* collectionView */
@property (strong , nonatomic)UICollectionView *collectionView;

@end

//static NSString *const ADEvaluateLabelViewCellID = @"ADEvaluateLabelViewCell";
//static NSString *const ADEvaluateViewCellID = @"ADEvaluateViewCell";

@implementation ADUserEvaluationViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = k_UIColorFromRGB(0xffffff);
    [self createLine];
    [self setUpBase];
    [self setUpGIFRrfresh];
}

#pragma mark - LazyLoad
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.frame = CGRectMake(0, 1, kScreenWidth, kScreenHeight);
        self.collectionViewHeight = _collectionView.collectionViewLayout.collectionViewContentSize.height;
        _collectionView.showsVerticalScrollIndicator = NO;        //注册
        [_collectionView registerClass:[ADEvaluateLabelViewCell class] forCellWithReuseIdentifier:ADEvaluateLabelViewCellID];
        [_collectionView registerClass:[ADEvaluateViewCell class] forCellWithReuseIdentifier:ADEvaluateViewCellID];
        
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

#pragma mark - initialize
- (void)setUpBase
{
    self.collectionView.backgroundColor = [UIColor lightGrayColor];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)createLine
{
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
    self.lineView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.lineView];
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
    return 4;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *gridcell = nil;
    if (indexPath.section == 0) {//评论标签
        ADEvaluateLabelViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ADEvaluateLabelViewCellID forIndexPath:indexPath];
        //            cell.gridItem = _gridItem[indexPath.row];
        cell.backgroundColor = [UIColor whiteColor];
        gridcell = cell;

    }else {//评论
        ADEvaluateViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ADEvaluateViewCellID forIndexPath:indexPath];
        //            cell.gridItem = _gridItem[indexPath.row];
        cell.backgroundColor = [UIColor whiteColor];
        cell.evaluateBtnClickBlock = ^{
            NSLog(@"点击了评论");
            ADEvaluateDetailViewController *evaluateDetailVC = [[ADEvaluateDetailViewController alloc] init];
            [self.navigationController pushViewController:evaluateDetailVC animated:YES];
        };
        gridcell = cell;
    }
    return gridcell;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableview = nil;
//    if (indexPath.section == 0) {
//        ADOrderStateView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ADOrderStateViewID forIndexPath:indexPath];
//        //        headerView.imageGroupArray = GoodsHomeSilderImagesArray;
//        reusableview = headerView;
//    }
    return reusableview;
}

//这里我为了直观的看出每组的CGSize设置用if 后续我会用简洁的三元表示
#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {//评价标签
        return CGSizeMake(kScreenWidth, 110);
    }
    if ((indexPath.section > 0) && (indexPath.section < 4)) {//评论
        return CGSizeMake(kScreenWidth, 190);
    }
//    if (indexPath.section == 2) {//发货信息
//        return CGSizeMake(kScreenWidth, 110);
//    }
//    if (indexPath.section == 3) {//保险单信息
//        return CGSizeMake(kScreenWidth, 40);
//    }
//    if (indexPath.section == 4) {//商品清单
//        return CGSizeMake(kScreenWidth, 50+109*2+110);
//    }
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
