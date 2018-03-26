//
//  ADStarView.h
//  StarRating
//
//  Created by 张锐凌 on 2018/1/29.
//  Copyright © 2018年 huiyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADStarView : UIView

//+ (instancetype)loadStarView;
- (instancetype)initWithFrame:(CGRect)frame;
@property (nonatomic, assign) CGFloat score;
@end
