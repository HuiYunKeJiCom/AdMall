//
//  ADGoodsParameterViewModel.m
//  AdelMall
//
//  Created by apple on 2018/4/18.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import "ADGoodsParameterViewModel.h"

@interface ADGoodsParameterViewModel()


@end

@implementation ADGoodsParameterViewModel
@synthesize parameterView = _parameterView;

- (UIScrollView *)parameterView{
    if (!_parameterView) {
        _parameterView = [[UIScrollView alloc]initWithFrame:CGRectZero];
    }
    return _parameterView;
}

@end
