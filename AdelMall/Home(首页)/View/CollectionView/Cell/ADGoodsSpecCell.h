//
//  ADGoodsSpecCell.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/17.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADGoodsSpecCell : UICollectionViewCell
/** 购买数量 */
@property (nonatomic, assign) int buyNum;
/* openView 点击回调 */
@property (nonatomic, copy) dispatch_block_t openViewClickBlock;
/* closeView 点击回调 */
@property (nonatomic, copy) dispatch_block_t closeViewClickBlock;
@property (nonatomic, strong) NSMutableArray *goodAttrsArr;
- (void)createAttributesViewWith:(NSMutableArray *)array;
@end
