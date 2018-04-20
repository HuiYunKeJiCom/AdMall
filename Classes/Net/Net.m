//
//  Net.m
//  AdelMall
//
//  Created by apple on 2018/4/16.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import "Net.h"

AFHTTPSessionManager *httpManager = nil;

@implementation Net

+ (void)initialize{
    [super initialize];
    [self httpManager];
}



+ (AFHTTPSessionManager *)httpManager{
    if (!httpManager) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            httpManager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:@"http://2008503qw3.51mypc.cn"]];
            httpManager.responseSerializer = [AFJSONResponseSerializer serializer];
            httpManager.requestSerializer = [AFJSONRequestSerializer serializer];
        });
    }
    return httpManager;
}

+ (void)requestWithGet:(nullable NSDictionary *)params function:(NSString *)function showHUD:(nullable NSString *)showHUD success:(nullable void (^)(NSDictionary * _Nullable responsObj))success failure:(nullable void (^)(NSError * _Nullable error))failure{
    
    
}

+ (void)requestWithPost:(nullable NSDictionary *)params function:(NSString *)function showHUD:(nullable NSString *)showHUD success:(nullable void (^)(NSDictionary * _Nullable responsObj))success failure:(nullable void (^)(NSError * _Nullable error))failure{
    
    
}

+ (void)requestWithGet:(nullable id)params function:(nullable NSString *)function showHUD:(nullable NSString *)showHUD resultClass:(nullable Class)resultClass success:(nullable void (^)(id _Nullable resultObj))success failure:(nullable void (^)(NSError * _Nullable error))failure{
    NSDictionary *requestParams = nil;
    if (params == nil || [params isKindOfClass:[NSDictionary class]]) {
        requestParams = params;
    }else{
        requestParams = [params yy_modelToJSONObject];
    }
    [self requestWithGet:params function:function showHUD:showHUD success:^(NSDictionary * _Nullable responseObject) {
        id resultObj = nil;
        if (resultClass == Nil || resultClass == [NSDictionary class] || resultClass == [NSArray class]) {
            resultObj = responseObject;
        }else{
            resultObj = [resultClass yy_modelWithDictionary:responseObject];
        }
        success(resultObj);
    } failure:failure];
}

+ (void)requestWithPost:(nullable id)params function:(nullable NSString *)function showHUD:(nullable NSString *)showHUD resultClass:(nullable Class)resultClass success:(nullable void (^)(id _Nullable resultObj))success failure:(nullable void (^)(NSError * _Nullable error))failure{
    NSDictionary *requestParams = nil;
    if (params == nil || [params isKindOfClass:[NSDictionary class]]) {
        requestParams = params;
    }else{
        requestParams = [params yy_modelToJSONObject];
    }
    [self requestWithPost:params function:function showHUD:showHUD success:^(NSDictionary * _Nullable responseObject) {
        id resultObj = nil;
        if (resultClass == Nil || resultClass == [NSDictionary class] || resultClass == [NSArray class]) {
            resultObj = responseObject;
        }else{
            resultObj = [resultClass yy_modelWithDictionary:responseObject];
        }
        success(resultObj);
    } failure:failure];
}


@end
