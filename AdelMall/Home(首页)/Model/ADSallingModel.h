//
//  ADSallingModel.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/6.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADSallingModel : NSObject
/** id */
@property (nonatomic, copy) NSString      *idx;
/** 商品名 */
@property (nonatomic, copy) NSString      *goodsName;
/** 类型 */
@property (nonatomic, copy) NSString      *type;
/** 原价格 */
@property (nonatomic, copy) NSString      *oldPrice;
/** 销售价格 */
@property (nonatomic, copy) NSString      *salePrice;
/** 总销售数量 */
@property (nonatomic, copy) NSString      *saleNum;
/** 已销售数量 */
@property (nonatomic, copy) NSString      *soldNum;
@end
