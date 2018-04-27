//
//  ADRelatedGoodsViewModel.h
//  AdelMall
//
//  Created by apple on 2018/4/11.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCClassGoodsItem.h"
#import "ADGoodsModel.h"

/*
    相关商品页面
 */

@interface ADRelatedGoodsViewModel : NSObject

//@property (nonatomic,strong)BaseTableView *goodsTable;//懒加载，需要外部设定frame
@property (nonatomic,readonly)UITableView *goodsListView;//懒加载，需要外部设定frame

//- (void)loadGoodsData:(NSArray<DCClassGoodsItem *> *)goodsItem;
- (void)loadGoodsData:(NSArray<ADGoodsModel *> *)goodsItem;

@end
