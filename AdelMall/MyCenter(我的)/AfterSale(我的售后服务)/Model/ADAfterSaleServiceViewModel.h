//
//  ADAfterSaleServiceViewModel.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/2.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADAfterSaleServiceViewModel : NSObject
/** 售后服务单号 */
@property (nonatomic, copy) NSString      *apply_no;
/** 提交申请时间 */
@property (nonatomic, copy) NSString      *addTime;
/** 售后服务当前状态【1=提交申请，2=客服审核，3=商家收货，4=商家处理，5=完成】 */
@property (nonatomic, copy) NSString      *statues;
/** 订单号 */
@property (nonatomic, copy) NSString      *order_id;
/** 下单时间 */
@property (nonatomic, copy) NSString      *order_addTime;
/** 配送方式 */
@property (nonatomic, copy) NSString      *transport_type;
/** 支付方式 */
@property (nonatomic, copy) NSString      *payment_type;
/** 店铺ID */
@property (nonatomic, copy) NSString      *store_id;
/** 商品名称 */
@property (nonatomic, copy) NSString      *goods_name;
/** 商品主图片 */
@property (nonatomic, copy) NSString      *goods_image_path;
/** 商品当前价格 */
@property (nonatomic, copy) NSString      *goods_current_price;
/** 客服用户名 */
@property (nonatomic, copy) NSString      *review_user_name;
/** 客服审核时间 */
@property (nonatomic, copy) NSString      *service_approve_date;
/** 客服审核备注信息 */
@property (nonatomic, copy) NSString      *service_approve_content;
/** 商家收货地址 */
@property (nonatomic, copy) NSString      *seller_address;
/** 商家收件人 */
@property (nonatomic, copy) NSString      *seller_true_name;
/** 商家手机号 */
@property (nonatomic, copy) NSString      *seller_mobile;
/** 商家座机 */
@property (nonatomic, copy) NSString      *seller_telephone;
/** 商家邮编 */
@property (nonatomic, copy) NSString      *seller_post_code;
/** 售后类型【0=退款，1=换货，2=维修】 */
@property (nonatomic, copy) NSString      *apply_type;
/** 商品问题类型 */
@property (nonatomic, copy) NSString      *title;
/** 原因说明 */
@property (nonatomic, copy) NSString      *reason;
/** 原订单收货地址 */
@property (nonatomic, copy) NSString      *old_buyer_address;
/** 取件地址省市区ID【数据用逗号分隔（454871,45455,23265），前台需要分隔】 */
@property (nonatomic, copy) NSString      *area_id;
/** 取件地址省市区【数据用逗号分隔（广东省,深圳市,宝安区），前台需要分隔】 */
@property (nonatomic, copy) NSString      *area_name;
/** 取件详细地址 */
@property (nonatomic, copy) NSString      *buyer_address;
/** 联系人 */
@property (nonatomic, copy) NSString      *buyer_true_name;
/** 联系人手机 */
@property (nonatomic, copy) NSString      *buyer_mobile;
/** 快递公司ID */
@property (nonatomic, copy) NSString      *express_id;
/** 快递公司标签【用于查询物流信息】 */
@property (nonatomic, copy) NSString      *express_label;
/** 快递单号 */
@property (nonatomic, copy) NSString      *express_no;
/** 邮费 */
@property (nonatomic, copy) NSString      *express_price;

@end
