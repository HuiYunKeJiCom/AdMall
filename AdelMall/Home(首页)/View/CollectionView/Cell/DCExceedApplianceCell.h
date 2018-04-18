//
//  DCExceedApplianceCell.h
//  CDDMall
//
//  Created by apple on 2017/6/30.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ADStarGoodsModel;
@interface DCExceedApplianceCell : UICollectionViewCell
/** 商品详情点击回调 */
@property (nonatomic, copy) dispatch_block_t lookDetailBlock;
///* 推荐图片数组 */
//@property (copy , nonatomic)NSArray *goodExceedArray;
-(void)loadDataWithNSString:(NSString *)exceedPath and:(NSMutableArray<ADStarGoodsModel *> *)goodExceedItem;

@end
