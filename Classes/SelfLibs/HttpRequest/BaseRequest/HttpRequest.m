//
//  HttpRequest.m
//  EasyLife
//
//  Created by DingJian on 16/3/23.
//  Copyright © 2016年 CCJ. All rights reserved.
//

#import "HttpRequest.h"
#import "NSString+wrapper.h"
#import "NSError+httpError.h"
#import "ADAppToken.h"

@interface HttpRequest()


@end

@implementation HttpRequest

+ (AFSecurityPolicy*)customSecurityPolicy
{
    //    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"ca" ofType:@"cer"];
    //    NSData * certData =[NSData dataWithContentsOfFile:cerPath];
    //    NSSet *certSet = [[NSSet alloc] initWithObjects:certData, nil];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = NO;
    //    NSSet * certSet = [[NSSet alloc] initWithObjects:certData, nil];
    //    [securityPolicy setPinnedCertificates:certSet];
    
    return securityPolicy;
}

+ (BOOL)isFullUrlWithOriginUrl:(NSString *)originUrl params:(NSDictionary *)params {
    
    BOOL isFullUrl = NO;
    if ([originUrl rangeOfString:@"https://"].location != NSNotFound || [originUrl rangeOfString:@"http://"].location != NSNotFound || [originUrl rangeOfString:@"www."].location != NSNotFound ) {
        isFullUrl = YES;
    }
    return isFullUrl;
}

+ (NSURLSessionDataTask *)requestWithURL:(NSString *)url
                             requestCode:(NSString *)requestCode
                              isFormData:(BOOL)isFormData
                                  params:(NSDictionary *)params
                              httpMethod:(HttpRequsetType)requsetType
                          completedBlock:(CompletionBlock)completedBlock
                            failureBlock:(FailureBlock)failureBlock
{
    NSMutableString *fullUrl;
    NSString *newParams = @"";
    //操作队列管理
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    if ([self isFullUrlWithOriginUrl:url params:params]) {
        fullUrl = [NSMutableString stringWithFormat:@"%@",url];
        newParams = [NSString queryStringFrom:params];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    } else {
        NSString *p = @"";
        if (params) {
            p = [NSString queryStringFrom:params];
        }
        fullUrl = [NSMutableString stringWithFormat:@"%@%@%@",Host,url,p];
        newParams = nil;
        manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    }
    
    //设置返回数据的解析方式
    NSURLSessionDataTask *requestOperation = nil;
    [manager setSecurityPolicy:[self customSecurityPolicy]];
    //设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutinterval"];
    manager.requestSerializer.timeoutInterval = 20.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutinterval"];
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringCacheData;
    [manager setSecurityPolicy:[self customSecurityPolicy]];
    //设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutinterval"];
    manager.requestSerializer.timeoutInterval = 20.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutinterval"];
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringCacheData;
    manager.responseSerializer.acceptableContentTypes  = [NSSet setWithObjects:@"application/xml",@"text/xml",@"text/plain",@"application/json",@"text/html",@"text/javascript",@"text/json",nil];
    
    NSString *myAppToken = [ADAppToken dc_GetLastOneAppToken];
//    NSLog(@"请求头myAppToken = %@",myAppToken);
    if(myAppToken)
    {
//        NSLog(@"添加请求头myAppToken = %@",myAppToken);
        [manager.requestSerializer setValue:myAppToken forHTTPHeaderField:@"app_token"];
    }
    
    NSLog(@"调用接口fullUrl = %@",fullUrl);
    
    //登录
    if([fullUrl containsString:@"login.htm"])
    {
        NSArray *tempArr = [fullUrl componentsSeparatedByString:@"userName"];
        fullUrl = tempArr[0];
    }
    
    //新增收货地址
    if([fullUrl containsString:@"saveAddress.htm"])
    {
        NSArray *tempArr = [fullUrl componentsSeparatedByString:@"mobile"];
        fullUrl = tempArr[0];
    }
    
    //设置默认收货地址
    if([fullUrl containsString:@"setDefaultAddress.htm"])
    {
        NSArray *tempArr = [fullUrl componentsSeparatedByString:@"addressId"];
        fullUrl = tempArr[0];
    }
    
    //新增/编辑收货地址
    if([fullUrl containsString:@"saveAddress.htm"])
    {
        NSArray *tempArr = [fullUrl componentsSeparatedByString:@"mobile"];
        fullUrl = tempArr[0];
    }
    
    //获取省市区数据
    if([fullUrl containsString:@"getArea.htm"])
    {
        NSArray *tempArr = [fullUrl componentsSeparatedByString:@"parentId"];
        fullUrl = tempArr[0];
    }
    
    //获取已领取的优惠券列表
    if([fullUrl containsString:@"auth/getUserCoupon.htm"])
    {
        NSArray *tempArr = [fullUrl componentsSeparatedByString:@"status"];
        fullUrl = tempArr[0];
    }
    
    //领取优惠券
    if([fullUrl containsString:@"auth/receiveCoupon.htm"])
    {
        NSArray *tempArr = [fullUrl componentsSeparatedByString:@"couponId"];
        fullUrl = tempArr[0];
    }
    
    
    if (requsetType == RequsetTypeGet) {
//        NSLog(@"get");
        requestOperation = [manager GET:fullUrl parameters:newParams progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (completedBlock) {
                NSString *errorMsg = [NSError checkErrorFromServer:nil response:responseObject];
                if (IsEmpty(errorMsg)) {
                    completedBlock(responseObject);
                } else {
                    failureBlock(errorMsg);
                }
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failureBlock) {
                failureBlock(k_requestErrorMessage);
            }
        }];
    }
    else if (requsetType == RequsetTypePost){
        if (!isFormData) {  //没有文件
            requestOperation = [manager POST:fullUrl parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                if (completedBlock) {
                    NSString *errorMsg = [NSError checkErrorFromServer:nil response:responseObject];
                    if (IsEmpty(errorMsg)) {
                        completedBlock(responseObject);
                    } else {
                        failureBlock(errorMsg);
                    }
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failureBlock) {
                    failureBlock(k_requestErrorMessage);
                }
            }];
        } else { //如果参数中有文件
            requestOperation = [manager POST:fullUrl parameters:newParams constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                //构造body,告诉AF是什么类型的文件，单独添加文件到form表单
                NSData *imgData = params[@"pic"];
                if (imgData) {
                    [formData appendPartWithFileData:imgData
                                                name:@"images"
                                            fileName:@"pic.jpg"
                                            mimeType:@"image/jpeg"];
                }
            } progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (completedBlock) {
                    NSString *errorMsg = [NSError checkErrorFromServer:nil response:responseObject];
                    if (IsEmpty(errorMsg)) {
                        completedBlock(responseObject);
                    } else {
                        failureBlock(errorMsg);
                    }
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failureBlock) {
                    failureBlock(k_requestErrorMessage);
                }
            }];
        }
    }
    
    NSMutableDictionary *dic = [HttpRequest shareDictionary];
    [dic setObject:requestOperation forKey:requestCode];
    return requestOperation;
}



 + (NSURLSessionDataTask *)uploadWithURL:(NSString *)url
                            requestCode:(NSString *)requestCode
                                 params:(NSDictionary *)params
                         completedBlock:(CompletionBlock)completedBlock
                           failureBlock:(FailureBlock)failureBlock
{
    NSMutableString *fullUrl = [NSMutableString stringWithFormat:@"%@%@",Host,url];
    NSDictionary *newParams = nil;
    
    //操作队列管理
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //设置返回数据的解析方式
    NSURLSessionDataTask *requestOperation = nil;
    [manager setSecurityPolicy:[self customSecurityPolicy]];
    //设置超时时间
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutinterval"];
    manager.requestSerializer.timeoutInterval = 20.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutinterval"];
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringCacheData;
    manager.responseSerializer.acceptableContentTypes  = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    
    requestOperation = [manager POST:fullUrl parameters:newParams constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        //构造body,告诉AF是什么类型的文件，单独添加文件到form表单
        UIImage *image = params[@"pic"];
        NSString *imageName = params[@"imageName"];
        NSData *imgData = UIImageJPEGRepresentation(image, 1);
        NSInteger dataLength = imgData.length;
        CGFloat rate = 1.0;
        if (dataLength >= 1000 * 1000 * 5) {
            rate = 1000.0 * 1000.0 * 5.0 / dataLength;
        } else if (dataLength >= 1000 * 1000 * 2 && dataLength < 1000 * 1000 * 5) {
            rate = 0.7;
        } else {
            rate = 1.0;
        }
        NSData *result = UIImageJPEGRepresentation(image, rate);
        
        if (result) {
            [formData appendPartWithFileData:result
                                        name:@"image"
                                    fileName:imageName
                                    mimeType:@"image/jpeg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (completedBlock) {
            NSString *errorMsg = nil;//[NSError checkErrorFromServer:nil response:responseObject];
            if (IsEmpty(errorMsg)) {
                completedBlock(responseObject);
            } else {
                failureBlock(errorMsg);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) {
            failureBlock(k_requestErrorMessage);
        }
    }];
    
    NSMutableDictionary *dic = [HttpRequest shareDictionary];
    [dic setObject:requestOperation forKey:requestCode];
    
    return requestOperation;
}



+(NSMutableDictionary *)shareDictionary
{
    static dispatch_once_t onceToken;
    static NSMutableDictionary *dic = nil;
    dispatch_once(&onceToken, ^{
        dic = [NSMutableDictionary dictionaryWithCapacity:1];
    });
    return dic;
}


+ (void)cancelRequestWithAPlCode:(NSString *)code
{
    NSMutableDictionary *dic = [HttpRequest shareDictionary];
    NSURLSessionDataTask *operation = dic[code];
    
    if ( operation ) {
        
        [operation cancel];
        [dic removeObjectForKey:code];
        
        operation = nil;
    }
}

+ (NSURLSessionDataTask *)requestWithURL:(NSString *)url
                              isFormData:(BOOL)isFormData
                         isSerialization:(BOOL)isSerialization
                                  params:(NSDictionary *)params
                              httpMethod:(HttpRequsetType)requsetType
                          completedBlock:(CompletionBlock)completedBlock
                            failureBlock:(FailureBlock)failureBlock
{
    NSMutableString *fullUrl;
    NSString *newParams = @"";
    
    //操作队列管理
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    
    if ([self isFullUrlWithOriginUrl:url params:params]) {
        fullUrl = [NSMutableString stringWithFormat:@"%@",url];
        newParams = [NSString queryStringFrom:params];
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    } else {
        //测试数据 url
        NSString *p = @"";
        if (params) {
            p = [NSString queryStringFrom:params];
        }
        NSLog(@"🐔🐔🐔🐔 %@",[NSMutableString stringWithFormat:@"%@%@%@",Host,url,p]);
        
        //用post
        fullUrl = [NSMutableString stringWithFormat:@"%@%@",Host,url];
        newParams = [NSString queryStringFrom:params];
        manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
        
    }
    
    //常开常闭
    if([fullUrl containsString:@"member/openClosed.do?"])
    {
        newParams = [NSString stringWithFormat:@"qrcode=%@",params[@"qrcode"]];
    }
    
    //设置返回数据的解析方式
    NSURLSessionDataTask *requestOperation = nil;
    [manager setSecurityPolicy:[self customSecurityPolicy]];
    //设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutinterval"];
    manager.requestSerializer.timeoutInterval = 20.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutinterval"];
//    manager.requestSerializer.exchangeParams = isSerialization;
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringCacheData;
    manager.responseSerializer.acceptableContentTypes  = [NSSet setWithObjects:@"application/xml",@"text/xml",@"text/plain",@"application/json",@"text/html",@"text/javascript",@"text/json",nil];
    
    if (requsetType == RequsetTypeGet) {
        requestOperation = [manager GET:fullUrl parameters:newParams progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (completedBlock) {
                NSString *errorMsg = [NSError checkErrorFromServer:nil response:responseObject];
                if (IsEmpty(errorMsg)) {
                    completedBlock(responseObject);
                } else {
                    failureBlock(errorMsg);
                }
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failureBlock) {
                failureBlock(k_requestErrorMessage);
            }
        }];
    }
    else if (requsetType == RequsetTypePost){
        if (!isFormData) {  //没有文件
            id parameters;
            if (isSerialization) {
                parameters = params;
            }else{
                parameters = newParams;
            }
            NSLog(@"saisaisai🐔🐔🐔🐔 %@",[NSMutableString stringWithFormat:@"%@%@%@",Host,url,parameters]);
            
            requestOperation = [manager POST:fullUrl parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (completedBlock) {
                    NSString *errorMsg = [NSError checkErrorFromServer:nil response:responseObject];
                    if (IsEmpty(errorMsg)) {
                        completedBlock(responseObject);
                    } else {
                        failureBlock(errorMsg);
                    }
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failureBlock) {
                    failureBlock(k_requestErrorMessage);
                }
            }];
        } else { //如果参数中有文件
            requestOperation = [manager POST:fullUrl parameters:newParams constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                //构造body,告诉AF是什么类型的文件，单独添加文件到form表单
                NSData *imgData = params[@"pic"];
                if (imgData) {
                    [formData appendPartWithFileData:imgData
                                                name:@"images"
                                            fileName:@"pic.jpg"
                                            mimeType:@"image/jpeg"];
                }
            } progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (completedBlock) {
                    NSString *errorMsg = [NSError checkErrorFromServer:nil response:responseObject];
                    if (IsEmpty(errorMsg)) {
                        completedBlock(responseObject);
                    } else {
                        failureBlock(errorMsg);
                    }
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failureBlock) {
                    failureBlock(k_requestErrorMessage);
                }
            }];
        }
    }
    
    //      NSMutableDictionary *dic = [HttpRequest shareDictionary];
    //      [dic setObject:requestOperation forKey:requestCode];
    return requestOperation;
}


@end
