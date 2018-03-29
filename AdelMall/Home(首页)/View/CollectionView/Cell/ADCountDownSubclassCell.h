//
//  ADCountDownSubclassCell.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/27.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ADCountDownGoodsModel;
@interface ADCountDownSubclassCell : UICollectionViewCell
/* 推荐商品数据 */
@property (strong , nonatomic)ADCountDownGoodsModel *model;
@end
