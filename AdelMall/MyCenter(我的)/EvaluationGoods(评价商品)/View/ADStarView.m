//
//  ADStarView.m
//  StarRating
//
//  Created by 张锐凌 on 2018/1/29.
//  Copyright © 2018年 huiyun. All rights reserved.
//

#import "ADStarView.h"
#import "UIView+Extension.h"
#import "GQGesVCTransition.h"
//#import "Global.h"

@interface ADStarView()

/** 星星1 */
@property(nonatomic,strong)UIImageView *starOne;
/** 星星2 */
@property(nonatomic,strong)UIImageView *starTwo;
/** 星星3 */
@property(nonatomic,strong)UIImageView *starThree;
/** 星星4 */
@property(nonatomic,strong)UIImageView *starFour;
/** 星星5 */
@property(nonatomic,strong)UIImageView *starFive;

@end

@implementation ADStarView{
//判断是否添加星星
    BOOL _isAddStar;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.starOne];
        [self addSubview:self.starTwo];
        [self addSubview:self.starThree];
        [self addSubview:self.starFour];
        [self addSubview:self.starFive];
        [self makeConstraints];
        [self disableGQVCTransition];
    }
    
    return self;
}

- (void)makeConstraints {
    WEAKSELF
    [self.starOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(10);
        make.top.equalTo(weakSelf).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(27,27));
    }];
    
    [self.starTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.starOne).with.offset(40);
        make.centerY.equalTo(weakSelf.starOne);
        make.size.mas_equalTo(CGSizeMake(27,27));
    }];
    
    [self.starThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.starTwo).with.offset(40);
        make.centerY.equalTo(weakSelf.starOne);
        make.size.mas_equalTo(CGSizeMake(27,27));
    }];
    
    [self.starFour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.starThree).with.offset(40);
        make.centerY.equalTo(weakSelf.starOne);
        make.size.mas_equalTo(CGSizeMake(27,27));
    }];
    
    [self.starFive mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.starFour).with.offset(40);
        make.centerY.equalTo(weakSelf.starOne);
        make.size.mas_equalTo(CGSizeMake(27,27));
    }];
}

- (UIImageView *)starOne {
    if (!_starOne) {
        //        _bgImgView = [[UIImageView alloc] initWithImage:IMAGE(@"bg_home")];
        _starOne = [[UIImageView alloc] initWithImage:IMAGE(@"pingjia_xing_white")];
    }
    return _starOne;
}

- (UIImageView *)starTwo {
    if (!_starTwo) {
        //        _bgImgView = [[UIImageView alloc] initWithImage:IMAGE(@"bg_home")];
        _starTwo = [[UIImageView alloc] initWithImage:IMAGE(@"pingjia_xing_white")];
    }
    return _starTwo;
}

- (UIImageView *)starThree {
    if (!_starThree) {
        //        _bgImgView = [[UIImageView alloc] initWithImage:IMAGE(@"bg_home")];
        _starThree = [[UIImageView alloc] initWithImage:IMAGE(@"pingjia_xing_white")];
    }
    return _starThree;
}

- (UIImageView *)starFour {
    if (!_starFour) {
        //        _bgImgView = [[UIImageView alloc] initWithImage:IMAGE(@"bg_home")];
        _starFour = [[UIImageView alloc] initWithImage:IMAGE(@"pingjia_xing_white")];
    }
    return _starFour;
}

- (UIImageView *)starFive {
    if (!_starFive) {
        //        _bgImgView = [[UIImageView alloc] initWithImage:IMAGE(@"bg_home")];
        _starFive = [[UIImageView alloc] initWithImage:IMAGE(@"pingjia_xing_white")];
    }
    return _starFive;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if((point.x > self.starOne.x && point.x < (self.starFive.x + self.starFive.width))&&(point.y > self.starOne.y && point.y< self.height)){
        _isAddStar = YES;
        
    }else{
        _isAddStar = NO;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if(_isAddStar){
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self];
        [self setStarForegroundViewWithPoint:point];
        
    }

    return;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if(_isAddStar){
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self];
        [self setStarForegroundViewWithPoint:point];
    }
    _isAddStar = NO;
    return;
}

-(void)setStarForegroundViewWithPoint:(CGPoint)point{
    
    self.score = 0;
    self.score = self.score + [self changeImg:point.x image:self.starOne];
    self.score = self.score + [self changeImg:point.x image:self.starTwo];
    self.score = self.score + [self changeImg:point.x image:self.starThree];
    self.score = self.score + [self changeImg:point.x image:self.starFour];
    self.score = self.score + [self changeImg:point.x image:self.starFive];
    
    //评论最少半星
    if(self.score == 0){
        self.score = 1;
        [self.starOne setImage:[UIImage imageNamed:@"pingjia_xing_red"]];
    }
    NSLog(@"分数 %ld",(long)self.score);
    
    NSString *myKey;
    
    switch (self.tag) {
        case 1:
            myKey = @"packEvaluate";
            break;
        case 2:
            myKey = @"serviceEvaluate";
            break;
        case 3:
            myKey = @"descriptionEvaluate";
            break;
        case 4:
            myKey = @"shipEvaluate";
            break;
            
        default:
            break;
    }
    
    NSDictionary *dict = @{myKey:[NSString stringWithFormat:@"%ld",(long)self.score]};

    //创建通知
    NSNotification *notification =[NSNotification notificationWithName:@"score" object:nil userInfo:dict];
    //通过通知中心发送通知
    NSLog(@"评价发通知了");
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
}


-(CGFloat)changeImg:(float)x image:(UIImageView*)img{
    if(x > img.x + img.width/2){
        [img setImage:[UIImage imageNamed:@"pingjia_xing_red"]];
        return 1;
//    }else if(x > img.x){
//        [img setImage:[UIImage imageNamed:@"pingjia_xing_red"]];
//        return 0.5;
    }else{
        [img setImage:[UIImage imageNamed:@"pingjia_xing_white"]];
        return 0;
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
