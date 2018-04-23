//
//  ADStarGoodsCell.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/26.
//  Copyright © 2018年 Adel. All rights reserved.
//  明星产品Cell

#import "ADStarGoodsCell.h"
#import "ADGoodsModel.h"
// Views
//#import "DCGoodsSurplusCell.h"
#import "ADStarGoodsSubclassCell.h"
// Vendors
#import <MJExtension.h>

@interface ADStarGoodsCell()<UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout>

/* collection */
@property (strong , nonatomic)UICollectionView *collectionView;
///* 推荐商品数据 */
//@property (strong , nonatomic)NSMutableArray<DCRecommendItem *> *countDownItem;
/* 底部 */
@property (strong , nonatomic)UIView *bottomLineView;

/* 测试数组 */
@property (strong , nonatomic)NSMutableArray<ADGoodsModel *> *tempItem;

@end

static NSString *const ADStarGoodsSubclassCellID = @"ADStarGoodsSubclassCell";

@implementation ADStarGoodsCell

#pragma mark - lazyload
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 1;
        layout.itemSize = CGSizeMake(kScreenWidth * 0.25, self.dc_height * 0.9+10);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal; //滚动方向
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self addSubview:_collectionView];
        _collectionView.frame = self.bounds;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[ADStarGoodsSubclassCell class] forCellWithReuseIdentifier:ADStarGoodsSubclassCellID];
    }
    return _collectionView;
}

- (NSMutableArray<ADGoodsModel *> *)tempItem
{
    if (!_tempItem) {
        _tempItem = [NSMutableArray array];
    }
    return _tempItem;
}


#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}

-(void)loadDataWithArray:(NSMutableArray<ADGoodsModel *> *)tempItem{
    _tempItem = tempItem;
    [self.collectionView reloadData];
}

- (void)setUpUI
{
    self.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = self.backgroundColor;

    _bottomLineView = [[UIView alloc] init];
    _bottomLineView.backgroundColor = kBACKGROUNDCOLOR;
    [self addSubview:_bottomLineView];
    _bottomLineView.frame = CGRectMake(0, self.dc_height - 8, kScreenWidth, 8);
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
}

#pragma mark - Setter Getter Methods
#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _tempItem.count;
    //    return _countDownItem.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ADStarGoodsSubclassCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ADStarGoodsSubclassCellID forIndexPath:indexPath];
    cell.model = _tempItem[indexPath.row];
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"点击了明星产品%zd",indexPath.row);
//    [self lookDetailForGoods];

    ADGoodsModel *model = _tempItem[indexPath.row];
    NSDictionary *dict = @{@"starGoodsID":model.idx};
    //创建通知
    NSNotification *notification =[NSNotification notificationWithName:@"starGoodsID" object:nil userInfo:dict];
    //通过通知中心发送通知
    NSLog(@"明星产品发通知了");
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

//#pragma mark - 点击事件
//- (void)lookDetailForGoods
//{
//    !_lookDetailBlock ? : _lookDetailBlock();
//}


@end
