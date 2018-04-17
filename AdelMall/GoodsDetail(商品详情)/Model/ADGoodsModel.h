//
//  ADGoodsModel.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/2/8.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADGoodsModel : NSObject
/** id */
@property (nonatomic, copy) NSString      *idx;
/** 创建时间 */
@property (nonatomic, copy) NSString      *addTime;
/** 商品名称 */
@property (nonatomic, copy) NSString      *goods_name;
/** 商品价格 */
@property (nonatomic, copy) NSString      *store_price;
/** 商品当前价格 */
@property (nonatomic, copy) NSString      *goods_current_price;
/** 商品市场价格 */
@property (nonatomic, copy) NSString      *goods_price;
/** 商品重量（单位：千克(Kg)） */
@property (nonatomic, copy) NSString      *goods_weight;
/** 商品体积 （单位：立方米(m³)） */
@property (nonatomic, copy) NSString      *goods_volume;
/** 商品主图片 */
@property (nonatomic, copy) NSString      *goods_image_path;
/** 商品详情 */
@property (nonatomic, copy) NSString      *goods_details;
/** 商品参数 */
@property (nonatomic, copy) NSString      *goods_property;
/** 店铺id */
@property (nonatomic, copy) NSString      *store_id;
/** 店铺名称 */
@property (nonatomic, copy) NSString      *store_name;
/** 店主用户名 */
@property (nonatomic, copy) NSString      *store_ower;
/** 商品状态（0=上架，1=仓库中，-1=已下架，-2=违规下架） */
@property (nonatomic, copy) NSString      *goods_status;
/** 商品库存数 */
@property (nonatomic, copy) NSString      *goods_inventory;
/** 商品库存数（all=全局配置，spec=规格配置） */
@property (nonatomic, copy) NSString      *inventory_type;
/** 商品类型（0=实物商品，1=虚拟商品） */
@property (nonatomic, copy) NSString      *goods_choice_type;
/** 商品人气（点击数） */
@property (nonatomic, copy) NSString      *goods_click;
/** 商品销售量 */
@property (nonatomic, copy) NSString      *goods_salenum;
/** 商品收藏人数 */
@property (nonatomic, copy) NSString      *goods_collect;
/** 累计评价数 */
@property (nonatomic, copy) NSString      *evaluates_size;
/** 运费承担方式（0=买家承担，1=卖家承担） */
@property (nonatomic, copy) NSString      *goods_transfee;
@end
