//
//  ADSallGoodsDetailViewController.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/16.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ADCountDownActivityModel;
@interface ADSallGoodsDetailViewController : UIViewController
/** 标题 由首页抢购商品传过来*/
@property(nonatomic,copy)NSString *titleString;
-(void)loadDataWithGoodsID:(NSString *)goodsID;
/** 抢购活动模型 */
@property(nonatomic,strong)ADCountDownActivityModel *countDownModel;
@end
