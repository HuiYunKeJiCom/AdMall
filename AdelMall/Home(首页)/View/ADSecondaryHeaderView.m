//
//  ADSecondaryHeaderView.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/6.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import "ADSecondaryHeaderView.h"
#import "ADSaleView.h"

@implementation ADSecondaryHeaderView

{
    UIView * _redLine ;
}
-(void)setItems:(NSArray *)items
{
    _items = items;
    self.viewArr = [NSMutableArray array];
    //先清空当前视图上的所有子视图
    for (UIView * view in self.subviews) {
        [view removeFromSuperview];
    }
    
    //添加按钮
    CGFloat itemWidth = kScreenWidth/items.count;
    CGFloat itemHeight = self.frame.size.height-2;
    
    for (int i = 0; i< items.count;i++ ) {
        
        ADSaleView *saleView = [[ADSaleView alloc]init];
        saleView.frame = CGRectMake(i*itemWidth, 0, itemWidth, itemHeight);
        [saleView setUpDictionary:items[i]];
        saleView.tag = 98+i;
        [self addSubview:saleView];
        [self.viewArr addObject:saleView];
        
        UIButton * buton = [[UIButton alloc]init];
        buton.frame = CGRectMake(i*itemWidth, 0, itemWidth, itemHeight);
//        [buton setTitle:items[i] forState:UIControlStateNormal];
//        buton.titleLabel.font = [UIFont systemFontOfSize:kFontNum15];
//        [buton setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
//        [buton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [buton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
        buton.tag = 78+i;
        [self addSubview:buton];
        
        if (i == 0) {
            saleView.backgroundColor = [UIColor whiteColor];
            [saleView changeTextColor:[UIColor redColor]];
            buton.selected = YES;
        }else{
            saleView.backgroundColor = [UIColor lightGrayColor];
            [saleView changeTextColor:[UIColor whiteColor]];
        }
    }
    
    //加红线
    _redLine = [[UIView alloc]init];
    _redLine.frame = CGRectMake(0, self.frame.size.height-2, itemWidth, 2);
    _redLine.backgroundColor = [UIColor redColor];
    [self addSubview:_redLine];
}

-(void)buttonClick:(UIButton*)button
{
    //获取点击的是第几个button
    NSInteger index = button.tag - 78;
    [self setSelectAtIndex:index];
    
    //2、把事件传递出去
    if (self.itemClickAtIndex) {
        _itemClickAtIndex(index);
    }
}
-(void)setSelectAtIndex:(NSInteger)index
{
    //1、先调整自身的视图显示
    for (int i = 0; i < self.items.count; i++) {
        UIButton * bt = [self viewWithTag:i+78];
        
        if (bt.tag-78 == index) {
            bt.selected = YES;
            
            for (ADSaleView *saleView in self.viewArr) {
                if(index == saleView.tag-98){
                    saleView.backgroundColor = [UIColor whiteColor];
                    [saleView changeTextColor:[UIColor redColor]];
                }else{
                    saleView.backgroundColor = [UIColor lightGrayColor];
                    [saleView changeTextColor:[UIColor whiteColor]];
                }
            }
            
        }else{
            bt.selected = NO;
        }
    }
    //调整红线的位置
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect = _redLine.frame;
        rect.origin.x = index*rect.size.width;
        _redLine.frame = rect;
    }];
}

@end
