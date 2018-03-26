//
//  ADEvaluateBottomView.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/8.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADEvaluateBottomView : UIView
/* 评论按钮 点击回调 */
@property (nonatomic, copy) dispatch_block_t evaluateBtnClickBlock;
@end
