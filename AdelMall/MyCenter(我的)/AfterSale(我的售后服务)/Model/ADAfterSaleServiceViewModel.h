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
/** 售后类型【0=退款，1=换货，2=维修】 */
@property (nonatomic, copy) NSString      *apply_type;
/** 售后服务当前状态【1=提交申请，2=客服审核，3=商家收货，4=商家处理，5=完成】 */
@property (nonatomic, copy) NSString      *statues;
/** 申请时间 */
@property (nonatomic, copy) NSString      *addTime;
/** 订单号 */
@property (nonatomic, copy) NSString      *order_id;
/** 商品ID */
@property (nonatomic, copy) NSString      *goods_id;
/** 商品名称 */
@property (nonatomic, copy) NSString      *goods_name;
/** 商品主图片 */
@property (nonatomic, copy) NSString      *goods_image_path;
@end
