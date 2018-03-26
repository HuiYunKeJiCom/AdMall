//
//  ADAddressModel.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/20.
//  Copyright © 2018年 Adel. All rights reserved.
//  收货地址Model

#import <Foundation/Foundation.h>

@interface ADAddressModel : NSObject
/** id */
@property (nonatomic, copy) NSString      *idx;
/** 地址 */
@property (nonatomic, copy) NSString      *address;
/** 家 地址标签 */
@property (nonatomic, copy) NSString      *addressLabelName;
/** 收件人 */
@property (nonatomic, copy) NSString      *receiverName;
/** 电话 */
@property (nonatomic, copy) NSString      *phone;
/** 邮编 */
@property (nonatomic, copy) NSString      *zipCode;
@end
