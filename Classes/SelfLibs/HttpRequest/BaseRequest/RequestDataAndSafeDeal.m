//
//  RequestDataSafeDeal.m
//  EasyLife
//
//  Created by DingJian on 16/8/5.
//  Copyright © 2016年 CCJ. All rights reserved.
//

#import "RequestDataAndSafeDeal.h"
#import "HttpRequest.h"
#import "NSString+wrapper.h"
//#import "RequestTool+Login.h"
#import "NSError+httpError.h"
#import <RACSignal.h>
#import <UIAlertView+RACSignalSupport.h>
#import "AppDelegate.h"

@implementation RequestDataAndSafeDeal

//  请求数据方法，后台返回字典类型数据

+ (void)getDataDicWithUrl:(NSString *)url params:(NSDictionary *)dic requestCode:(NSString *)requestCode withSuccessBlock:(void (^)(id result))successBlock withFailBlock:(void (^)(NSString *msg))failBlock
{
    [HttpRequest requestWithURL:url requestCode:requestCode isFormData:NO params:dic httpMethod:RequsetTypePost completedBlock:^(id result) {
        
        successBlock(result);

    } failureBlock:^(id error) {
        
        failBlock(error);
    }];
}

//  使用字符串请求数据方法，后台返回字典类型数据

+ (void)getDataDicByStringWithUrl:(NSString *)url params:(NSDictionary *)dic requestCode:(NSString *)requestCode withSuccessBlock:(void (^)(id result))successBlock withFailBlock:(void (^)(NSString *msg))failBlock
{
    
    [HttpRequest requestWithURL:url isFormData:NO isSerialization:NO params:dic httpMethod:RequsetTypePost completedBlock:^(id result) {
        successBlock(result);
    } failureBlock:^(NSString *error) {
        failBlock(error);
    }];
}
@end
