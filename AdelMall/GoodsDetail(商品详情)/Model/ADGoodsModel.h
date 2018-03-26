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
/** 商品名 */
@property (nonatomic, copy) NSString      *goodsName;
/** 类型 */
@property (nonatomic, copy) NSString      *type;
/** 价格 */
@property (nonatomic, copy) NSString      *price;
@end
