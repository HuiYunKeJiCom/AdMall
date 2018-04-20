//
//  ADGoodsDetailViewController.h
//  AdelMall
//
//  Created by apple on 2018/4/11.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADGoodsDetailViewController : UIViewController
<<<<<<< HEAD

@property (nonatomic,copy) NSString *goodsID;//商品id

=======
@property (nonatomic,assign) NSInteger index;
/** 购买数量 */
@property (nonatomic, assign) int buyNum;
-(void)loadDataWithGoodsID:(NSString *)goodsID;
>>>>>>> backups
@end
