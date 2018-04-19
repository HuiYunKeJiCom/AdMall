//
//  ADScoreViewCell.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/12.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADScoreViewCell : UICollectionViewCell
/* 自定义标签 按钮 点击回调 */
@property (nonatomic, copy) dispatch_block_t addLabelButtonClickBlock;
-(void)createLabelAndButtonWithNSArray:(NSArray *)array;
/** 分数字典 */
@property(nonatomic,strong)NSMutableDictionary *scoreDict;
@end
