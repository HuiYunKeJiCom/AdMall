//
//  ADGoodsTempModel.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/26.
//  Copyright © 2018年 Adel. All rights reserved.
//  商品模型

#import "ADStarGoodsModel.h"

@implementation ADStarGoodsModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"idx": @"id"};
}
@end
