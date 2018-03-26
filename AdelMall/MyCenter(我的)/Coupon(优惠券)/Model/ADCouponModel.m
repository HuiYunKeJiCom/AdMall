//
//  ADCouponModel.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/6.
//  Copyright © 2018年 Adel. All rights reserved.
//  优惠券未使用模型

#import "ADCouponModel.h"

@implementation ADCouponModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"idx": @"id"};
}
@end
