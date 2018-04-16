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

/* 获取商品详情数据 */
+(void)getGoods:(NSDictionary *)paramsDic withSuccessBlock:(void (^)(NSDictionary *result))successBlock withFailBlock:(void (^)(NSString *msg))failBlock;

/* 获取商品分类 */
+(void)getGoodsCategory:(NSDictionary *)paramsDic withSuccessBlock:(void (^)(NSDictionary *result))successBlock withFailBlock:(void (^)(NSString *msg))failBlock;

/* 获取商品列表 */
+(void)getGoodsList:(NSDictionary *)paramsDic withSuccessBlock:(void (^)(NSDictionary *result))successBlock withFailBlock:(void (^)(NSString *msg))failBlock;

/* 获取抢购商品详情数据 */
+(void)getFlashSaleDetail:(NSDictionary *)paramsDic withSuccessBlock:(void (^)(NSDictionary *result))successBlock withFailBlock:(void (^)(NSString *msg))failBlock;

/* 获取收货地址 */
+(void)getAddress:(NSDictionary *)paramsDic withSuccessBlock:(void (^)(NSDictionary *result))successBlock withFailBlock:(void (^)(NSString *msg))failBlock;

/* 新增/编辑收货地址 */
+(void)saveAddress:(NSDictionary *)paramsDic withSuccessBlock:(void (^)(NSDictionary *result))successBlock withFailBlock:(void (^)(NSString *msg))failBlock;

/* 删除收货地址 */
+(void)delAddress:(NSDictionary *)paramsDic withSuccessBlock:(void (^)(NSDictionary *result))successBlock withFailBlock:(void (^)(NSString *msg))failBlock;

/* 设置默认收货地址 */
+(void)setDefaultAddress:(NSDictionary *)paramsDic withSuccessBlock:(void (^)(NSDictionary *result))successBlock withFailBlock:(void (^)(NSString *msg))failBlock;

/* 获取省市区数据 */
+(void)getArea:(NSDictionary *)paramsDic withSuccessBlock:(void (^)(NSDictionary *result))successBlock withFailBlock:(void (^)(NSString *msg))failBlock;

/* 获取所有省市区数据 */
+(void)getAllArea:(NSDictionary *)paramsDic withSuccessBlock:(void (^)(NSDictionary *result))successBlock withFailBlock:(void (^)(NSString *msg))failBlock;

/* 获取购物车列表 */
+(void)getCartList:(NSDictionary *)paramsDic withSuccessBlock:(void (^)(NSDictionary *result))successBlock withFailBlock:(void (^)(NSString *msg))failBlock;

/* 添加到购物车 */
+(void)addCart:(NSDictionary *)paramsDic withSuccessBlock:(void (^)(NSDictionary *result))successBlock withFailBlock:(void (^)(NSString *msg))failBlock;

/* 购物车商品移除 */
+(void)removeCart:(NSDictionary *)paramsDic withSuccessBlock:(void (^)(NSDictionary *result))successBlock withFailBlock:(void (^)(NSString *msg))failBlock;

/* 购物车商品数量增减 */
+(void)changeCartCount:(NSDictionary *)paramsDic withSuccessBlock:(void (^)(NSDictionary *result))successBlock withFailBlock:(void (^)(NSString *msg))failBlock;

/* 获取购物车结算页数据 */
+(void)getCartAccount:(NSDictionary *)paramsDic withSuccessBlock:(void (^)(NSDictionary *result))successBlock withFailBlock:(void (^)(NSString *msg))failBlock;

/* 获取选购商品各种运送方式的邮费 */
+(void)getTransport:(NSDictionary *)paramsDic withSuccessBlock:(void (^)(NSDictionary *result))successBlock withFailBlock:(void (^)(NSString *msg))failBlock;

/* 下单【生成订单】 */
+(void)bulidOrder:(NSDictionary *)paramsDic withSuccessBlock:(void (^)(NSDictionary *result))successBlock withFailBlock:(void (^)(NSString *msg))failBlock;

/* 订单列表 */
+(void)getOrderList:(NSDictionary *)paramsDic withSuccessBlock:(void (^)(NSDictionary *result))successBlock withFailBlock:(void (^)(NSString *msg))failBlock;

/* 订单详情 */
+(void)getOrderDetail:(NSDictionary *)paramsDic withSuccessBlock:(void (^)(NSDictionary *result))successBlock withFailBlock:(void (^)(NSString *msg))failBlock;

/* 获取当前订单可用的平台优惠券 */
+(void)getSystemCoupon:(NSDictionary *)paramsDic withSuccessBlock:(void (^)(NSDictionary *result))successBlock withFailBlock:(void (^)(NSString *msg))failBlock;

/* 获取可领取的优惠券列表 */
+(void)getCouponList:(NSDictionary *)paramsDic withSuccessBlock:(void (^)(NSDictionary *result))successBlock withFailBlock:(void (^)(NSString *msg))failBlock;

/* 获取已领取的优惠券列表 */
+(void)getUserCoupon:(NSDictionary *)paramsDic withSuccessBlock:(void (^)(NSDictionary *result))successBlock withFailBlock:(void (^)(NSString *msg))failBlock;

/* 领取优惠券 */
+(void)receiveCoupon:(NSDictionary *)paramsDic withSuccessBlock:(void (^)(NSDictionary *result))successBlock withFailBlock:(void (^)(NSString *msg))failBlock;
@end
