//
//  ADDetailViewModel.m
//  ScrollView_Nest
//
//  Created by apple on 2018/4/4.
//  Copyright © 2018年 1911. All rights reserved.
//

#import "ADDetailViewModel.h"
//#import "SDCycleScrollView.h"
#import "ADDetailViewCell.h"
#import "ADVideoViewCell.h"
#import "DCSlideshowHeadView.h"  //轮播图
//#import "DCSlideshowHeadView.h"
#import "DCHomeRefreshGifHeader.h"
#import "ADGoodsDetailModel.h"

@interface ADDetailViewModel()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation ADDetailViewModel
@synthesize detailView = _detailView;

- (UICollectionView *)detailView{
    if (!_detailView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        
        _detailView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _detailView.dataSource = self;
        _detailView.delegate = self;
        _detailView.showsVerticalScrollIndicator = NO;
        _detailView.showsHorizontalScrollIndicator = NO;
        _detailView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - DCBottomTabH);
        _detailView.backgroundColor = [UIColor whiteColor];
        [_detailView registerClass:[ADDetailViewCell class] forCellWithReuseIdentifier:ADDetailViewCellID];
        [_detailView registerClass:[ADVideoViewCell class] forCellWithReuseIdentifier:ADVideoViewCellID];
        [_detailView registerClass:[DCSlideshowHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCSlideshowHeadViewID];
        _detailView.mj_header = [DCHomeRefreshGifHeader headerWithRefreshingBlock:^{
            WEAKSELF
            if (@available(iOS 10.0, *)) {
                UIImpactFeedbackGenerator *generator = [[UIImpactFeedbackGenerator alloc] initWithStyle: UIImpactFeedbackStyleHeavy];
                [generator prepare];
                [generator impactOccurred];
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ //手动延迟
                [weakSelf.detailView.mj_header endRefreshing];
            });
        }];
        
    }
    return _detailView;
}

#pragma mark - -- UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    UICollectionViewCell *gridCell = nil;
    if (indexPath.section == 0) {//产品详细
        ADDetailViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ADDetailViewCellID forIndexPath:indexPath];
        cell.dataModel = self.dataModel;
        [cell changeLabelWith:self.specValueArr];
        gridCell = cell;
    }else if (indexPath.section == 1){//视频播放
        ADVideoViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ADVideoViewCellID forIndexPath:indexPath];
        gridCell = cell;
        
    }
    
    return gridCell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableview = nil;
    if (indexPath.section == 0) {
        DCSlideshowHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCSlideshowHeadViewID forIndexPath:indexPath];
       [headerView loadDataWithArray:self.imageGroupArray];
        reusableview = headerView;
    }
    return reusableview;
}

#pragma mark - -- UICollectionView Delegate Flow Layout

#pragma mark - -- Footer Size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeZero;
}

#pragma mark - -- X 间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return (section == 5) ? 4 : 0;
}

#pragma mark - -- Y 间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return (section == 5) ? 4 : 0;
}

#pragma mark - -- Section 间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 15, 0);//分别为上、下、左、右
}

#pragma mark - -- CellItem 大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {//广告
        return CGSizeMake(kScreenWidth, 60);
    }
    if (indexPath.section == 1) {//计时
        return CGSizeMake(kScreenWidth, 220);
    }
    
    return CGSizeZero;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    return layoutAttributes;
}

#pragma mark - -- Header 大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeMake(kScreenWidth, 230); //图片滚动的宽高
    }
    return CGSizeZero;
}

#pragma mark - -- Footer 大小


#pragma mark - -- UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(NSMutableArray *)imageGroupArray{
    if (!_imageGroupArray) {
        _imageGroupArray = [NSMutableArray array];
    }
    return _imageGroupArray;
}

-(NSMutableArray *)specValueArr{
    if (!_specValueArr) {
        _specValueArr = [NSMutableArray array];
    }
    return _specValueArr;
}

-(void)setDataModel:(ADGoodsDetailModel *)dataModel{
    _dataModel = dataModel;
}


@end
