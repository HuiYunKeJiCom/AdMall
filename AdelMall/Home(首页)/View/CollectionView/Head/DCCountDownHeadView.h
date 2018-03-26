//
//  DCCountDownHeadView.h
//  CDDMall
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//  商城-限时秒杀

#import <UIKit/UIKit.h>

@interface DCCountDownHeadView : UICollectionReusableView
/** 商品详情点击回调 */
@property (nonatomic, copy) dispatch_block_t lookAllBlock;

@end
