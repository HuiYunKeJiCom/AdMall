//
//  ADGoodsCell.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/2/8.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import "BaseTableCell.h"
#import "ADGoodsModel.h"

@interface ADGoodsCell : BaseTableCell
@property (nonatomic, strong) ADGoodsModel  *model;
/* 点击商品图片 点击回调 */
@property (nonatomic, copy) dispatch_block_t imageViewBtnClickBlock;
@end
