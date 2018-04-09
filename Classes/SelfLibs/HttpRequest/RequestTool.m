 //
//  RequestTool.m
//  EasyLife
//
//  Created by 朱鹏 on 16/5/27.
//  Copyright © 2016年 CCJ. All rights reserved.
//

#import "RequestTool.h"

/* 登录 */
static NSString * const kApiUrlLogin = @"login.htm?";
static NSString * const kRequestCodeLogin = @"kRequestLogin";

/* 获取广告轮播图数据 */
static NSString * const kApiUrlGetImagePathAD = @"advert_invoke.htm?";
static NSString * const kRequestCodeGetImagePathAD = @"kRequestGetImagePathAD";

/* 获取首页楼层数据 */
static NSString * const kApiUrlGetFloorData = @"floor.htm?";
static NSString * const kRequestCodeGetFloorData = @"kRequestGetFloorData";

/* 获取指定楼层列表数据 */
static NSString * const kApiUrlGetAppointFloorData = @"floorDetail.htm?";
static NSString * const kRequestCodeGetAppointFloorData = @"kRequestGetAppointFloorData";

/* 获取为你推荐商品列表 */
static NSString * const kApiUrlGetRecommendData = @"recommend.htm?";
static NSString * const kRequestCodeGetRecommendData = @"kRequestGetRecommendData";

/* 获取抢购活动列表数据 */
static NSString * const kApiUrlGetGoodsFlashSale = @"flashSale.htm?";
static NSString * const kRequestCodeGetGoodsFlashSale = @"kRequestGetGoodsFlashSale";

/* 获取明星产品列表数据 */
static NSString * const kApiUrlGetStarGoods = @"starGoods.htm?";
static NSString * const kRequestCodeGetStarGoods = @"kRequestGetStarGoods";

/* 获取商品分类 */
static NSString * const kApiUrlGetGoodsCategory = @"category.htm?";
static NSString * const kRequestCodeGetGoodsCategory = @"kRequestGetGoodsCategory";

/* 获取商品列表 */
static NSString * const kApiUrlGetGoodsList = @"search.htm?";
static NSString * const kRequestCodeGetGoodsList = @"kRequestGetGoodsList";

/* 获取抢购商品详情数据 */
static NSString * const kApiUrlGetFlashSaleDetail = @"flashSaleDetail.htm?";
static NSString * const kRequestCodeGetFlashSaleDetail = @"kRequestGetFlashSaleDetail";

/* 获取收货地址 */
static NSString * const kApiUrlGetAddress = @"auth/getAddress.htm?";
static NSString * const kRequestCodeGetAddress = @"kRequestGetAddress";

/* 新增/编辑收货地址 */
static NSString * const kApiUrlSaveAddress = @"auth/saveAddress.htm?";
static NSString * const kRequestCodeSaveAddress = @"kRequestSaveAddress";

/* 删除收货地址 */
static NSString * const kApiUrlDelAddress = @"auth/delAddress.htm?";
static NSString * const kRequestCodeDelAddress = @"kRequestDelAddress";

/* 设置默认收货地址 */
static NSString * const kApiUrlSetDefaultAddress = @"auth/setDefaultAddress.htm?";
static NSString * const kRequestCodeSetDefaultAddress = @"kRequestSetDefaultAddress";

/* 获取省市区数据 */
static NSString * const kApiUrlGetArea = @"getArea.htm?";
static NSString * const kRequestCodeGetArea = @"kRequestGetArea";

/* 获取所有省市区数据 */
static NSString * const kApiUrlGetAllArea = @"getAllArea.htm?";
static NSString * const kRequestCodeGetAllArea = @"kRequestGetAllArea";

/* 获取购物车列表 */
static NSString * const kApiUrlGetCartList = @"cartList.htm?";
static NSString * const kRequestCodeGetCartList = @"kRequestGetCartList";

/* 获取可领取的优惠券列表 */
static NSString * const kApiUrlGetCouponList = @"auth/couponList.htm?";
static NSString * const kRequestCodeGetCouponList = @"kRequestGetCouponList";

/* 获取已领取的优惠券列表 */
static NSString * const kApiUrlGetUserCoupon = @"auth/getUserCoupon.htm?";
static NSString * const kRequestCodeGetUserCoupon = @"kRequestGetUserCoupon";

/* 领取优惠券 */
static NSString * const kApiUrlGetReceiveCoupon = @"auth/receiveCoupon.htm?";
static NSString * const kRequestCodeGetReceiveCoupon = @"kRequestGetReceiveCoupon";

//检测系统版本更新
static NSString * const kLockDetectionSystem =  @"";

/*线上系统版本*/
static NSString * const kLockItunesAppSystem =  @"";

//检测系统版本更新
static NSString * const kLockDetectionSystemCode =  @"";

/*线上系统版本*/
static NSString * const kLockItunesAppSystemCode =  @"";


@interface RequestTool ()

@end

@implementation RequestTool


+ (RequestTool *)sharedInstance {
    
    static RequestTool *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+ (void)exitCleanCookies{
    
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL: [NSURL URLWithString:Host]];
    //NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    
    for (NSHTTPCookie * cookie in cookies){
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
    }
}


+ (void )login:(NSDictionary *)dic withSuccessBlock:(void (^)(NSDictionary *))successBlock withFailBlock:(void (^)(NSString *))failBlock {
    
    
    [RequestDataAndSafeDeal getDataDicWithUrl:kFFKartLogin params:dic requestCode:kLockDetectionSystemCode withSuccessBlock:^(NSDictionary *result) {
        successBlock(result);
        
    } withFailBlock:^(NSString *msg) {
        
        failBlock(msg);
        
    }];
}


#pragma mark =======================各个类私有请求方法==========================
#pragma mark --------- 检测系统版本更新
+(void)detectionSystem:(NSDictionary *)dic withSuccessBlock:(void (^)(NSDictionary *))successBlock withFailBlock:(void (^)(NSString *))failBlock {
    
    [RequestDataAndSafeDeal getDataDicWithUrl:kLockDetectionSystem params:dic requestCode:kLockDetectionSystemCode withSuccessBlock:^(NSDictionary *result) {
        successBlock(result);
        
    } withFailBlock:^(NSString *msg) {
        
        failBlock(msg);
        
    }];
}

#pragma mark --------- 获取线上系统版本信息
+(void)detectionItunesAppSystem:(NSDictionary *)dic withSuccessBlock:(void (^)(NSDictionary *))successBlock withFailBlock:(void (^)(NSString *))failBlock {
    
    
}




- (void)requestWebViewDataWithUrl:(NSString *)url
                     successBlock:(void (^)(NSData *))successBlock
                        failBlock:(void (^)(NSString *))failBlock {
    
    self.successBlock = successBlock;
    self.failBlock = failBlock;
    self.receivedData = [NSMutableData data];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection connectionWithRequest:request delegate:self];
    
}


#pragma mark -----NSURLSessionTaskDelegate-----

- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session {
}

- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(nullable NSError *)error {
}

- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler {
    
    if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]){//服务器信任证书

        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];//服务器信任证书
        if(completionHandler)
            completionHandler(NSURLSessionAuthChallengeUseCredential,credential);
    }
    NSLog(@"didReceiveChallenge");
//    completionHandler(NSURLSessionAuthChallengeUseCredential, [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust]);
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (self.receivedData) {
        self.successBlock(self.receivedData);
    } else {
        self.failBlock(k_requestErrorMessage);
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.receivedData appendData:data];
}

// 返回错误
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    self.failBlock([error description]);
}

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(nonnull NSURLProtectionSpace *)protectionSpace {
    
    return YES;
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    
    //判断是否是信任服务器证书
    if (challenge.protectionSpace.authenticationMethod ==NSURLAuthenticationMethodServerTrust)
        
    {
        //创建一个凭据对象
        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        //告诉服务器客户端信任证书
        [challenge.sender useCredential:credential forAuthenticationChallenge:challenge];
        
    }
}

/* 登录 */
+(void)loginWithDictionary:(NSDictionary *)paramsDic withSuccessBlock:(void (^)(NSDictionary *result))successBlock withFailBlock:(void (^)(NSString *msg))failBlock{
    [RequestDataAndSafeDeal getDataDicWithUrl:kApiUrlLogin params:paramsDic requestCode:kRequestCodeLogin withSuccessBlock:^(NSDictionary *result) {
        
        successBlock(result);
        
    } withFailBlock:^(NSString *msg) {
        
        failBlock(msg);
        
    }];
}

/* 获取广告轮播图数据 */
+(void)getImagePathForAD:(NSDictionary *)paramsDic withSuccessBlock:(void (^)(NSDictionary *result))successBlock withFailBlock:(void (^)(NSString *msg))failBlock{
    [RequestDataAndSafeDeal getDataDicWithUrl:kApiUrlGetImagePathAD params:paramsDic requestCode:kRequestCodeGetImagePathAD withSuccessBlock:^(NSDictionary *result) {
        
        successBlock(result);
        
    } withFailBlock:^(NSString *msg) {
        
        failBlock(msg);
        
    }];
}

/* 获取首页楼层数据 */
+(void)getFloorData:(NSDictionary *)paramsDic withSuccessBlock:(void (^)(NSDictionary *result))successBlock withFailBlock:(void (^)(NSString *msg))failBlock{
    [RequestDataAndSafeDeal getDataDicWithUrl:kApiUrlGetFloorData params:paramsDic requestCode:kRequestCodeGetFloorData withSuccessBlock:^(NSDictionary *result) {
        
        successBlock(result);
        
    } withFailBlock:^(NSString *msg) {
        
        failBlock(msg);
        
    }];
}

/* 获取指定楼层列表数据 */
+(void)getAppointFloorData:(NSDictionary *)paramsDic withSuccessBlock:(void (^)(NSDictionary *result))successBlock withFailBlock:(void (^)(NSString *msg))failBlock{
    [RequestDataAndSafeDeal getDataDicWithUrl:kApiUrlGetAppointFloorData params:paramsDic requestCode:kRequestCodeGetAppointFloorData withSuccessBlock:^(NSDictionary *result) {
        
        successBlock(result);
        
    } withFailBlock:^(NSString *msg) {
        
        failBlock(msg);
        
    }];
}

/* 获取为你推荐商品列表 */
+(void)getRecommendData:(NSDictionary *)paramsDic withSuccessBlock:(void (^)(NSDictionary *result))successBlock withFailBlock:(void (^)(NSString *msg))failBlock{
    [RequestDataAndSafeDeal getDataDicWithUrl:kApiUrlGetRecommendData params:paramsDic requestCode:kRequestCodeGetRecommendData withSuccessBlock:^(NSDictionary *result) {
        
        successBlock(result);
        
    } withFailBlock:^(NSString *msg) {
        
        failBlock(msg);
        
    }];
}



/* 获取抢购活动列表数据 */
+(void)getGoodsForFlashSale:(NSDictionary *)paramsDic withSuccessBlock:(void (^)(NSDictionary *result))successBlock withFailBlock:(void (^)(NSString *msg))failBlock{
    [RequestDataAndSafeDeal getDataDicWithUrl:kApiUrlGetGoodsFlashSale params:paramsDic requestCode:kRequestCodeGetGoodsFlashSale withSuccessBlock:^(NSDictionary *result) {
        
        successBlock(result);
        
    } withFailBlock:^(NSString *msg) {
        
        failBlock(msg);
        
    }];
}

/* 获取明星产品列表数据 */
+(void)getStarGoods:(NSDictionary *)paramsDic withSuccessBlock:(void (^)(NSDictionary *result))successBlock withFailBlock:(void (^)(NSString *msg))failBlock{
    [RequestDataAndSafeDeal getDataDicWithUrl:kApiUrlGetStarGoods params:paramsDic requestCode:kRequestCodeGetStarGoods withSuccessBlock:^(NSDictionary *result) {
        
        successBlock(result);
        
    } withFailBlock:^(NSString *msg) {
        
        failBlock(msg);
        
    }];
}

/* 获取商品分类 */
+(void)getGoodsCategory:(NSDictionary *)paramsDic withSuccessBlock:(void (^)(NSDictionary *result))successBlock withFailBlock:(void (^)(NSString *msg))failBlock{
    [RequestDataAndSafeDeal getDataDicWithUrl:kApiUrlGetGoodsCategory params:paramsDic requestCode:kRequestCodeGetGoodsCategory withSuccessBlock:^(NSDictionary *result) {
        
        successBlock(result);
        
    } withFailBlock:^(NSString *msg) {
        
        failBlock(msg);
        
    }];
}

/* 获取商品列表 */
+(void)getGoodsList:(NSDictionary *)paramsDic withSuccessBlock:(void (^)(NSDictionary *result))successBlock withFailBlock:(void (^)(NSString *msg))failBlock{
    [RequestDataAndSafeDeal getDataDicWithUrl:kApiUrlGetGoodsList params:paramsDic requestCode:kRequestCodeGetGoodsList withSuccessBlock:^(NSDictionary *result) {
        
        successBlock(result);
        
    } withFailBlock:^(NSString *msg) {
        
        failBlock(msg);
        
    }];
}

/* 获取抢购商品详情数据 */
+(void)getFlashSaleDetail:(NSDictionary *)paramsDic withSuccessBlock:(void (^)(NSDictionary *result))successBlock withFailBlock:(void (^)(NSString *msg))failBlock{
    [RequestDataAndSafeDeal getDataDicWithUrl:kApiUrlGetFlashSaleDetail params:paramsDic requestCode:kRequestCodeGetFlashSaleDetail withSuccessBlock:^(NSDictionary *result) {
        
        successBlock(result);
        
    } withFailBlock:^(NSString *msg) {
        
        failBlock(msg);
        
    }];
}

/* 获取收货地址 */
+(void)getAddress:(NSDictionary *)paramsDic withSuccessBlock:(void (^)(NSDictionary *result))successBlock withFailBlock:(void (^)(NSString *msg))failBlock{
    [RequestDataAndSafeDeal getDataDicWithUrl:kApiUrlGetAddress params:paramsDic requestCode:kRequestCodeGetAddress withSuccessBlock:^(NSDictionary *result) {
        
        successBlock(result);
        
    } withFailBlock:^(NSString *msg) {
        
        failBlock(msg);
        
    }];
}

/* 新增/编辑收货地址 */
+(void)saveAddress:(NSDictionary *)paramsDic withSuccessBlock:(void (^)(NSDictionary *result))successBlock withFailBlock:(void (^)(NSString *msg))failBlock{
    [RequestDataAndSafeDeal getDataDicWithUrl:kApiUrlSaveAddress params:paramsDic requestCode:kRequestCodeSaveAddress withSuccessBlock:^(NSDictionary *result) {
        
        successBlock(result);
        
    } withFailBlock:^(NSString *msg) {
        
        failBlock(msg);
        
    }];
}

/* 删除收货地址 */
+(void)delAddress:(NSDictionary *)paramsDic withSuccessBlock:(void (^)(NSDictionary *result))successBlock withFailBlock:(void (^)(NSString *msg))failBlock{
    [RequestDataAndSafeDeal getDataDicWithUrl:kApiUrlDelAddress params:paramsDic requestCode:kRequestCodeDelAddress withSuccessBlock:^(NSDictionary *result) {
        
        successBlock(result);
        
    } withFailBlock:^(NSString *msg) {
        
        failBlock(msg);
        
    }];
}

/* 设置默认收货地址 */
+(void)setDefaultAddress:(NSDictionary *)paramsDic withSuccessBlock:(void (^)(NSDictionary *result))successBlock withFailBlock:(void (^)(NSString *msg))failBlock{
    [RequestDataAndSafeDeal getDataDicWithUrl:kApiUrlSetDefaultAddress params:paramsDic requestCode:kRequestCodeSetDefaultAddress withSuccessBlock:^(NSDictionary *result) {
        
        successBlock(result);
        
    } withFailBlock:^(NSString *msg) {
        
        failBlock(msg);
        
    }];
}

/* 获取省市区数据 */
+(void)getArea:(NSDictionary *)paramsDic withSuccessBlock:(void (^)(NSDictionary *result))successBlock withFailBlock:(void (^)(NSString *msg))failBlock{
    [RequestDataAndSafeDeal getDataDicWithUrl:kApiUrlGetArea params:paramsDic requestCode:kRequestCodeGetArea withSuccessBlock:^(NSDictionary *result) {
        
        successBlock(result);
        
    } withFailBlock:^(NSString *msg) {
        
        failBlock(msg);
        
    }];
}

/* 获取所有省市区数据 */
+(void)getAllArea:(NSDictionary *)paramsDic withSuccessBlock:(void (^)(NSDictionary *result))successBlock withFailBlock:(void (^)(NSString *msg))failBlock{
    [RequestDataAndSafeDeal getDataDicWithUrl:kApiUrlGetAllArea params:paramsDic requestCode:kRequestCodeGetAllArea withSuccessBlock:^(NSDictionary *result) {
        
        successBlock(result);
        
    } withFailBlock:^(NSString *msg) {
        
        failBlock(msg);
        
    }];
}

/* 获取购物车列表数据 */
+(void)getCartList:(NSDictionary *)paramsDic withSuccessBlock:(void (^)(NSDictionary *result))successBlock withFailBlock:(void (^)(NSString *msg))failBlock{
    [RequestDataAndSafeDeal getDataDicWithUrl:kApiUrlGetCartList params:paramsDic requestCode:kRequestCodeGetCartList withSuccessBlock:^(NSDictionary *result) {
        
        successBlock(result);
        
    } withFailBlock:^(NSString *msg) {
        
        failBlock(msg);
        
    }];
}

/* 获取可领取的优惠券列表 */
+(void)getCouponList:(NSDictionary *)paramsDic withSuccessBlock:(void (^)(NSDictionary *result))successBlock withFailBlock:(void (^)(NSString *msg))failBlock{
    [RequestDataAndSafeDeal getDataDicWithUrl:kApiUrlGetCouponList params:paramsDic requestCode:kRequestCodeGetCouponList withSuccessBlock:^(NSDictionary *result) {
        
        successBlock(result);
        
    } withFailBlock:^(NSString *msg) {
        
        failBlock(msg);
        
    }];
}

/* 获取已领取的优惠券列表 */
+(void)getUserCoupon:(NSDictionary *)paramsDic withSuccessBlock:(void (^)(NSDictionary *result))successBlock withFailBlock:(void (^)(NSString *msg))failBlock{
    [RequestDataAndSafeDeal getDataDicWithUrl:kApiUrlGetUserCoupon params:paramsDic requestCode:kRequestCodeGetUserCoupon withSuccessBlock:^(NSDictionary *result) {
        
        successBlock(result);
        
    } withFailBlock:^(NSString *msg) {
        
        failBlock(msg);
        
    }];
}

/* 领取优惠券 */
+(void)receiveCoupon:(NSDictionary *)paramsDic withSuccessBlock:(void (^)(NSDictionary *result))successBlock withFailBlock:(void (^)(NSString *msg))failBlock{
    [RequestDataAndSafeDeal getDataDicWithUrl:kApiUrlGetReceiveCoupon params:paramsDic requestCode:kRequestCodeGetReceiveCoupon withSuccessBlock:^(NSDictionary *result) {
        
        successBlock(result);
        
    } withFailBlock:^(NSString *msg) {
        
        failBlock(msg);
        
    }];
}

@end
