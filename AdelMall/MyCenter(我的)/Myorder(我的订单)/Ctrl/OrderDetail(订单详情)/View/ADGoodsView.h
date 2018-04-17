//
//  ADGoodsView.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/2/9.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ADOrderModel;
@interface ADGoodsView : UIView
/** 商品模型 */
@property(nonatomic,strong)ADOrderModel *goodsOrderModel;
@end
