//
//  ADPolicyViewCell.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/2/9.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADPolicyViewCell : UICollectionViewCell
/* 查看 点击回调 */
@property (nonatomic, copy) dispatch_block_t checkBtnClickBlock;
@end
