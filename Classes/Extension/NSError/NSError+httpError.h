//
//  NSError+httpError.h
//  Kart
//
//  Created by 朱鹏 on 17/3/10.
//  Copyright © 2017年 ffzx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (httpError)

+ (UIAlertView *)visibleAlter;

/**
 *  统一处理服务端错误
 *
 *  @param error            后台生成的error,优先处理
 *  @param output         后台返回可能包含自定义的errorDescription,当error == nil 时处理
 */
+ (NSString *)checkErrorFromServer:(NSError *)error response:(id)output;

/**
 *  处理登陆错误
 */
+ (NSString *)errorStrWithError:(NSError *)error;


/**
 *  显示错误信息
 *  @param time           延迟隐藏时间
 */
+(void)showHudWithView:(UIView *)view Text:(NSString *)text delayTime:(NSTimeInterval)time;


/**
 *  微信授权错误提示
 */
+ (NSString *)errorWXAuthError:(int)errCode;
@end
