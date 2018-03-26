//
//  ADStarGoodsCell.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/26.
//  Copyright © 2018年 Adel. All rights reserved.
//  明星产品Cell

#import "ADStarGoodsCell.h"
#import "ADGoodsTempModel.h"
// Views
#import "DCGoodsSurplusCell.h"
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
@property (strong , nonatomic)NSMutableArray<ADGoodsTempModel *> *tempItem;

@end

static NSString *const DCGoodsSurplusCellID = @"DCGoodsSurplusCell";

@implementation ADStarGoodsCell

#pragma mark - lazyload
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 1;
        layout.itemSize = CGSizeMake(self.dc_height * 0.65, self.dc_height * 0.9);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal; //滚动方向
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self addSubview:_collectionView];
        _collectionView.frame = self.bounds;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[DCGoodsSurplusCell class] forCellWithReuseIdentifier:DCGoodsSurplusCellID];
    }
    return _collectionView;
}

//- (NSMutableArray<DCRecommendItem *> *)countDownItem
//{
//    if (!_countDownItem) {
//        _countDownItem = [NSMutableArray array];
//    }
//    return _countDownItem;
//}

- (NSMutableArray<ADGoodsTempModel *> *)tempItem
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
    
    //    NSArray *countDownArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"CountDownShop.plist" ofType:nil]];
    //    _countDownItem = [DCRecommendItem mj_objectArrayWithKeyValuesArray:countDownArray];
    
    
    _bottomLineView = [[UIView alloc] init];
    _bottomLineView.backgroundColor = kBACKGROUNDCOLOR;
    [self addSubview:_bottomLineView];
    _bottomLineView.frame = CGRectMake(0, self.dc_height - 8, kScreenWidth, 8);
}

-(void)loadData{
    [RequestTool getStarGoods:nil withSuccessBlock:^(NSDictionary *result) {
        NSLog(@"明星result = %@",result);
        [self withNSDictionary:result];
    } withFailBlock:^(NSString *msg) {
        NSLog(@"msg = %@",msg);
    }];
}

-(void)withNSDictionary:(NSDictionary *)dict
{
    NSArray *dataInfo = dict[@"data"][@"goodsList"];
    _tempItem = [ADGoodsTempModel mj_objectArrayWithKeyValuesArray:dataInfo];
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
    DCGoodsSurplusCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCGoodsSurplusCellID forIndexPath:indexPath];
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
