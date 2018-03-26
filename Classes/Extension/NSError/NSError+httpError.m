//
//  NSError+httpError.m
//  Kart
//
//  Created by 朱鹏 on 16/2/23.
//  Copyright © 2017年 FFZX. All rights reserved.
//

#import "NSError+httpError.h"
#import <RACSignal.h>
#import <UIAlertView+RACSignalSupport.h>
#import "AppDelegate.h"

@implementation NSError (httpError)

+ (UIAlertView *)visibleAlter {
    
    static UIAlertView *visibleAlter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        visibleAlter = [[UIAlertView alloc] initWithTitle:nil message:KLocalizableStr(@"网络异常，请稍后重试") delegate:self cancelButtonTitle:nil otherButtonTitles:KLocalizableStr(@"确定"), nil];
    });
    
    return visibleAlter;
}

+ (UIAlertView *)visibleUpgradeAlter {
    
    static UIAlertView *visibleUpgradeAlter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *message = [NSString stringWithFormat:@"app%@",KLocalizableStr(@"版本不支持该功能，请尽快升级")];
        visibleUpgradeAlter = [[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:KLocalizableStr(@"取消") otherButtonTitles:KLocalizableStr(@"升级"), nil];
    });

    return visibleUpgradeAlter;
}

+(void)showHudWithView:(UIView *)view Text:(NSString *)text delayTime:(NSTimeInterval)time
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (view) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.detailsLabelText = text;
            [hud hide:YES afterDelay:time];
        }
    });
}

+ (NSString *)checkErrorFromServer:(NSError *)error response:(id)output {
    NSString *errorMessage = @"";
    NSString *errorDescription = nil;
    NSString *errorCode = @"";
    NSLog(@"后台返回信息  == %@",output);
    if ([output respondsToSelector:@selector(valueForKey:)]
        && !IsEmpty([output valueForKey:@"status"])) {
        
        if ([[output valueForKey:@"status"] isKindOfClass:[NSNumber class]] || [[output valueForKey:@"status"] isKindOfClass:[NSString class]]) {
            
            
            NSInteger statu = [[output valueForKey:@"status"] integerValue];
//            NSLog(@"错误码 = %lu",statu);
//            errorMessage = KLocalizableStr([output valueForKey:@"message"]);
            
            switch (statu) {
                case 10000:{
                }
                    break;
                case 10001:{
                   errorMessage = KLocalizableStr(@"请输入合法参数");
                }
                    break;
                case 10002:{
                    errorMessage = KLocalizableStr(@"验证码已失效，请重新获取");
                }
                    break;
                case 10003:{
                    errorMessage = KLocalizableStr(@"验证码输入不正确，请核对后输入");
                }
                    break;
                case 10004:{
                    errorMessage = KLocalizableStr(@"手机号码已经被注册");
                }
                    break;
                case 10005:{
                    errorMessage = KLocalizableStr(@"推荐人不能是自己");
                }
                    break;
                case 10006:{
                    errorMessage = KLocalizableStr(@"推荐人不是会员，请核对后重新输入");
                }
                    break;
                case 10007:{
                    errorMessage = KLocalizableStr(@"未知错误");
                }
                    break;
                case 10008:{
                    errorMessage = KLocalizableStr(@"用户不存在，请核对后输入");
                }
                    break;
                case 10009:{
                    errorMessage = KLocalizableStr(@"用户名或密码不正确，请再次输入");
                }
                    break;
                case 10010:{
                    errorMessage = KLocalizableStr(@"你的账户出现异常，请联系客服人员解决");
                }
                    break;
                case 10011:{
                    errorMessage = KLocalizableStr(@"暂无数据");
                }
                    break;
                case 10012:{
                    errorMessage = @"操作出错啦";
                }
                    break;
                case 10013:{
                    errorMessage = KLocalizableStr(@"验证码发送失败");
                }
                    break;
                case 10014:{
                    errorMessage = KLocalizableStr(@"该用户已经存在，如果忘记密码，请找回密码");
                }
                    break;
                case 10015:{
                    errorMessage = KLocalizableStr(@"原密码输入错误");
                }
                    break;
                case 10017:{
                    errorMessage = KLocalizableStr(@"原用户名输入错误");
                }
                    break;
                case 10018:{
                    errorMessage = KLocalizableStr(@"原手机号输入错误");
                }
                    break;
                case 10019:{
                    errorMessage = KLocalizableStr(@"酒店有授权");
                }
                    break;
                case 10020:{
                    errorMessage = KLocalizableStr(@"用户名已存在，请重新输入");
                }
                    break;
                case 100015:{
                    errorMessage = KLocalizableStr(@"第三方登录失败");
                }
                    break;
                case 1000151:{
                    errorMessage = KLocalizableStr(@"第三方登录参数异常");
                }
                    break;
                case 100016:{
                    errorMessage = KLocalizableStr(@"第三方登录绑定失败");
                }
                    break;
                case 1000161:{
                    errorMessage = KLocalizableStr(@"第三方登录参数异常");
                }
                    break;
                case 100041:{
                    errorMessage = KLocalizableStr(@"绑定手机号失败");
                }
                    break;
                case 100017:{
                    errorMessage = KLocalizableStr(@"入住时间未到");
                }
                    break;
                case 100018:{
                    errorMessage = KLocalizableStr(@"已过期");
                }
                    break;
                case 100019:{
                    errorMessage = KLocalizableStr(@"验证码失效");
                }
                    break;
                case 100029:{
                    errorMessage = KLocalizableStr(@"没有酒店Id");
                }
                    break;
                case 100039:{
                    errorMessage = KLocalizableStr(@"酒店没有授权，绑定失败");
                }
                    break;
                case 100049:{
                    errorMessage = KLocalizableStr(@"查询不到此酒店");
                }
                    break;
                default:
                    errorMessage = k_requestErrorMessage;
                    break;
            }
            
            errorCode = [NSString stringWithFormat:@"%@",[output valueForKey:@"status"]];
        }

    } else if (error.localizedDescription.length > 0) {
        errorCode = [NSString stringWithFormat:@"%ld",(long)error.code];
        errorDescription = error.localizedDescription;
        errorMessage = [NSError errorStrWithError:error];
#if DEBUG
        errorMessage = error.localizedDescription;
#endif
    } else {
        return nil;
    }
    
//    DDLogWarn(@"服务端报错: %@",errorMessage);
    
    
//    if ([errorCode isEqualToString:@"-1"] || [errorCode isEqualToString:@"-2"]) {
//        UIAlertView *alertView = [NSError visibleAlter];
//        [alertView setMessage:errorMessage];
//        
//        [[[alertView rac_buttonClickedSignal] take:1] subscribeNext:^(NSNumber *indexNumber) {
//            //退出登录
//            [kAppDelegate userExit];
//        }];
//        
//        if (!alertView.visible) {
//            [alertView show];
//        }
//    }

    return errorMessage;
}

+ (NSString *)errorStrWithError:(NSError *)error {
    
    NSString *erroStr = error.localizedDescription;
    NSString *showErrorStr = KLocalizableStr(@"内部服务器错误");

    if ([erroStr rangeOfString:@"400"].length > 0 ||
        [erroStr rangeOfString:@"401"].length > 0) {
        showErrorStr = KLocalizableStr(@"内部服务器错误");
    } else if ([erroStr rangeOfString:@"403"].length > 0){
        
    } else if ([erroStr rangeOfString:@"404"].length > 0){
        
    } else if ([erroStr rangeOfString:@"201"].length > 0){
        
    }
    
//    UIAlertView *alertView = [NSError visibleAlter];
//    [alertView setMessage:showErrorStr];
//    
//    if (!alertView.visible) {
//        [alertView show];
//    }
    
    return showErrorStr;
}

+ (NSString *)errorWXAuthError:(int)errCode {
    
    switch (errCode) {
        case 0:{
            return KLocalizableStr(@"用户同意");
        }
            break;
        case -2:{
            return KLocalizableStr(@"用户拒绝授权");
        }
            break;
        case -4:{
            return KLocalizableStr(@"用户取消");
        }
            break;
        default:
            break;
    }
    
    return k_requestErrorMessage;
}


@end
