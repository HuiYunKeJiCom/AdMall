//
//  ADGoodsDetailViewController.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/2/6.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADGoodsDetailViewController : UIViewController
@property (nonatomic,assign) NSInteger index;
/** 购买数量 */
@property (nonatomic, assign) int buyNum;
-(void)loadDataWithGoodsID:(NSString *)goodsID;
@end
