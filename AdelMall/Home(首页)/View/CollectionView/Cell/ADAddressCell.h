//
//  ADAddressCell.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/16.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADAddressCell : UICollectionViewCell
/* openView 点击回调 */
@property (nonatomic, copy) dispatch_block_t openViewClickBlock;
/* closeView 点击回调 */
@property (nonatomic, copy) dispatch_block_t closeViewClickBlock;
/* 新增收货地址 点击回调 */
@property (nonatomic, copy) dispatch_block_t addAddressClickBlock;
@end
