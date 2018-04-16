//
//  ADOrderListViewCell.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/2/9.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ADOrderModel,ADOrderBasicModel;
@interface ADOrderListViewCell : BaseTableCell
/* 商品数据数组 */
@property (strong , nonatomic)NSMutableArray<ADOrderModel *> *goodsOrderArray;
/** 订单模型 */
@property(nonatomic,strong)ADOrderBasicModel *orderBasicModel;
@end
