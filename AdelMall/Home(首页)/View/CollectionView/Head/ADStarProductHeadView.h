//
//  ADStarProductHeadView.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/2/28.
//  Copyright © 2018年 Adel. All rights reserved.
//  商城-明星产品

#import <UIKit/UIKit.h>

@interface ADStarProductHeadView : UICollectionReusableView
/* 设置标题 */
-(void)setTopTitleWithNSString:(NSString *)string;
/** 商品详情点击回调 */
@property (nonatomic, copy) dispatch_block_t lookAllBlock;
@end
