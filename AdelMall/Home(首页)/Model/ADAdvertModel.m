//
//  ADAdvertModel.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/28.
//  Copyright © 2018年 Adel. All rights reserved.
//  广告数据模型

#import "ADAdvertModel.h"

@implementation ADAdvertModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"idx": @"id"};
}
@end
