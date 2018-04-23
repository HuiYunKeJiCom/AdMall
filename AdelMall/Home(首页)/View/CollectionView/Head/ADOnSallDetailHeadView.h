//
//  ADOnSallDetailHeadView.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/16.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ADFlashSaleModel,ADCountDownActivityModel;
@interface ADOnSallDetailHeadView : UICollectionReusableView
/** 抢购商品模型 */
@property(nonatomic,strong)ADFlashSaleModel *model;
/** 抢购活动模型 */
@property(nonatomic,strong)ADCountDownActivityModel *countDownModel;
@end
