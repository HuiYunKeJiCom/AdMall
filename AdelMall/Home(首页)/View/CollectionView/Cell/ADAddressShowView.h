//
//  ADAddressShowView.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/20.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ADAdressModelNew;
@interface ADAddressShowView : UIView
///** 主题 */
//@property(nonatomic,strong)UILabel *titleLab;
/** 地址model */
@property (nonatomic, strong) ADAdressModelNew  *model;
@end
