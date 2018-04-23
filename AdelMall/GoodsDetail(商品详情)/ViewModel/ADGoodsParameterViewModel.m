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

@interface ADGoodsParameterViewModel()

@property (nonatomic,strong)UIView *mainView;//

@property (nonatomic,strong)UILabel *labelOneLeft;
@property (nonatomic,strong)UILabel *labelOneRight;
@property (nonatomic,strong)UILabel *labelTwoLeft;
@property (nonatomic,strong)UILabel *labelTwoRight;
@property (nonatomic,strong)UILabel *labelThreeLeft;
@property (nonatomic,strong)UILabel *labelThreeRight;

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
        
        _labelOneLeft = [self.class labelCreate];
        _labelOneRight = [self.class labelCreate];
        _labelTwoLeft = [self.class labelCreate];
        _labelTwoRight = [self.class labelCreate];
        _labelThreeLeft = [self.class labelCreate];
        _labelThreeRight = [self.class labelCreate];
        _labelThreeRight.numberOfLines = 0;
        
        [_mainView addSubview:_labelOneLeft];
        [_mainView addSubview:_labelOneRight];
        [_mainView addSubview:_labelTwoLeft];
        [_mainView addSubview:_labelTwoRight];
        [_mainView addSubview:_labelThreeLeft];
        [_mainView addSubview:_labelThreeRight];
        
    }
    return _parameterView;
}

- (void)layoutWithProperty:(NSArray *)propertyies{
    _properties = propertyies.mutableCopy;
    _mainView.width = _parameterView.width;
    _mainView.left = 0;
    _mainView.top = 0;
    
    ADPropertyModel *brandModel = [self propertyModelWithID:@"2"];
    _labelOneLeft.text = [NSString stringWithFormat:@"%@:",brandModel.name];
    [_labelOneLeft sizeToFit];
    _labelOneLeft.top = 28.f;
    _labelOneLeft.left = 28.f;
    
    _labelOneRight.text = brandModel.val;
    [_labelOneRight sizeToFit];
    _labelOneRight.center = _labelOneLeft.center;
    _labelOneRight.left = _labelOneLeft.right;
    
    ADPropertyModel *typeModel = [self propertyModelWithID:@"1"];
    _labelTwoLeft.text = [NSString stringWithFormat:@"%@:",typeModel.name];
    [_labelTwoLeft sizeToFit];
    _labelTwoLeft.top = _labelOneLeft.bottom + 6.f;
    _labelTwoLeft.left = _labelOneLeft.left;
    
    _labelTwoRight.text = typeModel.val;
    [_labelTwoRight sizeToFit];
    _labelTwoRight.center = _labelTwoLeft.center;
    _labelTwoRight.left = _labelTwoLeft.right;
    
    ADPropertyModel *colorModel = [self propertyModelWithID:@"3"];
    NSString *colorStr = [colorModel.val replaceString:@"," withString:@"\n"];
    _labelThreeLeft.text = [NSString stringWithFormat:@"%@:",colorModel.name];
    [_labelThreeLeft sizeToFit];
    _labelThreeLeft.top = _labelTwoLeft.bottom + 6.f;
    _labelThreeLeft.left = _labelTwoLeft.left;
    
    _labelThreeRight.text = colorStr;
    [_labelThreeRight sizeToFit];
    _labelThreeRight.top = _labelThreeLeft.top;
    _labelThreeRight.left = _labelThreeLeft.right;
    
    _mainView.height = _labelThreeRight.bottom + 20.f;
    _parameterView.contentSize = CGSizeMake(_parameterView.width, _mainView.bottom);
    
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
