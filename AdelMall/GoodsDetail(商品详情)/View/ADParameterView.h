//
//  ADParameterView.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/2/8.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ADPropertyModel;
@interface ADParameterView : UIView
/** 商品参数[{“val”:”参数值”,”id”:”2”,”name”:”参数名}] */
//@property (nonatomic, strong) NSArray<ADPropertyModel *>      *goodsProperty;
-(void)createLabelsWithGoodsProperty:(NSArray<ADPropertyModel *> *)goodsProperty;
@end
