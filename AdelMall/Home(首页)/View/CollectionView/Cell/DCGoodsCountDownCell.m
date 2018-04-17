//
//  DCGoodsCountDownCell.m
//  CDDMall
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCGoodsCountDownCell.h"

// Controllers

// Models
#import "ADCountDownGoodsModel.h"
#import "ADCountDownActivityModel.h"
// Views
#import "ADCountDownSubclassCell.h"
// Vendors
#import <MJExtension.h>
// Categories

// Others

@interface DCGoodsCountDownCell ()<UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout>

/* collection */
@property (strong , nonatomic)UICollectionView *collectionView;
///* 推荐商品数据 */
//@property (strong , nonatomic)NSMutableArray<DCRecommendItem *> *countDownItem;
/* 底部 */
@property (strong , nonatomic)UIView *bottomLineView;

/* 抢购商品数组 */
@property (strong , nonatomic)NSMutableArray<ADCountDownGoodsModel *> *countDownItem;
///* 测试数组 */
//@property (strong , nonatomic)NSMutableArray<ADGoodsTempModel *> *tempItem;

@end

static NSString *const ADCountDownSubclassCellID = @"ADCountDownSubclassCell";

@implementation DCGoodsCountDownCell

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
        
        [_collectionView registerClass:[ADCountDownSubclassCell class] forCellWithReuseIdentifier:ADCountDownSubclassCellID];
    }
    return _collectionView;
}

- (NSMutableArray<ADCountDownGoodsModel *> *)countDownItem
{
    if (!_countDownItem) {
        _countDownItem = [NSMutableArray array];
    }
    return _countDownItem;
}

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
        
        //限时秒杀时间结束
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getTime:) name:@"countDownTimeOver" object:nil];
    }
    return self;
}

-(void)getTime:(NSNotification *)text{
    [self.countDownItem removeAllObjects];
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

-(void)loadDataWithArray:(NSMutableArray<ADCountDownGoodsModel *> *)countDownItem{
    _countDownItem = countDownItem;
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
    return _countDownItem.count;
//    return _countDownItem.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ADCountDownSubclassCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ADCountDownSubclassCellID forIndexPath:indexPath];
    cell.model = _countDownItem[indexPath.row];
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"点击了计时商品%zd",indexPath.row);
//    [self lookDetailForGoods];
    
//    [[NSNotificationCenter defaultCenter]   removeObserver:self];
    ADCountDownGoodsModel *model = _countDownItem[indexPath.row];
    NSDictionary *dict = @{@"goodsID":model.idx};
    //创建通知
    NSNotification *notification =[NSNotification notificationWithName:@"goodsID" object:nil userInfo:dict];
    //通过通知中心发送通知
    NSLog(@"抢购中心发通知了");
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
    
}

//#pragma mark - 点击事件
//- (void)lookDetailForGoods
//{
//    !_lookDetailBlock ? : _lookDetailBlock();
//}

-(void)dealloc
{
    //移除观察者，Observer不能为nil
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
