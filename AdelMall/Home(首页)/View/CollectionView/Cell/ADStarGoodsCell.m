//
//  ADStarGoodsCell.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/26.
//  Copyright © 2018年 Adel. All rights reserved.
//  明星产品Cell

#import "ADStarGoodsCell.h"
#import "ADStarGoodsModel.h"
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
@property (strong , nonatomic)NSMutableArray<ADStarGoodsModel *> *tempItem;

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

- (NSMutableArray<ADStarGoodsModel *> *)tempItem
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
//        [self loadData];
        [self performSelector:@selector(loadData) withObject:nil afterDelay:2];
    }
    return self;
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

-(void)loadData{
    [RequestTool getStarGoods:nil withSuccessBlock:^(NSDictionary *result) {
        NSLog(@"明星result = %@",result);
        if([result[@"code"] integerValue] == 1){
            [self withNSDictionary:result];
        }
    } withFailBlock:^(NSString *msg) {
        NSLog(@"msg = %@",msg);
    }];
}

-(void)withNSDictionary:(NSDictionary *)dict
{
    NSArray *dataInfo = dict[@"data"][@"goodsList"];
    _tempItem = [ADStarGoodsModel mj_objectArrayWithKeyValuesArray:dataInfo];
//    for (ADStarGoodsModel *model in _tempItem) {
//                NSLog(@"明星model = %@",model.mj_keyValues);
//    }
    [self.collectionView reloadData];
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
    [self lookDetailForGoods];
}

#pragma mark - 点击事件
- (void)lookDetailForGoods
{
    !_lookDetailBlock ? : _lookDetailBlock();
}


@end
