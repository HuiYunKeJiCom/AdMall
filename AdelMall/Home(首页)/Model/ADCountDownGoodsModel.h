//
//  ADCountDownGoodsModel.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/27.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADCountDownGoodsModel : NSObject
/** 活动商品id (进入详情页面传这个id) */
@property (nonatomic, copy) NSString      *idx;
/** 商品名 */
@property (nonatomic, copy) NSString      *gg_name;
/** 商品原价格 */
@property (nonatomic, copy) NSString      *goods_price;
/** 商品抢购价格 */
@property (nonatomic, copy) NSString      *gg_price;
/** 商品图片path */
@property (nonatomic, copy) NSString      *goods_image_path;

/** 活动商品内容 */
@property (nonatomic, copy) NSString      *gg_content;
/** 最低购买量 */
@property (nonatomic, copy) NSString      *gg_min_count;
/** 最大购买量 */
@property (nonatomic, copy) NSString      *gg_max_count;
/** 商品id */
@property (nonatomic, copy) NSString      *gg_goods_id;
/** 活动商品状态 （0=待审核，1=审核通过，-1审核拒绝）*/
@property (nonatomic, copy) NSString      *gg_status;
/** 活动商品折扣 */
@property (nonatomic, copy) NSString      *gg_rebate;
/** 已抢数量 */
@property (nonatomic, copy) NSString      *gg_def_count;
/** 抢购商品库存 */
@property (nonatomic, copy) NSString      *gg_count;
/** 虚拟数量 */
@property (nonatomic, copy) NSString      *gg_vir_count;
@end
