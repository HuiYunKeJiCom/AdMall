//
//  TDAppSid.m
//  Trade
//
//  Created by 张锐凌 on 2018/1/23.
//  Copyright © 2018年 FeiFan. All rights reserved.
//

#import "ADAppToken.h"

@implementation ADAppToken

// 获取保存的上一个版本信息
+ (NSString *)dc_GetLastOneAppToken{
    
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"app_token"];
}

// 保存新版本信息（偏好设置）
+ (void)dc_SaveNewAppToken:(NSString *)appToken {
    
    [[NSUserDefaults standardUserDefaults] setObject:appToken forKey:@"app_token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end
