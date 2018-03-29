//
//  DCSlideshowHeadView.m
//  CDDMall
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCSlideshowHeadView.h"

// Controllers

// Models
#import "ADAdvertModel.h"
// Views

// Vendors
#import <SDCycleScrollView.h>
// Categories

// Others

@interface DCSlideshowHeadView ()<SDCycleScrollViewDelegate>

/* 轮播图 */
@property (strong , nonatomic)SDCycleScrollView *cycleScrollView;
/* 广告数据数组 */
@property (strong , nonatomic)NSMutableArray<ADAdvertModel *> *advertItem;

@end

@implementation DCSlideshowHeadView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    self.backgroundColor = [UIColor whiteColor];
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, self.dc_height) delegate:self placeholderImage:nil];
    _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    _cycleScrollView.autoScrollTimeInterval = 5.0;
    [self addSubview:_cycleScrollView];
//    [self loadData];
}

-(void)loadDataWithAdvertID:(NSString *)string{
    [RequestTool getImagePathForAD:@{@"advert_id":string} withSuccessBlock:^(NSDictionary *result) {
        NSLog(@"轮播图result = %@",result);
        if([result[@"code"] integerValue] == 1){
            [self withNSDictionary:result];
        }else{
            NSMutableArray *tempAdvertArr = [NSMutableArray array];
            self.imageGroupArray = tempAdvertArr;
        }
    } withFailBlock:^(NSString *msg) {
        NSLog(@"msg = %@",msg);
        NSMutableArray *tempAdvertArr = [NSMutableArray array];
        self.imageGroupArray = tempAdvertArr;
    }];
}

-(void)withNSDictionary:(NSDictionary *)dict
{

    NSArray *dataInfo = dict[@"data"][@"advert"];
    NSMutableArray *tempAdvertArr = [NSMutableArray array];
    _advertItem = [ADAdvertModel mj_objectArrayWithKeyValuesArray:dataInfo];
        for (ADAdvertModel *model in _advertItem) {
//            NSLog(@"model = %@",model.mj_keyValues);
            [tempAdvertArr addObject:model.ad_image_path];
        }
    self.imageGroupArray = tempAdvertArr;
//    NSLog(@"self.imageGroupArray = %@",self.imageGroupArray);
}

- (NSMutableArray<ADAdvertModel *> *)advertItem
{
    if (!_advertItem) {
        _advertItem = [NSMutableArray array];
    }
    return _advertItem;
}

- (void)setImageGroupArray:(NSArray *)imageGroupArray
{
    _imageGroupArray = imageGroupArray;
    _cycleScrollView.placeholderImage = [UIImage imageNamed:@"image_default"];
    if (imageGroupArray.count == 0) return;
    _cycleScrollView.imageURLStringsGroup = _imageGroupArray;

}

#pragma mark - 点击图片Bannar跳转
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"点击了%zd轮播图",index);
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
}

#pragma mark - Setter Getter Methods


@end
