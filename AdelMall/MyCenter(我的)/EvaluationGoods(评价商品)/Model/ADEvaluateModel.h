//
//  ADEvaluateModel.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/10.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADEvaluateModel : NSObject
/** 评价主键ID（待评价时该参数为null） */
@property (nonatomic, copy) NSString      *evaluate_id;
/** 评价状态【0=待评价（默认值），1=已评价，2=已失效】 */
@property (nonatomic, copy) NSString      *evaluate_status;
/** 商品所属订单号 */
@property (nonatomic, copy) NSString      *order_id;
/** 下单时间 */
@property (nonatomic, copy) NSString      *addTime;
/** 订单状态【0=已取消，10=待支付，20=待发货，30=待确认收货，40待评价=，50=已完成】 */
@property (nonatomic, copy) NSString      *order_status;
/** 商品名称 */
@property (nonatomic, copy) NSString      *goods_name;
/** 商品ID */
@property (nonatomic, copy) NSString      *goods_id;
/** 商品主图片 */
@property (nonatomic, copy) NSString      *goods_image_path;
/** 商品价格 */
@property (nonatomic, copy) NSString      *goods_current_price;
/** 商品评价人数 */
@property (nonatomic, copy) NSString      *goods_evaluates_size;
@end
