//
//  ADFlashSaleViewController.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/6.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADFlashSaleViewController : UIViewController
@property (nonatomic,assign) NSInteger index;
/** 抢购倒计时时间 */
@property(nonatomic,strong)NSDictionary *timeDict;
@end
