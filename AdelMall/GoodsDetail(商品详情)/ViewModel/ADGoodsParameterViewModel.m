//
//  ADGoodsParameterViewModel.m
//  AdelMall
//
//  Created by apple on 2018/4/18.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import "ADGoodsParameterViewModel.h"
#import "ADPropertyModel.h"

#define labelFont 16.f
#define labelLeftMargin 28.f


@interface ADGoodsParameterViewModel()

@property (nonatomic,strong)UIView *mainView;//

@property (nonatomic,strong)NSMutableArray *labels;//

@property (nonatomic,strong)NSMutableArray *properties;

@end

@implementation ADGoodsParameterViewModel
@synthesize parameterView = _parameterView;

- (UIScrollView *)parameterView{
    if (!_parameterView) {
        _parameterView = [[UIScrollView alloc]initWithFrame:CGRectZero];
        _parameterView.backgroundColor = kBACKGROUNDCOLOR;
        
        _mainView = [[UIView alloc]initWithFrame:CGRectZero];
        _mainView.backgroundColor = [UIColor whiteColor];
        [_parameterView addSubview:_mainView];
        
        
    }
    return _parameterView;
}

- (NSMutableArray *)labels{
    if (!_labels) {
        _labels = [[NSMutableArray alloc]init];
    }
    return _labels;
}

- (void)layoutWithProperty:(NSArray *)propertyies{
    _properties = propertyies.mutableCopy;
    _mainView.width = _parameterView.width;
    _mainView.left = 0;
    _mainView.top = 0;
    
    [self.labels makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.labels removeAllObjects];
    CGFloat topBegin = 28.f;
    for (ADPropertyModel *model in _properties) {
        
        UILabel *labelLeft = [self.class labelCreate];
        [self.labels addObject:labelLeft];
        [self.mainView addSubview:labelLeft];
        labelLeft.text = [NSString stringWithFormat:@"%@:",model.name];
        [labelLeft sizeToFit];
        labelLeft.left = labelLeftMargin;
        labelLeft.top = topBegin;
        
        UILabel *labelRight = [self.class labelCreate];
        [self.labels addObject:labelRight];
        [self.mainView addSubview:labelRight];
        NSString *valStr = nil;
        if ([model.val containsString:@","]) {
            valStr = [model.val replaceString:@"," withString:@"\n"];
            labelRight.numberOfLines = 0;
        }else{
            valStr = model.val;
        }
        labelRight.text = valStr;
        [labelRight sizeToFit];
        labelRight.top = labelLeft.top;
        labelRight.left = labelLeft.right;
        
        topBegin = (labelLeft.bottom > labelRight.bottom)?labelLeft.bottom:labelRight.bottom;
        self.mainView.height = topBegin;
        
    }
    
    self.mainView.height = topBegin + 28.f;
}

- (ADPropertyModel *)propertyModelWithID:(NSString *)ID{
    for (ADPropertyModel *model in _properties) {
        if ([model.idx isEqualToString:ID]) {
            return model;
        }else{
            continue;
        }
    }
    return nil;
}

+ (UILabel *)labelCreate{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.font = [UIFont systemFontOfSize:labelFont];
    label.textColor = [UIColor blackColor];
    return label;
}

@end
