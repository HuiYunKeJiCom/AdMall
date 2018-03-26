//
//  ADSaleView.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/6.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADSaleView : UIView
//加载数据
- (void)setUpDictionary:(NSDictionary *)dict;
//改变字体颜色
- (void)changeTextColor:(UIColor *)color;
@end
