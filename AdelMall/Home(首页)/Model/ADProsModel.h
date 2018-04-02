//
//  ADProsModel.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/30.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADProsModel : NSObject
/** 规格属性id */
@property (nonatomic, copy) NSString      *pro_id;
/** 属性值 */
@property (nonatomic, copy) NSString      *pro_value;
///** 规格类型【img=图片，text=文字】 */
//@property (nonatomic, copy) NSString      *pro_image_path;
@end
