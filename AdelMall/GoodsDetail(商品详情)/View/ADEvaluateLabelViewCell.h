//
//  ADEvaluateLabelViewCell.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/2/25.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADEvaluateLabelViewCell : UICollectionViewCell
/* 箭头按钮 点击回调 */
@property (nonatomic, copy) dispatch_block_t moreBtnClickBlock;
@end
