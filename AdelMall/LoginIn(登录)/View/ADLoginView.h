//
//  ADLoginView.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/29.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UseLoginType){
    UseLoginTypeLogin = 1,
    UseLoginTypePhone,
    UseLoginTypeRegister,
    UseLoginTypeForget,
    UseLoginTypeWXAuth,
    UseLoginTypeQQAuth,
    UseLoginTypeSinaAuth
};

@class ADLoginView;
@protocol ADLoginViewDelegate <NSObject>

- (void)loginView:(ADLoginView *)logView eventType:(UseLoginType)eventType;

- (void)loginView:(ADLoginView *)logView userName:(NSString *)userName pwd:(NSString *)pwd;


@end

@interface ADLoginView : UIView
@property (nonatomic, assign) id<ADLoginViewDelegate> delegate;
@end
