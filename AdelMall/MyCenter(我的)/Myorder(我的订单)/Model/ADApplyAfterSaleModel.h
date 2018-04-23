//
//  ADApplyAfterSaleModel.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/13.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADApplyAfterSaleModel : NSObject
/** 售后服务单号【该参数不为空代表已申请过售后】 */
@property (nonatomic, copy) NSString      *apply_no;
/** 申请时间 */
@property (nonatomic, copy) NSString      *addTime;
/** 订单号 */
@property (nonatomic, copy) NSString      *order_id;
/** 商品ID */
@property (nonatomic, copy) NSString      *goods_id;
/** 商品名称 */
@property (nonatomic, copy) NSString      *goods_name;
/** 商品价格 */
@property (nonatomic, copy) NSString      *price;
/** 商品主图片 */
@property (nonatomic, copy) NSString      *goods_image_path;

@end
