//
//  AppDelegate.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/1/29.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import "AppDelegate.h"
//#import "ADMyCenterViewController.h"
#import "DCTabBarController.h"
#import "ADLoginController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [self setUpRootVC]; //跟控制器判断
    
    [self.window makeKeyAndVisible];
    
//    [self setUpUserData]; //设置数据
    
    //    [self CDDMallVersionInformationFromPGY]; //蒲公英自动更新
    
//    [self setUpFixiOS11]; //适配IOS 11
    
    
    return YES;
}

#pragma mark - 根控制器
- (void)setUpRootVC
{
//    NSLog(@"当前版本 = %@，上一次版本 = %@",BUNDLE_VERSION,[DCAppVersionTool dc_GetLastOneAppVersion]);
//    if ([BUNDLE_VERSION isEqualToString:[DCAppVersionTool dc_GetLastOneAppVersion]]) {//判断是否当前版本号等于上一次储存版本号
//        //        NSLog(@"不更新版本");
        self.window.rootViewController = [[DCTabBarController alloc] init];
//    self.window.rootViewController = [[ADLoginController alloc] init];
//    }else{
        //        NSLog(@"更新版本");
//        [DCAppVersionTool dc_SaveNewAppVersion:BUNDLE_VERSION]; //储存当前版本号
    
        // 设置窗口的根控制器
//        ADMyCenterViewController *dcFVc = [[ADMyCenterViewController alloc] init];
//        [dcFVc setUpFeatureAttribute:^(NSArray *__autoreleasing *imageArray, UIColor *__autoreleasing *selColor, BOOL *showSkip, BOOL *showPageCount) {
//
//            *imageArray = @[@"guide1",@"guide2",@"guide3",@"guide4"];
//            *showPageCount = YES;
//            *showSkip = YES;
//        }];
//        self.window.rootViewController = dcFVc;
//    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - private methord

-(NSString *)showText:(NSString *)key
{
    
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    
    NSString *localizableName ;
    
    if ([currentLanguage isEqualToString:@"zh-Hans-CN"]) {
        
        localizableName = @"Localizable_cn";
        
    } else {
        
        localizableName = @"Localizable_en";
    }
    
    
    NSString *string  = NSLocalizedStringFromTable(key ,localizableName,  nil);
    return  string;
}

-(void)initRootUI {
    DCTabBarController *root = [[DCTabBarController alloc] init];
    self.window.rootViewController = root;
}


@end
