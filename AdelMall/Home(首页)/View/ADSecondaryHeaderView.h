//
//  ADSecondaryHeaderView.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/6.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADSecondaryHeaderView : UIView
//外部决定有多少模块
@property (nonatomic,strong) NSArray * items;
//模块View数组
@property (nonatomic,strong) NSMutableArray * viewArr;
//内部选中某一个模块，传递给外部
@property (nonatomic,copy) void(^itemClickAtIndex)(NSInteger index);

//由外部决定选中哪一个模块
-(void)setSelectAtIndex:(NSInteger)index;
-(void)buttonClick:(UIButton*)button;
@end
