//
//  ADReceivingAddressViewCell.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/1.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADReceivingAddressViewCell : UICollectionViewCell
/* 查看详情 点击回调 */
@property (nonatomic, copy) dispatch_block_t detailBtnClickBlock;
@end
