//
//  ADLoginController.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/29.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import "ADLoginController.h"
#import "ADLoginView.h"
#import "ADLUserModel.h"
#import "ADLGlobalHandleModel.h"
#import "ADAppToken.h"

@interface ADLoginController ()<ADLoginViewDelegate>

@property (nonatomic, strong) ADLoginView *loginView;

@end

@implementation ADLoginController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    if (self.navigationController) {
        [self.navigationController setNavigationBarHidden:YES];
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    if (self.navigationController) {
        [self.navigationController setNavigationBarHidden:NO];
    }
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = KColorTextDA2F2D;
    [self.view addSubview:self.loginView];
    
    [self makeConstraints];
}

#pragma mark - getter

- (ADLoginView *)loginView {
    if (!_loginView) {
        _loginView = [[ADLoginView alloc] init];
        _loginView.delegate = self;
    }
    return _loginView;
}

#pragma mark - Constraints

- (void)makeConstraints {
    WEAKSELF
    [self.loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(weakSelf.view);
    }];
}

/**
 *登陆传参
 */
#pragma mark - ADLLoginViewDelegate

- (void)loginView:(ADLoginView *)logView userName:(NSString *)userName pwd:(NSString *)pwd {
#if 0
    NSLog(@"userName = %@,pwd = %@",userName,pwd);
//    [NSString getMd5_32Bit_String:pwd]
    
//    WEAKSELF
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [RequestTool loginWithDictionary:@{@"userName":[NSString limitStringNotEmpty:userName],
                                       @"password":[NSString limitStringNotEmpty:pwd]} withSuccessBlock:^(NSDictionary *result) {
        NSLog(@"登录result = %@",result);
        if([result[@"code"] integerValue] == 1){
//            result[@"data"]
            hud.hidden = YES;
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            ADLUserModel *model = [ADLUserModel mj_objectWithKeyValues:result[@"data"]];
            [ADLGlobalHandleModel sharedInstance].CurrentUser = model;
            [[ADLGlobalHandleModel sharedInstance] saveCurrentUser:model];
            [[ADLGlobalHandleModel sharedInstance] saveLoginName:userName];
            [[ADLGlobalHandleModel sharedInstance] savePassword:pwd];
            
            if(![model.app_token isEqualToString:[ADAppToken dc_GetLastOneAppToken]]){
                [ADAppToken dc_SaveNewAppToken:model.app_token];
//                NSLog(@"请求myAppToken = %@",model.app_token);
            }
//            NSLog(@"请头myAppToken = %@",model.app_token);
            [kAppDelegate initRootUI];
            
        }else{
        }
    } withFailBlock:^(NSString *msg) {
        hud.hidden = YES;
        NSLog(@"登录msg = %@",msg);
    }];
#else
    [kAppDelegate initRootUI];
    
    
#endif
}

/**
 *注册
 */
- (void)loginView:(ADLoginView *)logView eventType:(UseLoginType)eventType {
    
    switch (eventType) {
        case UseLoginTypeLogin:{
            
        }
            break;
        case UseLoginTypeForget:{
            //忘记密码
//            ADLForgetPasswordCtrl *ctrl = [[ADLForgetPasswordCtrl alloc] init];
//            [self.navigationController pushViewController:ctrl animated:YES];
        }
            break;
        case UseLoginTypeRegister:{
            //注册
//            ADLRegisterInformCtrl *ctrl = [[ADLRegisterInformCtrl alloc] init];
//            [self.navigationController pushViewController:ctrl animated:YES];
        }
            break;
        case UseLoginTypePhone:{
//            ADLLoginPhoneCtrl *ctrl = [[ADLLoginPhoneCtrl alloc] init];
//            [self.navigationController pushViewController:ctrl animated:YES];
        }
            break;
        case UseLoginTypeWXAuth:{
//            NSLog(@"微信登录");
//            [self actionAuth:eventType];
        }
            break;
        case UseLoginTypeQQAuth:{
//            [self actionAuth:eventType];
        }
            break;
        case UseLoginTypeSinaAuth:{
//            [self actionAuth:eventType];
        }
            break;
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
