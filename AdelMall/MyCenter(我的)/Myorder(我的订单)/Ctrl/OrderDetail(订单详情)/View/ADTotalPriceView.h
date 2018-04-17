//
//  ADTotalPriceView.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/2/25.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ADOrderBasicModel;
@interface ADTotalPriceView : UIView
/** 订单模型 */
@property(nonatomic,strong)ADOrderBasicModel *orderBasicModel;
@end
