//
//  ADGoodsParameterViewModel.h
//  AdelMall
//
//  Created by apple on 2018/4/18.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADGoodsParameterViewModel : NSObject

@property (nonatomic,readonly)UIScrollView *parameterView;//懒加载使用，外部需要设定frame
- (void)layoutWithProperty:(NSArray *)propertyies;

@end
