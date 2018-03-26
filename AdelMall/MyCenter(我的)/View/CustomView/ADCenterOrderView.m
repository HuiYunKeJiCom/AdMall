//
//  ADCenterOrderCellTableViewCell.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/1/29.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import "ADCenterOrderView.h"
#import "DCGoodsGridCell.h"

@interface ADCenterOrderView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
/* collectioView */
@property (strong , nonatomic)UICollectionView *collectionView;

@end

static NSString *const DCGoodsGridCellID = @"DCGoodsGridCell";

@implementation ADCenterOrderView

#pragma mark - Intial
#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}

-(void)setUpUI{
    [self addSubview:self.collectionView];
}

#pragma mark - LoadLazy
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *dcFlowLayout = [UICollectionViewFlowLayout new];
        dcFlowLayout.minimumLineSpacing = dcFlowLayout.minimumInteritemSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:dcFlowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[DCGoodsGridCell class] forCellWithReuseIdentifier:DCGoodsGridCellID];
        
        [self addSubview:_collectionView];
    }
    return _collectionView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    WEAKSELF
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf);
        make.top.equalTo(weakSelf);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, weakSelf.frame.size.height));
    }];

//    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self);
//        make.right.mas_equalTo(self);
//        [make.bottom.mas_equalTo(self)setOffset:-DCMargin];
//        make.top.mas_equalTo(_topTitleView.mas_bottom);
//    }];
    
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _orderItemArray.count;
}

#pragma mark - <UICollectionViewDelegate>
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DCGoodsGridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCGoodsGridCellID forIndexPath:indexPath];
    
    cell.gridItem = _orderItemArray[indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_tbDelegate && [_tbDelegate respondsToSelector:@selector(collectionView:didSelectItemAtIndexPath:)]) {
        [_tbDelegate collectionView:collectionView didSelectItemAtIndexPath:indexPath];
    }
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kScreenWidth / 3, 75);
}



@end
