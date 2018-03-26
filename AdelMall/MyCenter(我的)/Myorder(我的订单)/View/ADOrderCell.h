//
//  ADOrderCell.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/2/6.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import "BaseTableCell.h"
#import "ADOrderModel.h"

@interface ADOrderCell : BaseTableCell
@property (nonatomic, strong) ADOrderModel  *model;

/* 售后 点击回调 */
@property (nonatomic, copy) dispatch_block_t afterSaleBtnClickBlock;

/* 去支付 点击回调 */
@property (nonatomic, copy) dispatch_block_t toPayBtnClickBlock;

/* 订单详情 点击回调 */
@property (nonatomic, copy) dispatch_block_t detailBtnClickBlock;
@end
