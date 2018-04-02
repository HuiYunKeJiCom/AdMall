//
//  ADGoodsSpecModel.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/30.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ADProsModel;
@interface ADGoodsSpecModel : NSObject
/** 规格id */
@property (nonatomic, copy) NSString      *spec_id;
/** 规格名称 */
@property (nonatomic, copy) NSString      *spec_name;
/** 规格序列 */
@property (nonatomic, copy) NSString      *sequence;
/** 规格类型【img=图片，text=文字】 */
@property (nonatomic, copy) NSString      *type;
/** 商品规格值数组 */
@property (nonatomic, copy) NSArray<ADProsModel *>      *pros;
@end
