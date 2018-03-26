//
//  MRDropDownView.m
//  test
//
//  Created by 刘入徵 on 2017/4/15.
//  Copyright © 2017年 Mix_Reality. All rights reserved.
//

#import "MRDropDownView.h"
#import "UIView+MRView.h"
#import "ADAddressView.h"
#import "ADAddressShowView.h"

#define kSpace 10
// 筛选框 上下的图片
#define kDownImg [UIImage imageNamed:@"arrow_down.png"]
#define kUpImg [UIImage imageNamed:@"arrow_up.png"]
// 标题字默认大小
#define kTitleFont    15
// 选项字默认大小
#define kOptionFont   16
// 选中字体默认颜色
#define kSeletedColor [UIColor orangeColor]
// 未选中字体默认颜色
#define kNormalColor  [UIColor whiteColor]

#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object)              autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object)              autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object)              try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object)              try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object)            autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object)            autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object)            try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object)            try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif

@interface MRDropDownView ()
@property (nonatomic, strong) ADAddressShowView *addressShowView;
///// 选项标题的 label
//@property (nonatomic, strong) UILabel *titleLabel;
/// 选项标题旁边 显示上下图片
@property (nonatomic, strong) UIImageView *upDownImgView;
/// 当选项栏拉开, bgView 出现
@property (nonatomic, strong) UIView *bgView;
/// 放置选项的 scrollView
@property (nonatomic, strong) UIScrollView *scrollView;
/// 选项数组
@property (nonatomic, strong) NSMutableArray *optionArray;
///// 选中的图片
//@property (nonatomic, strong) UIImageView *rightImgView;
/// 选中的图片
@property (nonatomic, strong) UIView *rightImgView;
/// label array
@property (nonatomic, strong) NSMutableArray *labelArray;
/// scrollView 的 高
@property (nonatomic, assign) CGFloat scrollHeight;
/// 选中索引
@property (nonatomic, assign) NSInteger seletedIndex;
///// 盖住界面的 半透明视图
//@property (nonatomic, strong) UIView *masView;
/// 是否是打开状态
@property (nonatomic, assign) BOOL isOpen;
//// 边框线
//@property (nonatomic, assign) UIView *lineView;

@property (nonatomic, copy) SeletedIndex block;

@property (nonatomic, copy) ViewTapBlock tapBlock;

@end

@implementation MRDropDownView

- (void)dealloc{
    NSLog(@"%@ --> delloc", NSStringFromClass([self class]));
}

- (instancetype)initWithFrame:(CGRect)frame andOptions:(NSMutableArray *)options{
    
    if(self = [super initWithFrame:frame]){
        
        self.userInteractionEnabled = YES;
        self.optionArray = options;
        [self createUI];
        // 点击
        @weakify(self);
        [self tapActionWithBlock:^{
            @strongify(self);
            if(self.isOpen == NO){
                [self openBgView];
            }else{
                [self closeBgView];
            }
//            static dispatch_once_t disOnce;
//            dispatch_once(&disOnce,^ {
//                //只执行一次的代码
//                [self openBgView];
//                self.scrollView.frame = CGRectMake(0, 0, kWidth, 0);
//            });


            
            /// 遍历
            @weakify(self);
            [self.labelArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                @strongify(self);
                if(idx == self.seletedIndex){
//                    ((UILabel *)obj).textColor = self.seletedColor;
                    self.rightImgView.centerY = ((ADAddressView *)obj).centerY;
                }else{
//                    ((UILabel *)obj).textColor = self.normalColor;
                }
            }];
            
            [UIView animateWithDuration:.25 animations:^{
                self.scrollView.height = self.scrollHeight;
            } completion:^(BOOL finished) {
            }];
        }];
    }
    return self;
}

-(void)createUI{
    [self addSubview:self.addressShowView];
    [self addSubview:self.upDownImgView];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    // 标题字大小
//    CGFloat titleFont = self.titleFont ? self.titleFont : kOptionFont;
    // 选中颜色
//    UIColor *seletedTextColor = self.seletedColor ? self.seletedColor : kSeletedColor;
    
//    self.titleLabel.font = [UIFont systemFontOfSize:titleFont];
//    self.titleLabel.textColor = seletedTextColor;
    
    [self _initUIWithOptions:self.optionArray];
//    [self addSubview:self.lineView];
}

// MARK: 根据选项设置 scrollView
- (void)_initUIWithOptions:(NSMutableArray *)options{
    
    if(options.count < 5)
        self.scrollHeight = options.count * 60;
    else
        self.scrollHeight = 4 * 60;
    
    CGFloat imgWidth = 15;
    self.upDownImgView.size = CGSizeMake(imgWidth, imgWidth);
    
    ADAddressView *temp = self.optionArray[self.seletedIndex];
    // 更新 标题
    self.addressShowView.model = temp.model;
//    [self.addressView.titleLab sizeToFit];
//    self.addressView.centerY = self.height / 2;
//    self.addressView.centerX = kWidth;
//    self.titleLabel.text = self.optionArray[self.seletedIndex];
//    [self.titleLabel sizeToFit];
//    self.titleLabel.centerY = self.height / 2;
//    self.titleLabel.centerX = self.width / 2 - 10;
    
    // 设置 上下图片的 frame
//    self.upDownImgView.left = self.titleLabel.left + self.titleLabel.width + 5;
    self.upDownImgView.left = kScreenWidth - imgWidth*2;
    self.upDownImgView.centerY = self.height / 2;
}

- (void)didseletedWithBlock:(SeletedIndex)block{
    self.block = block;
}

/// 点击蒙版视图调用的 block
- (void)clickBackGroundBlock:(ViewTapBlock)block{
    self.tapBlock = block;
}

- (void)clickBgView{
    if(self.tapBlock)
        self.tapBlock();
    else
        [self closeBgView];
}

// MARK: 关闭背景视图
- (void)closeBgView{
    NSLog(@"closeBgView");
    self.bgView.hidden = YES;
    self.upDownImgView.image = kDownImg;
//    self.scrollView = nil;
    self.scrollView.hidden = YES;
//    self.masView.hidden = YES;
    self.isOpen = NO;
    !_closeViewClickBlock ? : _closeViewClickBlock();
}

// MARK: 打开背景视图
- (void)openBgView{
    NSLog(@"openBgView");
    self.bgView.hidden = NO;
    self.upDownImgView.image = kUpImg;
    //    self.scrollView = nil;
    self.scrollView.hidden = NO;
    //    self.masView.hidden = YES;
    self.scrollView.frame = CGRectMake(0, 0, kScreenWidth, 0);
    self.isOpen = YES;
    !_openViewClickBlock ? : _openViewClickBlock();
}

// MARK: 懒加载
//- (UILabel *)titleLabel{
//    if(!_titleLabel){
//        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//        [self addSubview:_titleLabel];
//    }
//    return _titleLabel;
//}

- (ADAddressShowView *)addressShowView{
    if(!_addressShowView){
        _addressShowView = [[ADAddressShowView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    }
    return _addressShowView;
}


- (UIImageView *)upDownImgView{
    if(!_upDownImgView){
        _upDownImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
//        [self addSubview:_upDownImgView];
        _upDownImgView.image = kDownImg;
    }
    return _upDownImgView;
}

- (UIView *)bgView{
    if(!_bgView){
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.top + self.height + .5, kScreenWidth, 4*60)];
        [self.superview addSubview:_bgView];
        _bgView.backgroundColor = [UIColor clearColor];
 
    }
    return _bgView;
}

- (UIScrollView *)scrollView{
    if(!_scrollView){
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
        [self.bgView addSubview:_scrollView];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.clipsToBounds = YES;
        _scrollView.contentSize = CGSizeMake(kScreenWidth, self.optionArray.count * 60);
        _scrollView.showsVerticalScrollIndicator = NO;
        
        // 创建选项
        for (NSInteger i = 0; i < self.optionArray.count; i++) {
            
            ADAddressView *addressView = self.optionArray[i];
            addressView.frame = CGRectMake(0,i * 60, kScreenWidth, 60);
            [self.labelArray addObject:addressView];
            [_scrollView addSubview:addressView];
//            label.text = self.optionArray[i];
            addressView.userInteractionEnabled = YES;
            addressView.tag = 100 + i;

            // MARK: label 点击事件
            @weakify(self);
            [addressView tapActionWithBlock:^{
                @strongify(self);
                NSInteger index = addressView.tag - 100;
                self.seletedIndex = index;
                ADAddressView *temp = self.optionArray[self.seletedIndex];
                // 更新 标题
                self.addressShowView.model = temp.model;
//                [self.addressView.titleLab sizeToFit];
//                self.titleLabel.text = self.optionArray[self.seletedIndex];
//                [self.titleLabel sizeToFit];
//                self.titleLabel.centerY = self.height / 2;

                CGFloat imgWidth = 15;
                // 设置 上下图片的 frame
                self.upDownImgView.left = kScreenWidth - imgWidth*2;
                self.upDownImgView.centerY = self.height / 2;
                [self layoutSubviews];
                // 关闭 背景视图
                [self closeBgView];

                if(self.block)
                    self.block(self.tag, index);
            }];
            
            // 如果是选中索引, 变颜色
            if(i == self.seletedIndex){
                
//                if(!_seletedColor)
//                    self.seletedColor = [UIColor orangeColor];
//
//                label.textColor = self.seletedColor;
            
//                self.rightImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth - kSpace - 16, i * 40 + 12, 16, 16)];
                self.rightImgView = [[UIView alloc] initWithFrame:CGRectMake(1, i * 60, kScreenWidth-2, 60)];
//                self.rightImgView.image = [UIImage imageNamed:@"seleted_right.png"];
                UIImageView *selectIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, i * 60, 16, 16)];
                selectIV.image = [UIImage imageNamed:@"checked.png"];
                [self.rightImgView addSubview:selectIV];
                //设置layer
                CALayer *layer=[self.rightImgView layer];
                [layer setMasksToBounds:YES];
                //设置边框线的宽
                [layer setBorderWidth:1];
                //设置边框线的颜色
                [layer setBorderColor:[[UIColor redColor] CGColor]];
                [_scrollView addSubview:self.rightImgView];
            }
        }
    }
    return _scrollView;
}

- (NSMutableArray *)labelArray{
    if(!_labelArray){
        _labelArray = [NSMutableArray array];
    }
    return _labelArray;
}

@end

