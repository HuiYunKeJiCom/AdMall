//
//  ADUseCouponModel.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/7.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADUseCouponModel : NSObject
/** id */
@property (nonatomic, copy) NSString      *idx;
/** 优惠名称 */
@property (nonatomic, copy) NSString      *couponName;
/** 优惠价格 */
@property (nonatomic, copy) NSString      *couponPrice;
/** 优惠系列 */
@property (nonatomic, copy) NSString      *couponSeries;
/** 优惠券使用时间 */
@property (nonatomic, copy) NSString      *couponUseTime;
@end
