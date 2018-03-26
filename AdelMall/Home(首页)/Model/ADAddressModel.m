//
//  ADAddressModel.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/20.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import "ADAddressModel.h"

@implementation ADAddressModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"idx": @"id"};
}
@end
