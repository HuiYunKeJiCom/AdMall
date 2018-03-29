//
//  DCGoodsCountDownCell.h
//  CDDMall
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCGoodsCountDownCell : UICollectionViewCell
/** 商品详情点击回调 */
@property (nonatomic, copy) dispatch_block_t lookDetailBlock;

@end
