//
//  ADApplyAfterSaleCell.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/13.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import "BaseTableCell.h"

@class ADApplyAfterSaleModel;
@interface ADApplyAfterSaleCell : BaseTableCell
@property (nonatomic, strong) ADApplyAfterSaleModel  *model;
/* 申请售后 点击回调 */
@property (nonatomic, copy) dispatch_block_t applyAfterSaleBtnClickBlock;
@end
