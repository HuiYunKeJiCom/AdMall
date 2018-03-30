//
//  FFGlobalModel.h
//  Kart
//
//  Created by occ on 2017/3/14.
//  Copyright © 2017年 朱鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ADLUserModel.h"

@interface ADLGlobalHandleModel : NSObject

+ (ADLGlobalHandleModel *)sharedInstance;

/*登录账号信息*/
@property (nonatomic, copy, getter = readLoginName, setter = saveLoginName:) NSString *LoginName;

/*密码*/
@property (nonatomic, copy, getter = readPassword, setter = savePassword:) NSString *Password;

/*当前登录用户*/
@property (nonatomic, strong, getter = readCurrentUser, setter= saveCurrentUser:) ADLUserModel *CurrentUser;

/** 语言版本*/
@property (nonatomic, strong, getter = readLanguage, setter= saveLanguage:) NSString *LocalLanguage;

/** 客服电话*/
@property (nonatomic, strong, getter = readChatPhone, setter= saveChatPhone:) NSString *ChatPhone;

/** 个人头像*/
@property (nonatomic, strong, getter = readUserPhoto, setter= saveUserPhoto:) UIImage *userPhoto;

/** 更新本地数据*/
+ (void)updateLocalInfo;

/** 更新个人信息*/
+ (void)updateUserInfo;


/** 更新客服电话信息*/
+ (void)updateChatPhoneInfo;

/** 模块显示隐藏 包含隐藏*/
+ (NSArray *)readShowModules;

+ (void)saveShowModules:(NSArray *)modules;




/*退出 删除用户信息*/
- (void)deleteUserData;

/** 清除缓存 */
- (void)cleanCache;

- (float)cacheSize;

@end
