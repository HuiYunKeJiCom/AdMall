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

/** 昵称 */
@property (nonatomic, copy) NSString      *nickName;

/** 手机号码 */
@property (nonatomic, copy) NSString      *phone;

/** 头像地址 */
@property (nonatomic, copy) NSString      *pictureUrl;

/** 性别 0:男，1：女 */
@property (nonatomic, copy) NSString      *gender;

@property (nonatomic, copy) NSString      *userName;


@property (nonatomic, copy) NSString *nationcode;
@property (nonatomic, copy) NSString      *password;

@property (nonatomic, copy) NSString      *mobile;

@property (nonatomic, copy) NSString      *weixin;

@property (nonatomic, copy) NSString      *qq;

@property (nonatomic, copy) NSString      *weibo;

@property (nonatomic, copy) NSString      *email;

/** 名字 */
@property (nonatomic, copy) NSString      *name;
/** 用户类型 */
@property (nonatomic, copy) NSString      *userType;

/** 登录时间 */
@property (nonatomic, copy) NSString      *loginTime;


@end
