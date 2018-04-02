//
//  AttributeView.m
//  AtMaster
//
//  Created by southfashion on 17/6/12.
//  Copyright © 2017年 李飞飞. All rights reserved.
//
#import "AttributeView.h"
#import "UIView+MJExtension.h"
#import "UIViewExt.h"
#import "ADProsModel.h"

#define AppColor  Color(245, 58, 64)

#define margin 15
// 屏幕的宽
#define JPScreenW [UIScreen mainScreen].bounds.size.width
// 屏幕的高
#define JPScreenH [UIScreen mainScreen].bounds.size.height
//RGB
#define Color(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]


@interface AttributeView ()

@property (nonatomic ,weak) UIButton *btn;
@end

@implementation AttributeView

/**
 *  返回一个创建好的属性视图,并且带有标题.创建好之后必须设置视图的Y值.
 *
 *  @param texts 属性数组
 *
 *  @param viewWidth 视图宽度
 *
 *  @return attributeView
 */
+ (AttributeView *)attributeViewWithTitle:(NSString *)title titleFont:(UIFont *)font attributeTexts:(NSArray *)texts viewWidth:(CGFloat)viewWidth{
    int count = 0;
    float btnW = 0;
    AttributeView *view = [[AttributeView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc]init];
    label.text = [NSString stringWithFormat:@"%@",title];
    view.titleString = [NSString stringWithFormat:@"%@",title];
    label.font = font;
//    label.textColor = Color(160, 160, 160);
    CGSize size=[label.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName ,nil]];
    label.frame = (CGRect){{kBigMargin,10},size};
    [view addSubview:label];
    view.textsArr = texts;
    for (int i = 0; i<texts.count; i++) {
        ADProsModel *model = (ADProsModel *)texts[i];
        UIButton *btn = [[UIButton alloc]init];
        btn.tag = i;
        [btn addTarget:view action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        NSString *str = model.pro_value;
        [btn setTitle:str forState:UIControlStateNormal];
        CGSize strsize = [str sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:13],NSFontAttributeName ,nil]];
        
        btn.width = strsize.width + margin;
        btn.height = strsize.height+ margin;
        
        
        if (i == 0) {
            btn.mj_x = kBigMargin;
            btnW += CGRectGetMaxX(btn.frame);
        }
        else{
            btnW += CGRectGetMaxX(btn.frame)+margin;
            if (btnW > viewWidth) {
                count++;
                btn.mj_x = kBigMargin;
                btnW = CGRectGetMaxX(btn.frame);
            }
            else{
                
                btn.mj_x += btnW - btn.width;
                
            }
        }
        btn.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.15f];
        btn.userInteractionEnabled = YES;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn setTitleColor:Color(104, 97, 97) forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        btn.mj_y += count * (btn.height + margin) + margin + label.height +8;
        
        btn.layer.cornerRadius = btn.height/5;
        
        btn.clipsToBounds = YES;
        btn.tag = i;
        [view addSubview:btn];
        if (i == texts.count - 1) {
            view.height = CGRectGetMaxY(btn.frame) + 10;
            view.mj_x = 0;
            view.width = viewWidth;
        }
    }
    return view;
}

- (void)btnClick:(UIButton *)sender{
    if (![self.btn isEqual:sender]) {
        self.btn.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.15f];
        self.btn.selected = NO;
        sender.backgroundColor = kMAINCOLOR;
        sender.selected = YES;
    }else if([self.btn isEqual:sender]){
        if (sender.selected == YES) {
            sender.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.15f];
            sender.selected = NO;
        }else{
            sender.backgroundColor =  kMAINCOLOR;
            sender.selected = YES;
        }
    }else{
        
    }
    if ([self.Attribute_delegate respondsToSelector:@selector(Attribute_View:didClickBtn:)] ) {
        [self.Attribute_delegate Attribute_View:self didClickBtn:sender];
    }
    self.btn = sender;
}

-(NSArray *)textsArr{
    if (!_textsArr) {
        _textsArr = [NSArray array];
    }
    return _textsArr;
}

@end
