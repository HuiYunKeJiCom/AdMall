//
//  ADGoodsDetailModel.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/4/10.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import "ADGoodsDetailModel.h"
#import "ADPropertyModel.h"

@implementation ADGoodsDetailModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"idx": @"id"};
}

+(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"goods_property" : @"ADPropertyModel"
             };
}
@end
