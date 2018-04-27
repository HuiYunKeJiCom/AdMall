//
//  ADRelatedGoodsViewModel.h
//  AdelMall
//
//  Created by apple on 2018/4/19.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCClassGoodsItem.h"
#import "ADGoodsModel.h"

#define ADRelateGoodLayout_ImgSize CGSizeMake(180.f,120.f)
#define ADRelateGoodLayout_ImgLeftMargin 30.f
#define ADRelateGoodLayout_ImgRightMargin 30.f
#define ADRelateGoodLayout_ImgTopMargin 30.f

#define ADRelateGoodLayout_NameFont 16.f
#define ADRelateGoodLayout_PriceFont 12.f

#define ADRelateGoodLayout_RightMargin 12.f

/*
    create by CTO
 */
@interface ADRelatedGoodsLayout : NSObject

@property (nonatomic,strong)ADGoodsModel *item;//持有的数据

@property (nonatomic,assign)CGFloat height;//高度

@property (nonatomic,strong)NSAttributedString *string1;//
@property (nonatomic,strong)NSAttributedString *string2;//
@property (nonatomic,strong)NSAttributedString *string3;//
@property (nonatomic,strong)NSAttributedString *string4;//

@property (nonatomic,assign)CGSize string1Size;//
@property (nonatomic,assign)CGSize string2Size;//
@property (nonatomic,assign)CGSize string3Size;//
@property (nonatomic,assign)CGSize string4Size;//

@property (nonatomic,assign)CGFloat string1Top;//
@property (nonatomic,assign)CGFloat string2Top;//
@property (nonatomic,assign)CGFloat string3Top;//
@property (nonatomic,assign)CGFloat string4Top;//



+ (instancetype)layoutWithGoodsItem:(ADGoodsModel *)goodsItem;

- (void)layout;//计算布局

@end
