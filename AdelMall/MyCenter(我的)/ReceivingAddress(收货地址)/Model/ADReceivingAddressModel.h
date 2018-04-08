//
//  ADReceivingAddressModel.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/9.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADReceivingAddressModel : NSObject
@property (nonatomic, copy) NSString * address_id;            // 收货地址ID【该参数为空时新增，反之修改】
@property (nonatomic, copy) NSString * label;            // 地址标签【家、公司、其他】
@property (nonatomic, copy) NSString * trueName;             // 收件人姓名
@property (nonatomic, copy) NSString * area_id;             // 所属区域id【省、市、区】
@property (nonatomic, copy) NSString * area_name;             // 所属区域【省、市、区】
@property (nonatomic, copy) NSString * detail_address;       // 详细地址（如：红牌楼街道下一站都市B座406）
@property (nonatomic, copy) NSString * mobile;            // 手机号
@property (nonatomic, copy) NSString * telephone;            // 座机号
@property (nonatomic, copy) NSString * post_code;            // 邮编号码【后台默认000000】
@property (nonatomic, copy) NSString * is_default;            // 是否为默认地址【0=否（默认），1=是】
@end
