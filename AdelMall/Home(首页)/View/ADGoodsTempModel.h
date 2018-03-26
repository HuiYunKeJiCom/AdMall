//
//  ADGoodsTempModel.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/26.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADGoodsTempModel : NSObject
/** id */
@property (nonatomic, copy) NSString      *idx;
/** 商品名 */
@property (nonatomic, copy) NSString      *goods_name;
/** 商品当前价格 */
@property (nonatomic, copy) NSString      *goods_current_price;
/** 商品库存数 */
@property (nonatomic, copy) NSString      *goods_inventory;
/** 商品图片path */
@property (nonatomic, copy) NSString      *goods_image_path;

@end
