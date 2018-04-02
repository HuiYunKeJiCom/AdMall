//
//  FFGlobalModel.m
//  Kart
//
//  Created by occ on 2017/3/14.
//  Copyright © 2017年 朱鹏. All rights reserved.
//

#import "ADLGlobalHandleModel.h"

@implementation ADLGlobalHandleModel

+ (ADLGlobalHandleModel *)sharedInstance
{
    static ADLGlobalHandleModel *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (NSString *)readLoginName
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *loginName = [userDefaults objectForKey:@"LockLoginName"];
    return loginName;
}

- (void)saveLoginName:(NSString *)LoginName
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:LoginName forKey:@"LockLoginName"];
    [userDefaults synchronize];
}

- (NSString *)readPassword
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *password = [userDefaults objectForKey:@"Lockpassword"];
    return password;
}

- (void)savePassword:(NSString *)Password
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:Password forKey:@"Lockpassword"];
    [userDefaults synchronize];
}


+ (NSArray *)readShowModules {
    
    ADLUserModel *userModel = [[ADLGlobalHandleModel sharedInstance] readCurrentUser];
    
    NSString *defaultid = [NSString limitStringNotEmpty:userModel.idx];
    if (defaultid.length <= 0) {
        defaultid = @"default_user_id";
    }
    
    NSArray *modules = KeyedUnarchiver(defaultid);
    if (!modules || ![modules isKindOfClass:[NSArray class]]) {
//        modules = @[kModuleShake,kModuleBluetoothPass,kModuleFingerprint,kModuleBloodpressure];
        modules = @[];

    }
    return modules;
}

+ (void)saveShowModules:(NSArray *)modules {
    
    if (!modules || ![modules isKindOfClass:[NSArray class]]) {
//        modules = @[kModuleShake,kModuleBluetoothPass,kModuleFingerprint,kModuleBloodpressure];
        modules = @[];

    }
    
    //存储新的数据
    ADLUserModel *userModel = [[ADLGlobalHandleModel sharedInstance] readCurrentUser];
    NSString *defaultid = [NSString limitStringNotEmpty:userModel.idx];
    if (defaultid.length <= 0) {
        defaultid = @"default_user_id";
    }
    BOOL success = KeyedArchiver(modules,defaultid);

    if (success) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kUpdateHiddenItemNotification object:nil];
    }

}

#pragma mark - 用户本地信息
-(void)saveCurrentUser:(ADLUserModel *)CurrentUser {
    
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:
                         [NSString limitStringNotEmpty:CurrentUser.idx],@"id",
                         [NSString limitStringNotEmpty:CurrentUser.userName],@"userName",
                         [NSString limitStringNotEmpty:CurrentUser.trueName],@"trueName",
                         [NSString limitStringNotEmpty:CurrentUser.userRole],@"userRole",
                         [NSString limitStringNotEmpty:CurrentUser.addTime],@"addTime",
                         [NSString limitStringNotEmpty:CurrentUser.years],@"years",
                         [NSString limitStringNotEmpty:CurrentUser.QQ],@"QQ",
                         [NSString limitStringNotEmpty:CurrentUser.address],@"address",
                         [NSString limitStringNotEmpty:CurrentUser.availableBalance],@"availableBalance",
                         [NSString limitStringNotEmpty:CurrentUser.freezeBlance],@"freezeBlance",
                         [NSString limitStringNotEmpty:CurrentUser.birthday],@"birthday",
                         [NSString limitStringNotEmpty:CurrentUser.email],@"email",
                         [NSString limitStringNotEmpty:CurrentUser.integral],@"integral",
                         [NSString limitStringNotEmpty:CurrentUser.lastLoginDate],@"lastLoginDate",
                         [NSString limitStringNotEmpty:CurrentUser.lastLoginIp],@"lastLoginIp",
                         [NSString limitStringNotEmpty:CurrentUser.loginCount],@"loginCount",
                         [NSString limitStringNotEmpty:CurrentUser.loginDate],@"loginDate",
                         [NSString limitStringNotEmpty:CurrentUser.loginIp],@"loginIp",
                         [NSString limitStringNotEmpty:CurrentUser.mobile],@"mobile",
                         [NSString limitStringNotEmpty:CurrentUser.sex],@"sex",
                         [NSString limitStringNotEmpty:CurrentUser.status],@"status",
                         [NSString limitStringNotEmpty:CurrentUser.telephone],@"telephone",
                         [NSString limitStringNotEmpty:CurrentUser.user_credit],@"user_credit",
                         [NSString limitStringNotEmpty:CurrentUser.photo_path],@"photo_path",
                         [NSString limitStringNotEmpty:CurrentUser.store_id],@"store_id",
                         [NSString limitStringNotEmpty:CurrentUser.app_token],@"app_token",nil];
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:dic forKey:@"CurrentUser"];
    [userDefaults synchronize];
}

-(ADLUserModel *)readCurrentUser {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *currentDic = [userDefaults objectForKey:@"CurrentUser"];
    ADLUserModel *user = [ADLUserModel mj_objectWithKeyValues:currentDic];
    
    return user;
}

- (void)saveUserPhoto:(UIImage *)userPhoto {
    
    ADLUserModel *userModel = [ADLGlobalHandleModel sharedInstance].CurrentUser;
    NSString *photoName = userModel.idx;
    if (photoName.length <= 0) {
        return;
    }
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *imageFilePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg",[NSString getMd5_32Bit_String:photoName]]];

    BOOL success = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    success = [fileManager fileExistsAtPath:imageFilePath];
    if(success) {
        [fileManager removeItemAtPath:imageFilePath error:&error];
    }
    [UIImageJPEGRepresentation(userPhoto, 1.0f) writeToFile:imageFilePath atomically:YES];

}

- (UIImage *)readUserPhoto {
    
    ADLUserModel *userModel = [ADLGlobalHandleModel sharedInstance].CurrentUser;
    NSString *photoName = userModel.idx;
    if (photoName.length <= 0) {
        return [UIImage imageNamed:@"ico_my_default"];
    }
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *imageFilePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg",[NSString getMd5_32Bit_String:photoName]]];
    UIImage *image = [UIImage imageWithContentsOfFile:imageFilePath];
    if (image) {
        return image;
    } else {
        return [UIImage imageNamed:@"ico_my_default"];
    }
}

- (NSString *)readLanguage {
    
    NSString *language = UserDefaultsObjectForKey(@"LocalLanguage");
    if (language.length <= 0) {
        language = kLanguageOfZh;
    }
    return language;
}

- (void)saveLanguage:(NSString *)LocalLanguage {
    UserDefaultsSetObjectForKey(LocalLanguage, @"LocalLanguage");
}

- (NSString *)readChatPhone {
    
    NSString *chatPhone = UserDefaultsObjectForKey(@"LocalChatPhone");
    if (chatPhone.length <= 0) {
        chatPhone = @"";
    }
    return chatPhone;
}

- (void)saveChatPhone:(NSString *)ChatPhone {
    UserDefaultsSetObjectForKey(ChatPhone, @"LocalChatPhone");
}

- (void)cleanCache {
    
    [[SDImageCache sharedImageCache] clearDisk];
}

- (float)cacheSize {
    
    return [[SDImageCache sharedImageCache] getSize];
}

- (void)deleteUserData {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:nil forKey:@"CurrentUser"];
    [userDefaults setObject:nil forKey:@"Lockpassword"];

    self.CurrentUser = nil;
}


/** 更新本地数据*/
+ (void)updateLocalInfo {
    [ADLGlobalHandleModel updateUserInfo];
    [ADLGlobalHandleModel updateChatPhoneInfo];
}

/** 更新个人信息*/
+ (void)updateUserInfo {
    
//    ADLUserModel *userModel = [[ADLGlobalHandleModel sharedInstance] readCurrentUser];
//    NSString *memberId = [NSString limitStringNotEmpty:userModel.idx];
    
//    [RequestTool getMemberInfoDictionary:@{@"memberId":memberId} withSuccessBlock:^(NSDictionary *result) {
//
//        if ([result isKindOfClass:[NSDictionary class]]) {
//            if ([result[@"infoData"] isKindOfClass:[NSDictionary class]]) {
//                ADLUserModel *userModel = [ADLUserModel mj_objectWithKeyValues:result[@"infoData"]];
//                [[ADLGlobalHandleModel sharedInstance] saveCurrentUser:userModel];
//                [[NSNotificationCenter defaultCenter] postNotificationName:kLockUserInformNotification object:userModel];
//            }
//        }
//
//    } withFailBlock:^(NSString *msg) {
//
//    }];
    
}

/** 更新客服电话信息*/
+ (void)updateChatPhoneInfo {
    
//    [RequestTool getCustomerPhoneSuccessBlock:^(NSDictionary *result) {
//
//        if ([result isKindOfClass:[NSDictionary class]]) {
//            NSDictionary *infoData = result[@"infoData"];
//            if ([infoData isKindOfClass:[NSDictionary class]]) {
//                NSString *phone = [NSString limitStringNotEmpty:infoData[@"value"]];
//                [[ADLGlobalHandleModel sharedInstance] saveChatPhone:phone];
//            }
//        }
//
//    } withFailBlock:^(NSString *msg) {
//
//    }];
}

@end
