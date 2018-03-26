//
//  ADEvaluateDetailCell.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/8.
//  Copyright © 2018年 Adel. All rights reserved.
//  商品详情-用户评论-评论详情-评论cell

#import "ADEvaluateDetailCell.h"

@interface ADEvaluateDetailCell()<UIScrollViewDelegate>
@property (nonatomic, strong) UIView           *bgView;
/** 用户头像 */
@property(nonatomic,strong)UIImageView *headerIV;
/** 用户名称 */
@property(nonatomic,strong)UILabel *userNameLab;
/** 购买日期标题 */
@property(nonatomic,strong)UILabel *purchaseDateTitLab;
/** 购买日期 */
@property(nonatomic,strong)UILabel *purchaseDateLab;
/** 评论内容 */
@property(nonatomic,strong)UILabel *contentLab;
/** 评论图片 */
@property(nonatomic,strong)UIScrollView *imageViewScrollView;

// 传过来的数据
@property (nonatomic, strong) NSArray *datas;
// 当前界面的索引 从0开始，最大值为传过来的资源数量减1
@property (nonatomic, assign) NSInteger pageIndex;
// 用于存放当前界面中的三个元素
@property (nonatomic, strong) NSMutableArray *tempDatas;
// 当前视图的最右边的偏移量，用以判断当前视图是否离开了屏幕（查看下一页时）
@property (nonatomic, assign) CGFloat leftOffsetY;
// 当前视图的最左边的偏移量，用以判断当前视图是否离开了屏幕（查看上一页时）
@property (nonatomic, assign) CGFloat rightOffsetY;
// startContentOffsetX和willEndContentOffsetX是用来判断向左还是向右的。这里，我将查看下一页定义为向右，反之向左
@property (nonatomic, assign) CGFloat startContentOffsetY;
@property (nonatomic, assign) CGFloat willEndContentOffsetY;



@property (nonatomic, assign) BOOL isDragged;
@end

#define kScrollViewWidth   kScreenWidth-20

#define kScrollViewHeight  180

@implementation ADEvaluateDetailCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.pageIndex = 0;
        self.datas = @[@"ico_my_chat",@"sort_down",@"shopCar_down",@"home_down"];
        _isDragged = NO;
        [self setUpUI];
        [self setUpData];
    }
    return self;
}

- (void)setUpUI{
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.headerIV];
    [self.bgView addSubview:self.userNameLab];
    [self.bgView addSubview:self.purchaseDateTitLab];
    [self.bgView addSubview:self.purchaseDateLab];
    [self.bgView addSubview:self.contentLab];
    [self.bgView addSubview:self.imageViewScrollView];
    [self createLabelAndButton];
}

-(void)createLabelAndButton{
    for(int i=0;i<2;i++){
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        button.backgroundColor = button.tag == 0 ? [UIColor cyanColor] : [UIColor lightGrayColor];
        button.userInteractionEnabled = NO;
        [button setTitle:@"商品包装好看" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:kFontNum14];
        CGFloat buttonW = kScreenWidth/3.5;
        CGFloat buttonH = 20;
        CGFloat buttonX = (20+(buttonW +10)* (i%3));
        CGFloat buttonY = (70+25 * (i/3));
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        button.layer.borderWidth=0.5;
        button.layer.borderColor=[UIColor grayColor].CGColor;
        // 设置圆角的大小
        button.layer.cornerRadius = 5;
        [button.layer setMasksToBounds:YES];
        [self.bgView addSubview:button];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self makeConstraints];
}

#pragma mark - 填充数据
-(void)setUpData{
    self.userNameLab.text = @"Pakho";
    self.purchaseDateTitLab.text = @"购买日期：";
    self.purchaseDateLab.text = @"2017-01-01";
    self.contentLab.text = @"第一次购买爱迪尔门锁，质量好的没的说，期望平台能有更多的活动优惠。第一次购买爱迪尔门锁，质量好的没的说，期望平台能有更多的活动优惠。第一次购买爱迪尔门锁，质量好的没的说，期望平台能有更多的活动优惠。";
    
    self.imageViewScrollView.contentSize = CGSizeMake(0, kScrollViewHeight*self.datas.count);
    // 根据传过来的pageIndex进行初始化
    [self configImages];
    // 根据传过来的page索引值去初始化scrollView的偏移量
    [self.imageViewScrollView setContentOffset:CGPointMake(0, kScrollViewHeight*self.pageIndex)];
}

- (void)makeConstraints {
    WEAKSELF
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.top.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf.mas_bottom);
    }];
    
    [self.headerIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(10);
        make.top.equalTo(weakSelf.bgView.mas_top).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [self.userNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.headerIV.mas_right).with.offset(10);
        make.centerY.equalTo(weakSelf.headerIV.mas_centerY);
    }];
    
    [self.purchaseDateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.bgView.mas_right).with.offset(-15);
        make.centerY.equalTo(weakSelf.headerIV.mas_centerY);
    }];
    
    [self.purchaseDateTitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.purchaseDateLab.mas_left);
        make.centerY.equalTo(weakSelf.headerIV.mas_centerY);
    }];
    
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(20);
        make.right.equalTo(weakSelf.bgView.mas_right).with.offset(-30);
        make.top.equalTo(weakSelf.headerIV.mas_bottom).with.offset(40);
    }];
    
    [self.imageViewScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(10);
        make.right.equalTo(weakSelf.bgView.mas_right).with.offset(-10);
        make.top.equalTo(weakSelf.contentLab.mas_bottom).with.offset(10);
        make.bottom.equalTo(weakSelf.bgView.mas_bottom).with.offset(-20);
    }];
    
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectZero];
        _bgView.backgroundColor = k_UIColorFromRGB(0xffffff);
    }
    return _bgView;
}

-(UIImageView *)headerIV{
    if (!_headerIV) {
        _headerIV = [[UIImageView alloc] init];
        [_headerIV setBackgroundColor:[UIColor greenColor]];
        [_headerIV setContentMode:UIViewContentModeScaleAspectFill];
        // 设置圆角的大小
        _headerIV.layer.cornerRadius = 5;
        [_headerIV.layer setMasksToBounds:YES];
    }
    return _headerIV;
}

- (UILabel *)userNameLab {
    if (!_userNameLab) {
        _userNameLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor blackColor]];
    }
    return _userNameLab;
}

- (UILabel *)purchaseDateTitLab {
    if (!_purchaseDateTitLab) {
        _purchaseDateTitLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor lightGrayColor]];
    }
    return _purchaseDateTitLab;
}

- (UILabel *)purchaseDateLab {
    if (!_purchaseDateLab) {
        _purchaseDateLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor lightGrayColor]];
    }
    return _purchaseDateLab;
}

- (UILabel *)contentLab {
    if (!_contentLab) {
        _contentLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor blackColor]];
        _contentLab.numberOfLines = 0;
    }
    return _contentLab;
}

- (UIScrollView *)imageViewScrollView {
    if (!_imageViewScrollView) {
        _imageViewScrollView = [[UIScrollView alloc]initWithFrame:CGRectZero];
        _imageViewScrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//        _imageViewScrollView.backgroundColor = [UIColor redColor];
        _imageViewScrollView.showsVerticalScrollIndicator = NO;
        _imageViewScrollView.showsHorizontalScrollIndicator = NO;
        _imageViewScrollView.delegate = self;
        _imageViewScrollView.directionalLockEnabled = YES;
        _imageViewScrollView.pagingEnabled = YES;
    }
    return _imageViewScrollView;
}

- (instancetype)initWithWithPageIndex:(NSInteger)pageIndex
                            withDatas:(NSArray *)datas {
    self = [super init];
    if (self) {
        self.pageIndex = pageIndex;
        self.datas = datas;
        _isDragged = NO;
    }
    return self;
}

- (NSMutableArray *)tempDatas {
    if (!_tempDatas) {
        _tempDatas = [NSMutableArray arrayWithCapacity:3];
    }
    return _tempDatas;
}

- (UIImageView *)configImageViewWithImage:(UIImage *)image withFrame:(CGRect)frame {

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = image;
    return imageView;
    
}

- (void)configImages {
    NSLog(@"self.datas = %@",self.datas);
    UIImageView *firstImageView = nil;
    UIImageView *secondImageView = nil;
    UIImageView *thirdImageView = nil;

    // 当图片的数量小于三个情况 UIScrollView把图片都加载出来展示
    if (self.datas.count <= 3) {
        firstImageView = [self configImageViewWithImage:[UIImage imageNamed:[self.datas firstObject]] withFrame:CGRectMake(0, 0, kScrollViewWidth, kScrollViewHeight)];
        [self.imageViewScrollView addSubview:firstImageView];

        if (self.datas.count >= 2) {
            secondImageView = [self configImageViewWithImage:[UIImage imageNamed:[self.datas objectAtIndex:1]] withFrame:CGRectMake(0, kScrollViewHeight, kScrollViewWidth, kScrollViewHeight)];
            [self.imageViewScrollView addSubview:secondImageView];

            if (self.datas.count >= 3) {
                thirdImageView = [self configImageViewWithImage:[UIImage imageNamed:[self.datas objectAtIndex:2]] withFrame:CGRectMake(0, kScrollViewHeight*2, kScrollViewWidth, kScrollViewHeight)];
                [self.imageViewScrollView addSubview:thirdImageView];
            }
        }
    }
    // 当图片数量大于三个的情况下 根据索引值 初始化三个视图，然后放在scrollView上面
    else {
        if (self.pageIndex < 2) { // 当索引值小于2的情况，初始化所有图片的前三个
            secondImageView = [self configImageViewWithImage:[UIImage imageNamed:[self.datas objectAtIndex:1]] withFrame:CGRectMake(0, kScrollViewHeight, kScrollViewWidth, kScrollViewHeight)];
            [self.imageViewScrollView addSubview:secondImageView];

            firstImageView = [self configImageViewWithImage:[UIImage imageNamed:[self.datas firstObject]] withFrame:CGRectMake(0, 0, kScrollViewWidth, kScrollViewHeight)];
            [self.imageViewScrollView addSubview:firstImageView];

            thirdImageView = [self configImageViewWithImage:[UIImage imageNamed:[self.datas objectAtIndex:2]] withFrame:CGRectMake(0, kScrollViewHeight*2, kScrollViewWidth, kScrollViewHeight)];
            [self.imageViewScrollView addSubview:thirdImageView];
        }
        else if (self.pageIndex > self.datas.count-3) { // 初始化所有新源的最后三个

            secondImageView = [self configImageViewWithImage:[UIImage imageNamed:[self.datas objectAtIndex:self.datas.count-2]] withFrame:CGRectMake(0, kScrollViewHeight*(self.datas.count-2), kScrollViewWidth, kScrollViewHeight)];
            [self.imageViewScrollView addSubview:secondImageView];

            firstImageView = [self configImageViewWithImage:[UIImage imageNamed:[self.datas objectAtIndex:self.datas.count-3]] withFrame:CGRectMake(0, kScrollViewHeight*(self.datas.count-3), kScrollViewWidth, kScrollViewHeight)];
            [self.imageViewScrollView addSubview:firstImageView];

            thirdImageView = [self configImageViewWithImage:[UIImage imageNamed:[self.datas objectAtIndex:self.datas.count-1]] withFrame:CGRectMake(0, kScrollViewHeight*(self.datas.count-1), kScrollViewWidth, kScrollViewHeight)];
            [self.imageViewScrollView addSubview:thirdImageView];

        }
        else { // 初始化索引值及其所有的图片内容

            secondImageView = [self configImageViewWithImage:[UIImage imageNamed:[self.datas objectAtIndex:self.pageIndex]] withFrame:CGRectMake(0, kScrollViewHeight*self.pageIndex, kScrollViewWidth, kScrollViewHeight)];
            [self.imageViewScrollView addSubview:secondImageView];

            firstImageView = [self configImageViewWithImage:[UIImage imageNamed:[self.datas objectAtIndex:self.pageIndex-1]] withFrame:CGRectMake(0, kScrollViewHeight*(self.pageIndex-1), kScrollViewWidth, kScrollViewHeight)];
            [self.imageViewScrollView addSubview:firstImageView];

            thirdImageView = [self configImageViewWithImage:[UIImage imageNamed:[self.datas objectAtIndex:self.pageIndex+1]] withFrame:CGRectMake(0, kScrollViewHeight*(self.pageIndex+1), kScrollViewWidth, kScrollViewHeight)];
            [self.imageViewScrollView addSubview:thirdImageView];
        }
    }
    
    // 这里添加的顺序要注意，不是随便添加的
    [self.tempDatas addObject:firstImageView];
    if (secondImageView != nil) {
        [self.tempDatas addObject:secondImageView];
    }
    if (thirdImageView != nil) {
        [self.tempDatas addObject:thirdImageView];
    }

    self.leftOffsetY = kScrollViewHeight*(self.pageIndex+1);
    
    self.rightOffsetY = kScrollViewHeight*self.pageIndex;

//    // 刚开始点击了第几张
//
//    self.title = [NSString stringWithFormat:@"第 %ld 张", self.pageIndex+1];
}

#pragma mark == UIScrollViewDelegate ==
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

    self.isDragged = YES;
    // 拖拽图片的起始偏移量
    self.startContentOffsetY = scrollView.contentOffset.y;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    // 将要停止拖拽时 scrollView偏移的位置
    self.willEndContentOffsetY = scrollView.contentOffset.y;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.isDragged) {
        BOOL directionRight;
        CGFloat currentOffsetY = scrollView.contentOffset.y;
        if (currentOffsetY > self.willEndContentOffsetY && self.willEndContentOffsetY > self.startContentOffsetY) {
            directionRight = YES; // scrollView向右偏移 向下
            // 当前是第几张
            int currentPage = ceil(scrollView.contentOffset.y/CGRectGetHeight(scrollView.frame))+1;
            
            if (currentPage <= self.datas.count) {
//                self.title = [NSString stringWithFormat:@"第 %d 张", currentPage];
            }
        }
        else if (currentOffsetY < self.willEndContentOffsetY && self.willEndContentOffsetY < self.startContentOffsetY) {
            directionRight = NO;  // scrollView向左偏移
            // 当前是第几张
            int currentPage = ceil(scrollView.contentOffset.y/CGRectGetHeight(scrollView.frame))+1;
            
            if (currentPage > 0) {
//                self.title = [NSString stringWithFormat:@"第 %d 张", currentPage];
            }
        }
        else {
            return; //  需要严格的条件判断 当滑动的幅度较小时，则不进行股票的预加载
        }

        if (directionRight) {

            if (self.leftOffsetY <= scrollView.contentOffset.y) { // 当前视图已经从界面中移除出去
                self.pageIndex++;

                if (self.pageIndex >= self.datas.count-1) {
                    self.pageIndex = self.datas.count-1;
                    self.leftOffsetY = CGRectGetHeight(scrollView.frame)*self.datas.count;
                    self.rightOffsetY = CGRectGetHeight(scrollView.frame)*(self.datas.count-1);
                    return;
                    
                }
                self.leftOffsetY = CGRectGetHeight(scrollView.frame)*self.pageIndex;
                self.rightOffsetY = CGRectGetHeight(scrollView.frame)*(self.pageIndex-1);
            }
        }
        else {
            if (self.rightOffsetY >= scrollView.contentOffset.y) { // 当前视图已经从界面中移除出去
                self.pageIndex--;
                if (self.pageIndex <= 0) {
                    self.pageIndex = 0;
                    self.leftOffsetY = CGRectGetHeight(scrollView.frame);
                    self.rightOffsetY = 0;
                    return;
                }
                self.leftOffsetY = CGRectGetHeight(scrollView.frame)*self.pageIndex;
                self.rightOffsetY = CGRectGetHeight(scrollView.frame)*(self.pageIndex-1);
            }
        }
    }
}

// 这个方法里面 才真正进行视图内容的加载
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

//    int currentPage = ceil(scrollView.contentOffset.y/CGRectGetHeight(scrollView.frame))+1;
//    self.title = [NSString stringWithFormat:@"第 %d 张", currentPage];
    if (self.isDragged) {

        // 此处为容错判断 若滑动过快 将会导致currentPage与self.pageIndex不一致 此时 将scrollView上原来的视图删除掉，然后再进行重新布局
        if (self.datas.count > 3) {
            NSInteger currentPage = ceil(scrollView.contentOffset.y/CGRectGetHeight(scrollView.frame));
            if (currentPage != self.pageIndex) {
                self.pageIndex = currentPage;
                if (self.pageIndex >= self.datas.count-1) {
                    self.pageIndex = self.datas.count-1;
                }
                if (self.pageIndex <= 0) {
                    self.pageIndex = 0;
                }
                for (UIImageView *imageView in self.tempDatas) {
                    [imageView removeFromSuperview];
                }
                [self.tempDatas removeAllObjects];
                [self configImages];
                return;
            }
        }
        BOOL directionRight;
        CGFloat endOffsetY = scrollView.contentOffset.y;
        if (endOffsetY > self.willEndContentOffsetY && self.willEndContentOffsetY > self.startContentOffsetY) {
            directionRight = YES;
        }
        else if (endOffsetY < self.willEndContentOffsetY && self.willEndContentOffsetY < self.startContentOffsetY) {
            directionRight = NO;
        }
        else {
            // 容错检查 当滑动到左边或右边的的边界时，若显示了空白页，刚重新进行布局，加载最左边或最右边的三支股票
            if (self.datas.count > 3) { // 在资源的数量小于3个的情况因全部加载了内容，所以不需要这种容错检查（下同）
                UIImageView *imageView = nil;
                if (scrollView.contentOffset.y <= 0) {
                    imageView = [self.tempDatas objectAtIndex:0]; // 最左边
                    
                }
                else if (scrollView.contentOffset.y+CGRectGetHeight(scrollView.frame) >= CGRectGetHeight(scrollView.frame)*self.datas.count) { // 最右边
                    imageView = [self.tempDatas objectAtIndex:2];
                }
                else {
                    imageView = [self.tempDatas objectAtIndex:1];
                }

                if (imageView.frame.origin.y != CGRectGetHeight(scrollView.frame)*self.pageIndex) {

                    for (UIImageView *imageView in self.tempDatas) {
                        [imageView removeFromSuperview];
                    }
                    [self.tempDatas removeAllObjects];
                    [self configImages];
                }
            }
            return; //  需要严格的条件判断 当滑动的幅度较小时，则不进行股票的预加载
        }
        // 容错检查 若滑动较快，停在了中间某个位置时，若显示空白，则替换掉self.tempDatas中旧的视图控制器，重新进行布局
        if (self.datas.count > 3) {
            UIImageView *imageView = nil;
            if (directionRight) {
                if (self.pageIndex == 1) { // 向右滑动， self.pageIndex为1的情况下进行检查
                    imageView = [self.tempDatas objectAtIndex:1];
                }
                else {
                    imageView = [self.tempDatas objectAtIndex:2];
                }
            }
            else {
                if (self.pageIndex == self.datas.count - 2) { // 向左滑动，self.pageIndex为self.dataList.count-2的情况下进行容错检查
                    imageView = [self.tempDatas objectAtIndex:1];
                }
                else {
                    imageView = [self.tempDatas objectAtIndex:0];
                }
            }
            if (imageView.frame.origin.y != CGRectGetHeight(scrollView.frame)*self.pageIndex) {
                for (UIImageView *imageView in self.tempDatas) {
                    [imageView removeFromSuperview];
                }
                [self.tempDatas removeAllObjects];
                [self configImages];
            }
        }
        if (directionRight) {
            // 这里 将leftOffsetX还原，以不影响视图的加载
            self.leftOffsetY -= CGRectGetHeight(scrollView.frame);
            self.rightOffsetY -= CGRectGetHeight(scrollView.frame);
            if (self.leftOffsetY <= scrollView.contentOffset.y) {
                if (self.pageIndex >= self.datas.count-1) {
                    self.pageIndex = self.datas.count-1;
                    UIImageView *rightImageView = [self.tempDatas lastObject];
                    self.leftOffsetY = rightImageView.frame.origin.y+CGRectGetHeight(rightImageView.frame);
                    self.rightOffsetY = rightImageView.frame.origin.y;
                    return;
                }
                if (self.pageIndex == 1) { // 翻到最左边 然后回翻时 此种情况数组中的三个VC不动
                    UIImageView *middleImageView = [self.tempDatas objectAtIndex:1];
                    self.leftOffsetY = middleImageView.frame.origin.y + CGRectGetHeight(middleImageView.frame);
                    self.rightOffsetY = middleImageView.frame.origin.y;
                    return;
                }
                UIImageView *firstImageView = [self.tempDatas firstObject];
                [firstImageView removeFromSuperview];

                UIImageView *thirdImageView = [self configImageViewWithImage:[UIImage imageNamed:[self.datas objectAtIndex:self.pageIndex+1]] withFrame:CGRectMake(0, kScrollViewHeight*(self.pageIndex+1), kScrollViewWidth, kScrollViewHeight)];
                
                [self.imageViewScrollView addSubview:thirdImageView];
                [self.tempDatas addObject:thirdImageView];
                [self.tempDatas removeObjectAtIndex:0];

                UIImageView *secondImageView = [self.tempDatas objectAtIndex:1];
                self.leftOffsetY = secondImageView.frame.origin.y + CGRectGetHeight(secondImageView.frame);
                self.rightOffsetY = secondImageView.frame.origin.y;
            }
        }
        else {
            // 这里 将leftOffsetX还原 以正常加载视图
            self.leftOffsetY += CGRectGetHeight(scrollView.frame);
            self.rightOffsetY += CGRectGetHeight(scrollView.frame);
            if (self.rightOffsetY >= scrollView.contentOffset.y) {
                
                if (self.pageIndex <= 0) {
                    self.pageIndex = 0;
                    UIImageView *firstImageView = [self.tempDatas firstObject];
                    self.leftOffsetY = firstImageView.frame.origin.y+CGRectGetHeight(firstImageView.frame);
                    self.rightOffsetY = firstImageView.frame.origin.y;
                    return;
                }

                if (self.pageIndex == self.datas.count - 2) { // 翻到最右边 回翻 翻到倒数第二个的时候 数组中的三个VC保持不变
                    UIImageView *secondImageView = [self.tempDatas objectAtIndex:1];
                    self.leftOffsetY = secondImageView.frame.origin.y + CGRectGetHeight(secondImageView.frame);
                    self.rightOffsetY = secondImageView.frame.origin.y;
                    return;
                }
                UIImageView *rightImageView = [self.tempDatas lastObject];
                [rightImageView removeFromSuperview];

                UIImageView *firstImageView = [self configImageViewWithImage:[UIImage imageNamed:[self.datas objectAtIndex:self.pageIndex-1]] withFrame:CGRectMake(0, kScrollViewHeight*(self.pageIndex-1), kScrollViewWidth, kScrollViewHeight)];
                
                [self.imageViewScrollView addSubview:firstImageView];
                [self.tempDatas removeLastObject];
                [self.tempDatas insertObject:firstImageView atIndex:0];

                UIImageView *secondImageView = [self.tempDatas objectAtIndex:1];
                self.leftOffsetY = secondImageView.frame.origin.y + CGRectGetHeight(secondImageView.frame);
                
                self.rightOffsetY = secondImageView.frame.origin.y;
                
            }
        }
    }
}



@end
