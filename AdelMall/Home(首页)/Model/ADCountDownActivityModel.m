//
//  ADCountDownActivityModel.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/27.
//  Copyright © 2018年 Adel. All rights reserved.
//  抢购活动模型

#import "ADCountDownActivityModel.h"

@implementation ADCountDownActivityModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"idx": @"id"};
}
@end
