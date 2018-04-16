//
//  ADRecommendCell.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/2/28.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ADStarGoodsModel;
@interface ADRecommendCell : UICollectionViewCell
/** 商品详情点击回调 */
@property (nonatomic, copy) dispatch_block_t lookDetailBlock;
/* 推荐图片数组 */
@property (copy , nonatomic)NSArray *recommendArray;
//-(void)loadDataWithFloorID:(NSString *)floorID;
-(void)loadDataWithArray:(NSArray *)recommendArray and:(NSMutableArray<ADStarGoodsModel *> *)recommendItem;
@end
