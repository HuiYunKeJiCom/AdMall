//
//  AppDelegate.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/1/29.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property(strong,nonatomic) NSString *lan; //用来保存选择的语言
@property (strong, nonatomic) UIWindow *window;

//用来替代以往的 NSString 方法
-(NSString *)showText:(NSString *)key;

@end

