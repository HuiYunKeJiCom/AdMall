//
//  ADSallingCell.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/6.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import "BaseTableCell.h"

@class ADCountDownGoodsModel;
@interface ADSallingCell : BaseTableCell
@property (nonatomic, strong) ADCountDownGoodsModel  *model;
/* 点击商品图片 点击回调 */
@property (nonatomic, copy) dispatch_block_t imageViewBtnClickBlock;
@end
