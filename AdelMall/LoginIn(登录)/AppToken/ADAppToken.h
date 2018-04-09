//
//  TDAppSid.h
//  Trade
//
//  Created by 张锐凌 on 2018/1/23.
//  Copyright © 2018年 FeiFan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADAppToken : NSObject

/**
 *  获取之前保存的版本
 *
 *  @return NSString类型的AppSid
 */
+ (NSString *)dc_GetLastOneAppToken;
/**
 *  保存新版本
 */
+ (void)dc_SaveNewAppToken:(NSString *)appToken;

@end
