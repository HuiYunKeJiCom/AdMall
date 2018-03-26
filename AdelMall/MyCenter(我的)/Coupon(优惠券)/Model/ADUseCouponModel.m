//
//  ADUseCouponModel.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/7.
//  Copyright © 2018年 Adel. All rights reserved.
//  优惠券使用记录模型

#import "ADUseCouponModel.h"

@implementation ADUseCouponModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"idx": @"id"};
}
@end
