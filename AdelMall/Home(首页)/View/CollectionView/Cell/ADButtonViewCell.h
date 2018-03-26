//
//  ADButtonViewCell.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/2/28.
//  Copyright © 2018年 Adel. All rights reserved.
//  

#import <UIKit/UIKit.h>

@interface ADButtonViewCell : UICollectionViewCell
/* 选购门锁 点击回调 */
@property (nonatomic, copy) dispatch_block_t chooseBtnClickBlock;
/* 企业团购 点击回调 */
@property (nonatomic, copy) dispatch_block_t groupPurchaseBtnClickBlock;
/* 限时特价 点击回调 */
@property (nonatomic, copy) dispatch_block_t onSaleBtnClickBlock;
/* 爱迪尔服务 点击回调 */
@property (nonatomic, copy) dispatch_block_t serviceBtnClickBlock;
/* 以旧换新 点击回调 */
@property (nonatomic, copy) dispatch_block_t exchangeBtnClickBlock;
/* 售后政策 点击回调 */
@property (nonatomic, copy) dispatch_block_t afterSaleBtnClickBlock;
@end
