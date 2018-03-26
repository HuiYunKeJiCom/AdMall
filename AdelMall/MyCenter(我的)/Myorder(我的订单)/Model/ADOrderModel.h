//
//  ADOrderModel.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/2/6.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADOrderModel : NSObject
/** id */
@property (nonatomic, copy) NSString      *idx;
/** 订单号 */
@property (nonatomic, copy) NSString      *orderNo;
/** name */
@property (nonatomic, copy) NSString      *goodsName;
/** 日期 */
@property (nonatomic, copy) NSString      *date;
/** 价格 */
@property (nonatomic, copy) NSString      *price;
/** 状态 */
@property (nonatomic, copy) NSString      *state;
@end
