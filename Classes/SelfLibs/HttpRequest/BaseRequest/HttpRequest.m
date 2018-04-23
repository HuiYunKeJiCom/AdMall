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
        NSArray *tempArr = [fullUrl componentsSeparatedByString:@"login.htm"];
        fullUrl = [NSMutableString stringWithFormat:@"%@%@",tempArr[0],@"login.htm?"];
    }
    
    //获取广告数据
    if([fullUrl containsString:@"advert_invoke.htm"])
    {
        NSArray *tempArr = [fullUrl componentsSeparatedByString:@"advert_invoke.htm"];
        fullUrl = [NSMutableString stringWithFormat:@"%@%@",tempArr[0],@"advert_invoke.htm?"];
    }
    
    //获取明星产品列表数据
    if([fullUrl containsString:@"starGoods.htm"])
    {
        NSArray *tempArr = [fullUrl componentsSeparatedByString:@"starGoods.htm"];
        fullUrl = [NSMutableString stringWithFormat:@"%@%@",tempArr[0],@"starGoods.htm?"];
    }
    
    //获取为你推荐商品列表
    if([fullUrl containsString:@"recommend.htm"])
    {
        NSArray *tempArr = [fullUrl componentsSeparatedByString:@"recommend.htm"];
        fullUrl = [NSMutableString stringWithFormat:@"%@%@",tempArr[0],@"recommend.htm?"];
    }
    
    //获取首页楼层数据
    if([fullUrl containsString:@"floor.htm"])
    {
        NSArray *tempArr = [fullUrl componentsSeparatedByString:@"floor.htm"];
        fullUrl = [NSMutableString stringWithFormat:@"%@%@",tempArr[0],@"floor.htm?"];
    }
    
    //获取商品分类
    if([fullUrl containsString:@"category.htm"])
    {
        NSArray *tempArr = [fullUrl componentsSeparatedByString:@"category.htm"];
        fullUrl = [NSMutableString stringWithFormat:@"%@%@",tempArr[0],@"category.htm?"];
    }
    
    //获取指定楼层列表数据
    if([fullUrl containsString:@"floorDetail.htm"])
    {
        NSArray *tempArr = [fullUrl componentsSeparatedByString:@"floorDetail.htm"];
        fullUrl = [NSMutableString stringWithFormat:@"%@%@",tempArr[0],@"floorDetail.htm?"];
    }
    
    //获取商品详情数据
    if([fullUrl containsString:@"app/goods.htm"])
    {
        NSArray *tempArr = [fullUrl componentsSeparatedByString:@"app/goods.htm"];
        fullUrl = [NSMutableString stringWithFormat:@"%@%@",tempArr[0],@"app/goods.htm?"];
    }
    
    //获取商品列表
    if([fullUrl containsString:@"search.htm"])
    {
        NSArray *tempArr = [fullUrl componentsSeparatedByString:@"search.htm"];
        fullUrl = [NSMutableString stringWithFormat:@"%@%@",tempArr[0],@"search.htm?"];
    }
    
    //新增收货地址
    if([fullUrl containsString:@"saveAddress.htm"])
    {
        NSArray *tempArr = [fullUrl componentsSeparatedByString:@"saveAddress.htm"];
        fullUrl = [NSMutableString stringWithFormat:@"%@%@",tempArr[0],@"saveAddress.htm?"];
    }
    
    //设置默认收货地址
    if([fullUrl containsString:@"setDefaultAddress.htm"])
    {
        NSArray *tempArr = [fullUrl componentsSeparatedByString:@"setDefaultAddress.htm"];
        fullUrl = [NSMutableString stringWithFormat:@"%@%@",tempArr[0],@"setDefaultAddress.htm?"];
    }
    
    //获取省市区数据
    if([fullUrl containsString:@"getArea.htm"])
    {
        NSArray *tempArr = [fullUrl componentsSeparatedByString:@"getArea.htm"];
        fullUrl = [NSMutableString stringWithFormat:@"%@%@",tempArr[0],@"getArea.htm?"];
    }
    
    //获取已领取的优惠券列表
    if([fullUrl containsString:@"auth/getUserCoupon.htm"])
    {
        NSArray *tempArr = [fullUrl componentsSeparatedByString:@"auth/getUserCoupon.htm"];
        fullUrl = [NSMutableString stringWithFormat:@"%@%@",tempArr[0],@"auth/getUserCoupon.htm?"];
    }
    
    //领取优惠券
    if([fullUrl containsString:@"auth/receiveCoupon.htm"])
    {
        NSArray *tempArr = [fullUrl componentsSeparatedByString:@"auth/receiveCoupon.htm"];
        fullUrl = [NSMutableString stringWithFormat:@"%@%@",tempArr[0],@"auth/receiveCoupon.htm?"];
    }
    
    //添加购物车
    if([fullUrl containsString:@"auth/addCart.htm"])
    {
        NSArray *tempArr = [fullUrl componentsSeparatedByString:@"auth/addCart.htm"];
        fullUrl = [NSMutableString stringWithFormat:@"%@%@",tempArr[0],@"auth/addCart.htm?"];
    }
    
    //购物车商品移除
    if([fullUrl containsString:@"auth/removeCart.htm"])
    {
        NSArray *tempArr = [fullUrl componentsSeparatedByString:@"auth/removeCart.htm"];
        fullUrl = [NSMutableString stringWithFormat:@"%@%@",tempArr[0],@"auth/removeCart.htm?"];
    }
    
    //购物车商品数量增减
    if([fullUrl containsString:@"auth/addCartCount.htm"])
    {
        NSArray *tempArr = [fullUrl componentsSeparatedByString:@"auth/addCartCount.htm"];
        fullUrl = [NSMutableString stringWithFormat:@"%@%@",tempArr[0],@"auth/addCartCount.htm?"];
    }
    
    //获取购物车结算页数据
    if([fullUrl containsString:@"auth/cartAccount.htm"])
    {
        NSArray *tempArr = [fullUrl componentsSeparatedByString:@"auth/cartAccount.htm"];
        fullUrl = [NSMutableString stringWithFormat:@"%@%@",tempArr[0],@"auth/cartAccount.htm?"];
    }
    
    //获取选购商品各种运送方式的邮费
    if([fullUrl containsString:@"auth/getTransport.htm"])
    {
        NSArray *tempArr = [fullUrl componentsSeparatedByString:@"auth/getTransport.htm"];
        fullUrl = [NSMutableString stringWithFormat:@"%@%@",tempArr[0],@"auth/getTransport.htm?"];
    }
    
    //获取选购商品各种运送方式的邮费
    if([fullUrl containsString:@"auth/bulidOrder.htm"])
    {
        NSArray *tempArr = [fullUrl componentsSeparatedByString:@"auth/bulidOrder.htm"];
        fullUrl = [NSMutableString stringWithFormat:@"%@%@",tempArr[0],@"auth/bulidOrder.htm?"];
    }
    
    //订单列表
    if([fullUrl containsString:@"auth/orderList.htm"])
    {
        NSArray *tempArr = [fullUrl componentsSeparatedByString:@"auth/orderList.htm"];
        fullUrl = [NSMutableString stringWithFormat:@"%@%@",tempArr[0],@"auth/orderList.htm?"];
    }
    
    //订单详情
    if([fullUrl containsString:@"auth/orderDetail.htm"])
    {
        NSArray *tempArr = [fullUrl componentsSeparatedByString:@"auth/orderDetail.htm"];
        fullUrl = [NSMutableString stringWithFormat:@"%@%@",tempArr[0],@"auth/orderDetail.htm?"];
    }
    
    //买家取消订单
    if([fullUrl containsString:@"auth/cancelOrder.htm"])
    {
        NSArray *tempArr = [fullUrl componentsSeparatedByString:@"auth/cancelOrder.htm"];
        fullUrl = [NSMutableString stringWithFormat:@"%@%@",tempArr[0],@"auth/cancelOrder.htm?"];
    }
    
    //获取订单售后商品
    if([fullUrl containsString:@"auth/orderGoodsList.htm"])
    {
        NSArray *tempArr = [fullUrl componentsSeparatedByString:@"auth/orderGoodsList.htm"];
        fullUrl = [NSMutableString stringWithFormat:@"%@%@",tempArr[0],@"auth/orderGoodsList.htm?"];
    }
    
    //售后服务订单详情
    if([fullUrl containsString:@"auth/getAfterSalesDetail.htm"])
    {
        NSArray *tempArr = [fullUrl componentsSeparatedByString:@"auth/getAfterSalesDetail.htm"];
        fullUrl = [NSMutableString stringWithFormat:@"%@%@",tempArr[0],@"auth/getAfterSalesDetail.htm?"];
    }
    
    //评价晒单列表
    if([fullUrl containsString:@"auth/evaluationList.htm"])
    {
        NSArray *tempArr = [fullUrl componentsSeparatedByString:@"auth/evaluationList.htm"];
        fullUrl = [NSMutableString stringWithFormat:@"%@%@",tempArr[0],@"auth/evaluationList.htm?"];
    }
    
    //获取评价标签
    if([fullUrl containsString:@"auth/getEvaluateLabel.htm"])
    {
        NSArray *tempArr = [fullUrl componentsSeparatedByString:@"auth/getEvaluateLabel.htm"];
        fullUrl = [NSMutableString stringWithFormat:@"%@%@",tempArr[0],@"auth/getEvaluateLabel.htm?"];
    }
    
    //填写评价信息
    if([fullUrl containsString:@"auth/saveEvaluate.htm"])
    {
        NSArray *tempArr = [fullUrl componentsSeparatedByString:@"auth/saveEvaluate.htm"];
        fullUrl = [NSMutableString stringWithFormat:@"%@%@",tempArr[0],@"auth/saveEvaluate.htm?"];
    }
    
    //售后服务列表
    if([fullUrl containsString:@"auth/afterServiceList.htm"])
    {
        NSArray *tempArr = [fullUrl componentsSeparatedByString:@"auth/afterServiceList.htm"];
        fullUrl = [NSMutableString stringWithFormat:@"%@%@",tempArr[0],@"auth/afterServiceList.htm?"];
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
