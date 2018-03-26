//
//  RequestDataSafeDeal.h
//  EasyLife
//
//  Created by DingJian on 16/8/5.
//  Copyright © 2016年 CCJ. All rights reserved.
//

#import <Foundation/Foundation.h>


//后台返回状态
static NSString * const KResultStatus     =  @"resultStatus";

//后台返回数据
static NSString * const KResultData     =  @"resultData";

//后台返回失败提示
static NSString * const KResultMsg    =  @"resultMsg";

/*请求成功标识*/
static NSInteger const KRequestSuccessStatus    =  100;

@interface RequestDataAndSafeDeal : NSObject

/**
 *  请求数据方法，后台返回字典类型数据
 *
 *  @param url          url
 *  @param dic          请求param
 *  @param successBlock 成功回调
 *  @param failBlock    失败回调
 */
+ (void)getDataDicWithUrl:(NSString *)url params:(NSDictionary *)dic requestCode:(NSString *)requestCode withSuccessBlock:(void (^)(id result))successBlock withFailBlock:(void (^)(NSString *msg))failBlock;

//  使用字符串请求数据方法，后台返回字典类型数据

+ (void)getDataDicByStringWithUrl:(NSString *)url params:(NSDictionary *)dic requestCode:(NSString *)requestCode withSuccessBlock:(void (^)(id result))successBlock withFailBlock:(void (^)(NSString *msg))failBlock;
@end
