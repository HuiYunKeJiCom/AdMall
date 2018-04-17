//
//  ADGoodsDetailModel.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/4/10.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ADPropertyModel;
@interface ADGoodsDetailModel : NSObject
/** 商品id */
@property (nonatomic, copy) NSString      *idx;
/** 商品分类id */
@property (nonatomic, copy) NSString      *gc_id;
/** 创建时间 */
@property (nonatomic, copy) NSString      *addTime;
/** 商品名称 */
@property (nonatomic, copy) NSString      *goods_name;
/** 市场价 */
@property (nonatomic, copy) NSString      *goods_price;
/** 店铺价格 */
@property (nonatomic, copy) NSString      *store_price;
/** 商品当前价格 */
@property (nonatomic, copy) NSString      *goods_current_price;
/** 库存 */
@property (nonatomic, copy) NSString      *goods_inventory;
/** 商品库存数（all=全局配置，spec=规格配置） */
@property (nonatomic, copy) NSString      *inventory_type;
/** 商品类型（0=实物商品，1=虚拟商品） */
@property (nonatomic, copy) NSString      *goods_choice_type;

/** 商品收藏人数 */
@property (nonatomic, copy) NSString      *goods_collect;
/** 商品参数[{“val”:”参数值”,”id”:”2”,”name”:”参数名}] */
@property (nonatomic, strong) NSArray<ADPropertyModel *>      *goods_property;
/** 销量 */
@property (nonatomic, copy) NSString      *goods_salenum;
/** 销售时间 */
@property (nonatomic, copy) NSString      *goods_seller_time;
/** 商品货号【商品货号是指卖家个人管理商品的编号，买家不可见】 */
@property (nonatomic, copy) NSString      *goods_serial;
/** 商品状态【0=已发布，1=保存但未发布，-1=已下架，-2=违规下架】 */
@property (nonatomic, copy) NSString      *goods_status;
/** 运费承担方式【0=卖家承担运费，1=买家承担运费】 */
@property (nonatomic, copy) NSString      *goods_transfee;
/** 商品重量（单位：千克(Kg)） */
@property (nonatomic, copy) NSString      *goods_weight;
/** 商品体积 （单位：立方米(m³)） */
@property (nonatomic, copy) NSString      *goods_volume;
/** 点击量 */
@property (nonatomic, copy) NSString      *goods_click;
/** 店铺id */
@property (nonatomic, copy) NSString      *store_id;
/** 店铺名称 */
@property (nonatomic, copy) NSString      *store_name;
/** 店主用户名 */
@property (nonatomic, copy) NSString      *store_ower;
@end
