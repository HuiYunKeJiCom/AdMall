//
//  ADRecommendCell.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/2/28.
//  Copyright © 2018年 Adel. All rights reserved.
//  首页-为您推荐

#import "ADRecommendCell.h"
// Views
//#import "DCGoodsHandheldCell.h"
#import "ADStarGoodsSubclassCell.h"
#import "ADStarGoodsModel.h"
// Vendors
#import <UIImageView+WebCache.h>

@interface ADRecommendCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

/* collectionView */
@property (strong , nonatomic)UICollectionView *collectionView;
/* 图片数组 */
@property (copy , nonatomic)NSArray *imagesArray;
/* 广告数据数组 */
@property (strong , nonatomic)NSMutableArray<ADStarGoodsModel *> *goodExceedItem;
@end

static NSString *const ADStarGoodsSubclassCellID = @"ADStarGoodsSubclassCell";

@implementation ADRecommendCell

#pragma mark - lazyload
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(kScreenWidth * 0.25, self.dc_height * 0.45+10);
        //        layout.minimumInteritemSpacing = 2; //X
        //        layout.minimumLineSpacing = 3;  //Y
        //        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self addSubview:_collectionView];
        _collectionView.frame = CGRectMake(0, 0, kScreenWidth, self.dc_height * 0.9+20);
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[ADStarGoodsSubclassCell class] forCellWithReuseIdentifier:ADStarGoodsSubclassCellID];
    }
    return _collectionView;
}


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
    self.collectionView.backgroundColor = self.backgroundColor;
    [self loadData];
}

-(void)loadData{
    //    @"65680"
    [RequestTool getRecommendData:nil withSuccessBlock:^(NSDictionary *result) {
        NSLog(@"为您推荐result = %@",result);
        
        if([result[@"code"] integerValue] == 1){
            [self withNSDictionary:result];
        }else{
            NSMutableArray *tempAdvertArr = [NSMutableArray array];
            self.goodExceedArray = tempAdvertArr;
        }
        
    } withFailBlock:^(NSString *msg) {
        NSLog(@"智能硬件msg = %@",msg);
        NSMutableArray *tempAdvertArr = [NSMutableArray array];
        self.goodExceedArray = tempAdvertArr;
    }];
}

-(void)withNSDictionary:(NSDictionary *)dict
{
    NSArray *dataInfo = dict[@"data"][@"goodsList"];
    NSMutableArray *tempAdvertArr = [NSMutableArray array];
    _goodExceedItem = [ADStarGoodsModel mj_objectArrayWithKeyValuesArray:dataInfo];
    for (ADStarGoodsModel *model in _goodExceedItem) {
        NSLog(@"model = %@",model.mj_keyValues);
        [tempAdvertArr addObject:model.goods_image_path];
    }
    self.goodExceedArray = tempAdvertArr;
    [self.collectionView reloadData];
    //    NSLog(@"self.imageGroupArray = %@",self.imageGroupArray);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 10, 0);//分别为上、左、下、右
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ADStarGoodsSubclassCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ADStarGoodsSubclassCellID forIndexPath:indexPath];
    NSInteger temp = indexPath.row+indexPath.section*3;
    cell.model = _goodExceedItem[temp];
//    DCGoodsHandheldCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCGoodsHandheldCellID forIndexPath:indexPath];
//    cell.handheldImage = _imagesArray[indexPath.row + 1];
    return cell;
}


//// 设置最小行间距，也就是前一行与后一行的中间最小间隔
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
//    return 30;
//}
//
//// 设置最小列间距，也就是左行与右一行的中间最小间隔
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    return 5;
//}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self lookDetailForGoods];
}

#pragma mark - Setter Getter Methods
- (void)setGoodExceedArray:(NSArray *)goodExceedArray
{
    _goodExceedArray = goodExceedArray;
    _imagesArray = goodExceedArray;
}

#pragma mark - 点击事件
- (void)lookDetailForGoods
{
    !_lookDetailBlock ? : _lookDetailBlock();
}

@end
