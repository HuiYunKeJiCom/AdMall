//
//  ADDetailViewModel.h
//  ScrollView_Nest
//
//  Created by apple on 2018/4/4.
//  Copyright © 2018年 1911. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADDetailViewModel : NSObject

@property (nonatomic,readonly)UICollectionView *detailView;//相当于一个工厂方法，可以直接提取使用，加载到外部的view上，内部实现为懒加载。注意，初始的frame为(0,0,0,0)，需要重新设置frame


/*
    add by CTO
    测试git
    123321
    1234567
 
 */




@end
