//
//  ADPropertyModel.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/4/10.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADPropertyModel : NSObject
/** 参数id */
@property (nonatomic, copy) NSString      *idx;
/** 参数值 */
@property (nonatomic, copy) NSString      *val;
/** 参数名称 */
@property (nonatomic, copy) NSString      *name;
@end
