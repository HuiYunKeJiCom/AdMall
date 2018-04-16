//
//  ADOrderModel.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/4/16.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADOrderModel : NSObject
/** 商品名称 */
@property (nonatomic, copy) NSString      *goods_name;
/** 商品主图片 */
@property (nonatomic, copy) NSString      *goods_image_path;
/** 商品规格 */
@property (nonatomic, copy) NSString      *spec_info;
/** 商品购买数量 */
@property (nonatomic, copy) NSString      *count;
/** 商品单价 */
@property (nonatomic, copy) NSString      *price;
/** 商品总价【商品单价*数量】 */
@property (nonatomic, copy) NSString      *total_price;
@end
