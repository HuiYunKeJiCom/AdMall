//
//  ADEvaluateModel.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/10.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADEvaluateModel : NSObject
/** id */
@property (nonatomic, copy) NSString      *idx;
/** 商品名称 */
@property (nonatomic, copy) NSString      *goodsName;
/** 商品类型 */
@property (nonatomic, copy) NSString      *goodsType;
/** 价格 */
@property (nonatomic, copy) NSString      *goodsPrice;
/** 评价人数 */
@property (nonatomic, copy) NSString      *evaluationNumber;
@end
