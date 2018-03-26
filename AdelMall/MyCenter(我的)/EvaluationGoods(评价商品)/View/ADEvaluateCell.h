//
//  ADEvaluateCell.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/10.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import "BaseTableCell.h"
#import "ADEvaluateModel.h"

@interface ADEvaluateCell : BaseTableCell
@property (nonatomic, strong) ADEvaluateModel  *model;
/* 去评价 按钮 点击回调 */
@property (nonatomic, copy) dispatch_block_t evaluateBtnClickBlock;
@end
