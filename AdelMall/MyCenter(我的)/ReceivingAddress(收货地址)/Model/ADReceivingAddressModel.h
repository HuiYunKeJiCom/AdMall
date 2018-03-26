//
//  ADReceivingAddressModel.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/9.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADReceivingAddressModel : NSObject
/** id */
@property (nonatomic, copy) NSString      *idx;
/** 收件人 */
@property (nonatomic, copy) NSString      *receiverName;
/** 电话 */
@property (nonatomic, copy) NSString      *phone;
/** 家 地址标签 */
@property (nonatomic, copy) NSString      *homeLabelName;
/** 地址 */
@property (nonatomic, copy) NSString      *address;
@end
