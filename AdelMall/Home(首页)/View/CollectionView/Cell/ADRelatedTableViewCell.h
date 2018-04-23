//
//  ADRelatedTableViewCell.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/20.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ADGoodsModel;
@interface ADRelatedTableViewCell : UICollectionViewCell
/* openView 点击回调 */
@property (nonatomic, copy) dispatch_block_t openSpecViewClickBlock;
@property (nonatomic, copy) dispatch_block_t imageViewBtnClickBlock;
/* 相关商品数据数组 */
@property (strong , nonatomic)NSMutableArray<ADGoodsModel *> *relatedGoodsItem;
@end
