//
//  ADApplyAfterSaleModel.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/13.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADApplyAfterSaleModel : NSObject
/** id */
@property (nonatomic, copy) NSString      *idx;
/** 安装地址 */
@property (nonatomic, copy) NSString      *address;
/** 商品类型 */
@property (nonatomic, copy) NSString      *goodsType;
/** 销售价格 */
@property (nonatomic, copy) NSString      *price;
@end
