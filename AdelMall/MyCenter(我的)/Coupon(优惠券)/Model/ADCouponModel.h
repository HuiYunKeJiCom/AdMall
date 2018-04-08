//
//  ADCouponModel.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/6.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADCouponModel : NSObject
/** 优惠券id */
@property (nonatomic, copy) NSString      *idx;
/** 创建时间 */
@property (nonatomic, copy) NSString      *addTime;
/** 优惠券名称 */
@property (nonatomic, copy) NSString      *coupon_name;
/** 优惠券数量 */
@property (nonatomic, copy) NSString      *coupon_count;
/** 优惠金额 */
@property (nonatomic, copy) NSString      *coupon_amount;
/** 可用商品类别名称（无类别限制时该参数为空） */
@property (nonatomic, copy) NSString      *class_name;
/** 生效时间 */
@property (nonatomic, copy) NSString      *coupon_begin_time;
/** 失效时间 */
@property (nonatomic, copy) NSString      *coupon_end_time;
/** 订单满足金额（不包含邮费） */
@property (nonatomic, copy) NSString      *coupon_order_amount;
/** 是否只允许新用户使用【0=否，1=是】 */
@property (nonatomic, copy) NSString      *allow_new_user;
/** 优惠券类型【0=平台券，1=商家券】 */
@property (nonatomic, copy) NSString      *coupon_type;
/** 店铺id （类型为平台券时该参数为空） */
@property (nonatomic, copy) NSString      *store_id;
/** 店铺名称（类型为平台券时该参数为空） */
@property (nonatomic, copy) NSString      *store_name;
/** 可用商品类别ID （无类别限制时该参数为空） */
@property (nonatomic, copy) NSString      *goodsclass_id;
@end
