//
//  EdgeInsetsLabel.m
//  EdgeInsetsLabel
//
//  Created by 蔡强 on 2017/12/6.
//  Copyright © 2017年 kuaijiankang. All rights reserved.
//

#import "EdgeInsetsLabel.h"

@implementation EdgeInsetsLabel

- (void)setContentInset:(UIEdgeInsets)contentInset {
    _contentInset = contentInset;
    
    [self setNeedsDisplay];
}

-(void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.contentInset)];
}

- (void)sizeToFit {
    
}

@end
