//
//  ADRelatedGoodsViewModel.h
//  AdelMall
//
//  Created by apple on 2018/4/11.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADRelatedGoodsViewModel : NSObject

@property (nonatomic,strong)BaseTableView *goodsTable;//懒加载，需要外部设定frame

@end
