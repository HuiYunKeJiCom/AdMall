//
//  ADStarGoodsCell.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/26.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ADStarGoodsModel;
@interface ADStarGoodsCell : UICollectionViewCell
/** 商品详情点击回调 */
//@property (nonatomic, copy) dispatch_block_t lookDetailBlock;
-(void)loadDataWithArray:(NSMutableArray<ADStarGoodsModel *> *)tempItem;
@end
