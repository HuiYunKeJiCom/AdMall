//
//  ADUserEvaluationViewModel.m
//  AdelMall
//
//  Created by apple on 2018/4/11.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import "ADUserEvaluationViewModel.h"
#import "DCHomeRefreshGifHeader.h"
#import "ADEvaluateLabelViewCell.h"
#import "ADEvaluateViewCell.h"

@interface ADUserEvaluationViewModel()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation ADUserEvaluationViewModel
@synthesize userEvaluationListView = _userEvaluationListView;

- (UICollectionView *)userEvaluationListView{
    if (!_userEvaluationListView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        _userEvaluationListView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _userEvaluationListView.delegate = self;
        _userEvaluationListView.dataSource = self;
        _userEvaluationListView.showsVerticalScrollIndicator = NO;
        _userEvaluationListView.showsHorizontalScrollIndicator = NO;
        
        _userEvaluationListView.backgroundColor = [UIColor whiteColor];
        [_userEvaluationListView registerClass:[ADEvaluateLabelViewCell class] forCellWithReuseIdentifier:ADEvaluateLabelViewCellID];
        [_userEvaluationListView registerClass:[ADEvaluateViewCell class] forCellWithReuseIdentifier:ADEvaluateViewCellID];
        
    }
    return _userEvaluationListView;
}

#pragma mark - -- UICollectionView DataSource Function

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 12;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
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

#pragma mark - -- Item宽高

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {//评价标签
        return CGSizeMake(kScreenWidth, 110);
    }
    if ((indexPath.section > 0) && (indexPath.section < 12)) {//评论
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

#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeZero;
}

#pragma mark - foot宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    
    return CGSizeZero;
}

#pragma mark - -- UICollectionViewDelegateFlowLayout Function

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

#pragma mark - -- UICollectionView Delegate Function







@end
