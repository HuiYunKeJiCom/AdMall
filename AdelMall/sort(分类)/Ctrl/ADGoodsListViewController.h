//
//  ADGoodsListViewController.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/13.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DCClassGoodsItem;
@interface ADGoodsListViewController : UIViewController
@property (nonatomic,assign) NSInteger index;
/** 列表 标题 由分类页面或首页传过来*/
@property(nonatomic,copy)NSString *titleString;
/** 关键字 */
@property(nonatomic,copy)NSString *keyWord;
/*  选中分类 */
@property (strong , nonatomic)DCClassGoodsItem *subItem;

@end
