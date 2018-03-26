//
//  ADOrderBasicModel.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/2/9.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import "ADOrderBasicModel.h"

@implementation ADOrderBasicModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"idx": @"id"};
}
@end
