//
//  ADRelatedGoodsViewModel.m
//  AdelMall
//
//  Created by apple on 2018/4/19.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import "ADRelatedGoodsLayout.h"

@implementation ADRelatedGoodsLayout

+ (instancetype)layoutWithGoodsItem:(ADGoodsModel *)goodsItem{
    ADRelatedGoodsLayout *layout = [[ADRelatedGoodsLayout alloc]init];
    layout.item = goodsItem;
    [layout layout];
    return layout;
}

- (void)layout{
    _height = 0;
    _height +=ADRelateGoodLayout_ImgTopMargin;
    _height +=ADRelateGoodLayout_ImgSize.height;
    _height +=ADRelateGoodLayout_ImgTopMargin;
    
    _string1 = [[NSAttributedString alloc]initWithString:_item.goods_name attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ADRelateGoodLayout_NameFont]}];
    _string2 = nil;
    
    _string3 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"最低%@",_item.goods_current_price] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ADRelateGoodLayout_NameFont]}];
    
    _string4 = nil;
    
    _string1Size = [_string1 boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    _string2Size = [_string2 boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    _string3Size = [_string3 boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    _string4Size = [_string4 boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    
    _string1Top = ADRelateGoodLayout_ImgTopMargin;
    _string2Top = _string1Top + _string1Size.height + 6.f;
    _string3Top = _string2Top + _string2Size.height + 6.f;
    _string4Top = _string3Top + _string3Size.height + 6.f;
    
    _height = ((_string4Top + _string4Size.height + 6.f)>(ADRelateGoodLayout_ImgTopMargin + ADRelateGoodLayout_ImgSize.height + 6.f))?(_string4Top + _string4Size.height + 6.f):(ADRelateGoodLayout_ImgTopMargin + ADRelateGoodLayout_ImgSize.height + 6.f);
}

@end
