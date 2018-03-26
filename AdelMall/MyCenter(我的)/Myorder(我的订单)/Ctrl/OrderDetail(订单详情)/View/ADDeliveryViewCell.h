//
//  ADDeliveryViewCell.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/2/9.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADDeliveryViewCell : UICollectionViewCell
/* 查看物流 点击回调 */
@property (nonatomic, copy) dispatch_block_t checkBtnClickBlock;
@end
