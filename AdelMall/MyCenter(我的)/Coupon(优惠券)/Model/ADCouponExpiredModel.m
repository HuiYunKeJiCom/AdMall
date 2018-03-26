//
//  ADCouponExpiredModel.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/7.
//  Copyright © 2018年 Adel. All rights reserved.
//  优惠券已失效模型

#import "ADCouponExpiredModel.h"

@implementation ADCouponExpiredModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"idx": @"id"};
}
@end
