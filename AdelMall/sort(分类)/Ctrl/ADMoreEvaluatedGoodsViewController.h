//
//  ADMordEvaluatedGoodsViewController.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/13.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DCClassGoodsItem;
@interface ADMoreEvaluatedGoodsViewController : UIViewController
/*  选中分类 */
@property (strong , nonatomic)DCClassGoodsItem *subItem;
-(void)loadDataWith:(DCClassGoodsItem *)goodsItem andKeyword:(NSString *)keyword;
@end
