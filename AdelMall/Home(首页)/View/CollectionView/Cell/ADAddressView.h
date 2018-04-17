//
//  ADAddressView.h
//  DropDownView(筛选框)
//
//  Created by 张锐凌 on 2018/3/15.
//  Copyright © 2018年 Mix_Reality. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ADAddressModel;
@interface ADAddressView : UIView
///** 主题 */
//@property(nonatomic,strong)UILabel *titleLab;
/** 地址model */
@property (nonatomic, strong) ADAddressModel  *model;
@end
