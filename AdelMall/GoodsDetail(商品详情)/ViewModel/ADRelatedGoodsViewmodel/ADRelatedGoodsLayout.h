//
//  ADRelatedGoodsViewModel.h
//  AdelMall
//
//  Created by apple on 2018/4/19.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCClassGoodsItem.h"
/*
    create by CTO
 */
@interface ADRelatedGoodsLayout : NSObject

@property (nonatomic,strong)DCClassGoodsItem *item;//持有的数据

@property (nonatomic,assign)CGFloat height;//高度

+ (instancetype)layoutWithGoodsItem:(DCClassGoodsItem *)goodsItem;

- (void)layout;//计算布局

@end
