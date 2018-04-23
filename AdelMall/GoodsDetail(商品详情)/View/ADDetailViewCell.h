//
//  ADDetailViewCell.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/2/7.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ADGoodsDetailModel;
static NSString * const ADDetailViewCellID = @"ADDetailViewCellID";

@interface ADDetailViewCell : UICollectionViewCell
/** 商品模型 */
@property(nonatomic,strong)ADGoodsDetailModel *dataModel;
-(void)changeLabelWith:(NSMutableArray *)specValueArr;
@end
