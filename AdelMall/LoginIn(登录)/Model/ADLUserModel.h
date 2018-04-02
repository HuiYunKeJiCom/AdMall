//
//  ADLUserModel.h
//  Kart
//
//  Created by occ on 2017/3/14.
//  Copyright © 2017年 朱鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADLUserModel : NSObject

@property (nonatomic, copy) NSString      *idx;

/** 用户名 */
@property (nonatomic, copy) NSString      *userName;

/** 真实姓名 */
@property (nonatomic, copy) NSString      *trueName;

/** 用户角色【BUYER=买家，BUYER_SELLER=卖家，ADMIN=系统管理员】 */
@property (nonatomic, copy) NSString      *userRole;

/** 注册时间 */
@property (nonatomic, copy) NSString      *addTime;
/** 年龄 */
@property (nonatomic, copy) NSString      *years;
/** qq号码 */
@property (nonatomic, copy) NSString      *QQ;
/** 地址 */
@property (nonatomic, copy) NSString      *address;
/** 可用余额 */
@property (nonatomic, copy) NSString      *availableBalance;
/** 冻结金额 */
@property (nonatomic, copy) NSString      *freezeBlance;
/** 生日 */
@property (nonatomic, copy) NSString      *birthday;
/** 邮箱地址 */
@property (nonatomic, copy) NSString      *email;
/** 积分 */
@property (nonatomic, copy) NSString      *integral;
/** 最后登录时间 */
@property (nonatomic, copy) NSString      *lastLoginDate;

/** 最后登录IP */
@property (nonatomic, copy) NSString      *lastLoginIp;
/** 登录次数 */
@property (nonatomic, copy) NSString      *loginCount;
/** 登录时间 */
@property (nonatomic, copy) NSString      *loginDate;
/** 登录IP */
@property (nonatomic, copy) NSString      *loginIp;
/** 手机号 */
@property (nonatomic, copy) NSString      *mobile;
/** 性别【-1=保密，0=女，1=男】 */
@property (nonatomic, copy) NSString      *sex;
/** 账号状态【0=正常】 */
@property (nonatomic, copy) NSString      *status;
/** 座机号码 */
@property (nonatomic, copy) NSString      *telephone;
/** 用户信用分 */
@property (nonatomic, copy) NSString      *user_credit;
/** 头像路径 */
@property (nonatomic, copy) NSString      *photo_path;
/** 店铺id */
@property (nonatomic, copy) NSString      *store_id;
/** app登录密钥 */
@property (nonatomic, copy) NSString      *app_token;

@end
