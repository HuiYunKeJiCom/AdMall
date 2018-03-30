//
//  RequestTool.h
//  EasyLife
//
//  Created by 朱鹏 on 16/5/27.
//  Copyright © 2016年 CCJ. All rights reserved.
//

#import "BaseViewCtrl.h"
#import "RequestDataAndSafeDeal.h"



typedef void (^SuccessBlock)(id);
typedef void (^FailBlock)(NSString *);

@interface RequestTool : NSObject<NSURLSessionDelegate>

@property(nonatomic, strong) NSMutableData *receivedData;
@property (nonatomic, copy) SuccessBlock successBlock;
@property (nonatomic, copy) FailBlock failBlock;

+ (RequestTool *)sharedInstance;

#pragma mark --------- 退出时清楚本地Cookie

+ (void)exitCleanCookies;

#pragma mark --------- 登录
+ (void )login:(NSDictionary *)dic withSuccessBlock:(void (^)(NSDictionary *))successBlock withFailBlock:(void (^)(NSString *))failBlock;

#pragma mark --------- 检测系统版本更新
+(void)detectionSystem:(NSDictionary *)dic withSuccessBlock:(void (^)(NSDictionary *))successBlock withFailBlock:(void (^)(NSString *))failBlock;


#pragma mark --------- 获取线上系统版本信息
+(void)detectionItunesAppSystem:(NSDictionary *)dic withSuccessBlock:(void (^)(NSDictionary *))successBlock withFailBlock:(void (^)(NSString *))failBlock;




- (void)requestWebViewDataWithUrl:(NSString *)url
                     successBlock:(void (^)(NSData *data))successBlock
                        failBlock:(void (^)(NSString *msg))failBlock;

/* 登录 */
+(void)loginWithDictionary:(NSDictionary *)paramsDic withSuccessBlock:(void (^)(NSDictionary *result))successBlock withFailBlock:(void (^)(NSString *msg))failBlock;

/* 获取广告轮播图数据 */
+(void)getImagePathForAD:(NSDictionary *)paramsDic withSuccessBlock:(void (^)(NSDictionary *result))successBlock withFailBlock:(void (^)(NSString *msg))failBlock;

/* 获取首页楼层数据 */
+(void)getFloorData:(NSDictionary *)paramsDic withSuccessBlock:(void (^)(NSDictionary *result))successBlock withFailBlock:(void (^)(NSString *msg))failBlock;

/* 获取指定楼层列表数据 */
+(void)getAppointFloorData:(NSDictionary *)paramsDic withSuccessBlock:(void (^)(NSDictionary *result))successBlock withFailBlock:(void (^)(NSString *msg))failBlock;

/* 获取为你推荐商品列表 */
+(void)getRecommendData:(NSDictionary *)paramsDic withSuccessBlock:(void (^)(NSDictionary *result))successBlock withFailBlock:(void (^)(NSString *msg))failBlock;

/* 获取抢购活动列表数据 */
+(void)getGoodsForFlashSale:(NSDictionary *)paramsDic withSuccessBlock:(void (^)(NSDictionary *result))successBlock withFailBlock:(void (^)(NSString *msg))failBlock;

/* 获取明星产品列表数据 */
+(void)getStarGoods:(NSDictionary *)paramsDic withSuccessBlock:(void (^)(NSDictionary *result))successBlock withFailBlock:(void (^)(NSString *msg))failBlock;

/* 获取商品分类 */
+(void)getGoodsCategory:(NSDictionary *)paramsDic withSuccessBlock:(void (^)(NSDictionary *result))successBlock withFailBlock:(void (^)(NSString *msg))failBlock;

/* 获取商品列表 */
+(void)getGoodsList:(NSDictionary *)paramsDic withSuccessBlock:(void (^)(NSDictionary *result))successBlock withFailBlock:(void (^)(NSString *msg))failBlock;

/* 获取抢购商品详情数据 */
+(void)getFlashSaleDetail:(NSDictionary *)paramsDic withSuccessBlock:(void (^)(NSDictionary *result))successBlock withFailBlock:(void (^)(NSString *msg))failBlock;
@end
