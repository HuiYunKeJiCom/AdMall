//
//  ADGoodsModel.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/2/8.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import "ADGoodsModel.h"

@implementation ADGoodsModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"idx": @"id",@"goodsName":@"goods_name",@"type":@"goods_choice_type",@"price":@"goods_price"};
}
@end
