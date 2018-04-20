//
//  DCSlideshowHeadView.h
//  CDDMall
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//  商城-轮播图

#import <UIKit/UIKit.h>

static const NSString *DCSlideshowHeadViewID = @"DCSlideshowHeadViewID";

@interface DCSlideshowHeadView : UICollectionReusableView

/* 轮播图数组 */
@property (copy , nonatomic)NSArray *imageGroupArray;
-(void)loadDataWithArray:(NSArray *)imageGroupArray;
@end
