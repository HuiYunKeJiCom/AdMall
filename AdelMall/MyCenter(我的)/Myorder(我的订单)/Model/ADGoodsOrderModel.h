//
//  ADGoodsOrderModel.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/4/13.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADGoodsOrderModel : NSObject
/** 订单主键ID */
@property (nonatomic, copy) NSString      *of_id;
/** 订单号 */
@property (nonatomic, copy) NSString      *order_id;
/** 下单时间 */
@property (nonatomic, copy) NSString      *addTime;
/** 订单状态【0=已取消，10=待支付，20=待发货，30=待确认收货，40待评价=，50=已完成】 */
@property (nonatomic, copy) NSString      *order_status;
/** 订单金额 */
@property (nonatomic, copy) NSString      *totalPrice;
/** 商品名称【多个商品用逗号分隔】 */
@property (nonatomic, copy) NSString      *goods_name;
/** 商品主图片 */
@property (nonatomic, copy) NSString      *goods_image_path;
/** 订单商品数量 */
@property (nonatomic, copy) NSString      *count;
@end
