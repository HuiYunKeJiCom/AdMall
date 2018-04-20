//
//  Net.h
//  AdelMall
//
//  Created by apple on 2018/4/16.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

//add by CTO
//重新写的网络接口

extern AFHTTPSessionManager *httpManager;

@interface Net : NSObject

+ (AFHTTPSessionManager *)httpManager;

+ (void)requestWithGet:(nullable id)params function:(nullable NSString *)function showHUD:(nullable NSString *)showHUD resultClass:(nullable Class)resultClass success:(nullable void (^)(id _Nullable resultObj))success failure:(nullable void (^)(NSError * _Nullable error))failure;

+ (void)requestWithPost:(nullable id)params function:(nullable NSString *)function showHUD:(nullable NSString *)showHUD resultClass:(nullable Class)resultClass success:(nullable void (^)(id _Nullable resultObj))success failure:(nullable void (^)(NSError * _Nullable error))failure;


@end
