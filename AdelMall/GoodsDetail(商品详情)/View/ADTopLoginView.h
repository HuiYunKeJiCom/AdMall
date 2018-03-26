//
//  ADTopLoginView.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/2/7.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADTopLoginView : UIView
/* 登录按钮 点击回调 */
@property (nonatomic, copy) dispatch_block_t toLoginClickBlock;
/* 关闭 点击回调 */
@property (nonatomic, copy) dispatch_block_t closeClickBlock;
@end
