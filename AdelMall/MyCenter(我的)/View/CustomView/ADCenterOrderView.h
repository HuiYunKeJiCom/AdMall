//
//  ADCenterOrderCellTableViewCell.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/1/29.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ADCenterOrderViewDelegate <NSObject>

@optional

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@class DCGridItem;

@interface ADCenterOrderView : UIView

/* 数据 */
@property (strong , nonatomic)NSMutableArray<DCGridItem *> *orderItemArray;
@property (assign,nonatomic) id<ADCenterOrderViewDelegate> tbDelegate;
@end
