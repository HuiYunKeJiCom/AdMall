//
//  ADStarGoodsSubclassCell.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/27.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ADGoodsModel;
@interface ADStarGoodsSubclassCell : UICollectionViewCell
/* 推荐商品数据 */
@property (strong , nonatomic)ADGoodsModel *model;
@end
