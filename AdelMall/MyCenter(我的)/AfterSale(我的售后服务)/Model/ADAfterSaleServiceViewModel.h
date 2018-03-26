//
//  ADAfterSaleServiceViewModel.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/2.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADAfterSaleServiceViewModel : NSObject
/** id */
@property (nonatomic, copy) NSString      *idx;
/** name */
@property (nonatomic, copy) NSString      *goodsName;
/** 商品类型 */
@property (nonatomic, copy) NSString      *goodsStyle;
@end
