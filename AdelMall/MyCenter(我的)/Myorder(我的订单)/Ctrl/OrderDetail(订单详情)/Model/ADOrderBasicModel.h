//
//  ADOrderBasicModel.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/2/9.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADOrderBasicModel : NSObject
/** 订单主键ID */
@property (nonatomic, copy) NSString      *of_id;
/** 订单号 */
@property (nonatomic, copy) NSString      *order_id;
/** 下单时间 */
@property (nonatomic, copy) NSString      *addTime;
/** 订单状态【0=已取消，10=待支付，20=待发货，30=待确认收货，40=待评价，50=已完成】 */
@property (nonatomic, copy) NSString      *order_status;
/** 订单总金额【商品总金额+邮费-优惠券金额】 */
@property (nonatomic, copy) NSString      *order_total_price;
/** 商品总金额 */
@property (nonatomic, copy) NSString      *goods_total_price;
/** 优惠券金额 */
@property (nonatomic, copy) NSString      *coupon_amount;
/** 配送方式 */
@property (nonatomic, copy) NSString      *transport_type;
/** 邮费 */
@property (nonatomic, copy) NSString      *ship_price;
/** 快递单号【用于查询物流信息】 */
@property (nonatomic, copy) NSString      *ship_code;
/** 快递公司标签【用于查询物流信息】 */
@property (nonatomic, copy) NSString      *ship_company_lable;
/** 发货时间 */
@property (nonatomic, copy) NSString      *ship_time;
/** 快递公司名称 */
@property (nonatomic, copy) NSString      *ship_company;
/** 收件人姓名 */
@property (nonatomic, copy) NSString      *trueName;
/** 收货地址省市区 */
@property (nonatomic, copy) NSString      *area_name;
/** 详细地址 */
@property (nonatomic, copy) NSString      *detail_address;
/** 收件人手机号 */
@property (nonatomic, copy) NSString      *mobile;
/** 收件人座机号 */
@property (nonatomic, copy) NSString      *telephone;
/** 邮编号码 */
@property (nonatomic, copy) NSString      *post_code;
/** 地址标签【家、公司、其他】 */
@property (nonatomic, copy) NSString      *label;
/** 发票抬头 */
@property (nonatomic, copy) NSString      *invoice_title;
/** 发票内容【0=商品明细，1=商品类别】 */
@property (nonatomic, copy) NSString      *invoice_content;
/** 发票种类【0=普通发票、1=电子发票、2=增值税专用发票】 */
@property (nonatomic, copy) NSString      *invoice_type;
/** 支付方式 */
@property (nonatomic, copy) NSString      *pay_type;
@end
