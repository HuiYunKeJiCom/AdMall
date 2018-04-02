//
//  Global.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/1/29.
//  Copyright © 2018年 Adel. All rights reserved.
//




#define CurrentHost @"://192.168.0.59:6108" //测试环境
//用于替换查找
#define TEMPHost @"://"
//Host
#define Host  [NSString stringWithFormat:@"http%@/adel-shop/app/",CurrentHost]


#ifndef Global_h
#define Global_h

#endif /* Global_h */

#define kSmallMargin 10
#define kBigMargin 20

#define kContentTextFont   [UIFont systemFontOfSize:15]
#define kButtonTextFont   [UIFont systemFontOfSize:13]

#define kAppDelegate               ((AppDelegate *)([UIApplication sharedApplication].delegate))

// RGB颜色
#define HX_RGB(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
/**
 *  border颜色
 */
#define LXBorderColor [UIColor colorWithRed:(225)/255.0 green:(225)/255.0 blue:(225)/255.0 alpha:1.0]

// 主题颜色
#define kMAINCOLOR [[UIColor alloc]initWithRed:250/255.0 green:54/255.0 blue:103/255.0 alpha:1]

// 全局背景色  灰色
#define kBACKGROUNDCOLOR [UIColor colorWithHexString:@"#eeeeee"]

// 背景色  淡灰色
#define KBGCOLOR [UIColor colorWithHexString:@"#949494"]

//屏幕宽度相对iPhone6屏幕宽度的比例
#define kWidth_Iphone6_Scale    [UIScreen mainScreen].bounds.size.width/375.0

//根据iphone6尺寸算高度
#define GetScaleWidth(width)  width * kWidth_Iphone6_Scale

/******************    TabBar          *************/
#define MallClassKey   @"rootVCClassString"
#define MallTitleKey   @"title"
#define MallImgKey     @"imageName"
#define MallSelImgKey  @"selectedImageName"

/*****************  屏幕适配  ******************/
#define iphone6p (kScreenHeight == 763)
#define iphone6 (kScreenHeight == 667)
#define iphone5 (kScreenHeight == 568)
#define iphone4 (kScreenHeight == 480)

/******************    TabBar          *************/
#define MallClassKey   @"rootVCClassString"
#define MallTitleKey   @"title"
#define MallImgKey     @"imageName"
#define MallSelImgKey  @"selectedImageName"

//封装了一个宏 用来方便输入文字--实际是文字对应的key
#define KLocalizableStr(key) [(AppDelegate *)[[UIApplication sharedApplication] delegate] showText:(key)]

/** 弱引用 */
#define WEAKSELF __weak typeof(self) weakSelf = self;
#define IMAGE(image)               [UIImage imageNamed:image]
//屏幕的宽度，屏幕的高度
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width

#define PFR [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0 ? @"PingFangSC-Regular" : @"PingFang SC"

#define PFR20Font [UIFont fontWithName:PFR size:20];
#define PFR18Font [UIFont fontWithName:PFR size:18];
#define PFR16Font [UIFont fontWithName:PFR size:16];
#define PFR15Font [UIFont fontWithName:PFR size:15];
#define PFR14Font [UIFont fontWithName:PFR size:14];
#define PFR13Font [UIFont fontWithName:PFR size:13];
#define PFR12Font [UIFont fontWithName:PFR size:12];
#define PFR11Font [UIFont fontWithName:PFR size:11];
#define PFR10Font [UIFont fontWithName:PFR size:10];
#define PFR9Font [UIFont fontWithName:PFR size:9];
#define PFR8Font [UIFont fontWithName:PFR size:8];

#define kFontNum10                  10
#define kFontNum11                  11
#define kFontNum12                  12
#define kFontNum13                  13
#define kFontNum14                  14
#define kFontNum15                  15
#define kFontNum16                  16
#define kFontNum17                  17

/** 登录输入宽未选中字体显示*/
#define KColorTextEBA0A0                UIColorFromRGB(0XEBA0A0)
//色值
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

#define KColorTextEFFFFA                UIColorFromRGB(0XEFFFFA)
#define KColorTextF8FBFA                UIColorFromRGB(0XF8FBFA)
#define KColorTextFFFFFF                UIColorFromRGB(0XFFFFFF)
/** 主红 */
#define KColorTextDA2F2D                UIColorFromRGB(0Xda2f2d)
/** 次红*/
#define KColorTextFBECEE                UIColorFromRGB(0XFBECEE)
//黑色
#define KColorText333333                UIColorFromRGB(0X333333)
#define KColorText59C4F0                UIColorFromRGB(0X59C4F0)
#define KColorText5AC4F1                UIColorFromRGB(0X5AC4F1)
#define KColorText0b5f9b                UIColorFromRGB(0X0b5f9b)
#define KColorText666666                UIColorFromRGB(0X666666)
#define KColorText999999                UIColorFromRGB(0X999999)

#define KColorText323232                UIColorFromRGB(0X323232)
#define KColorText878686                UIColorFromRGB(0X878686)
#define KColorTextf4f4f4                UIColorFromRGB(0Xf4f4f4)

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define k_UIColorFromRGB(rgbValue)\
\
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]

// obj
#define UserDefaultsSetObjectForKey(object,key)     [[NSUserDefaults standardUserDefaults] setObject:object forKey:key]

#define UserDefaultsObjectForKey(key)               [[NSUserDefaults standardUserDefaults] objectForKey:key]

//解归档
#define KeyedUnarchiver(filePath)           [NSKeyedUnarchiver unarchiveObjectWithFile:DocumentDirectory(filePath)]

//归档
#define KeyedArchiver(object,filePath)      [NSKeyedArchiver archiveRootObject:object toFile:DocumentDirectory(filePath)]

//文件路径
#define DocumentDirectory(filePath)         [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:filePath]

//数组
#define GoodsRecommendArray  @[@"http://gfs5.gomein.net.cn/T1blDgB5CT1RCvBVdK.jpg",@"http://gfs1.gomein.net.cn/T1loYvBCZj1RCvBVdK.jpg",@"http://gfs1.gomein.net.cn/T1w5bvB7K_1RCvBVdK.jpg",@"http://gfs1.gomein.net.cn/T1w5bvB7K_1RCvBVdK.jpg",@"http://gfs6.gomein.net.cn/T1L.VvBCxv1RCvBVdK.jpg",@"http://gfs9.gomein.net.cn/T1joLvBKhT1RCvBVdK.jpg",@"http://gfs5.gomein.net.cn/T1AoVvB7_v1RCvBVdK.jpg"]

#define GoodsHomeSilderImagesArray @[@"http://gfs5.gomein.net.cn/T1obZ_BmLT1RCvBVdK.jpg",@"http://gfs9.gomein.net.cn/T1C3J_B5LT1RCvBVdK.jpg",@"http://gfs5.gomein.net.cn/T1CwYjBCCT1RCvBVdK.jpg",@"http://gfs7.gomein.net.cn/T1u8V_B4ET1RCvBVdK.jpg",@"http://gfs7.gomein.net.cn/T1zODgB5CT1RCvBVdK.jpg"]

static inline BOOL IsEmpty(id thing) {
    
    return thing == nil || [thing isEqual:[NSNull null]]
    
    || ([thing respondsToSelector:@selector(length)]
        
        && [(NSData *)thing length] == 0)
    
    || ([thing respondsToSelector:@selector(count)]
        
        && [(NSArray *)thing count] == 0);
}

/** 修改设置页面 */
static NSString * const kUpdateHiddenItemNotification              = @"updateHiddenItemNotification" ;

// 本地化语言 禁止修改
static NSString *kLanguageOfZh = @"zh-Hans";

//错误提示
#define k_requestErrorMessage              @"网络异常，请稍后重试"
