//
//  ADLabelModel.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/4/18.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADLabelModel : NSObject
/** 标签主键ID【用于关联正在填写的评价】 */
@property (nonatomic, copy) NSString      *label_id;
/** 标签名称 */
@property (nonatomic, copy) NSString      *label_name;
@end
