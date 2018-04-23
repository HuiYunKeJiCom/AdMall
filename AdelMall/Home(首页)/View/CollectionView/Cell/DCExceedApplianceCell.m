//
//  DCExceedApplianceCell.m
//  CDDMall
//
//  Created by apple on 2017/6/30.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//  首页-智能硬件

#import "DCExceedApplianceCell.h"

// Views
//#import "DCGoodsHandheldCell.h"
#import "ADStarGoodsSubclassCell.h"
#import "ADGoodsModel.h"
// Vendors
#import <UIImageView+WebCache.h>

@interface DCExceedApplianceCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

/* collectionView */
@property (strong , nonatomic)UICollectionView *collectionView;
/* 头部ImageView */
@property (strong , nonatomic)UIImageView *headImageView;
///* 图片数组 */
//@property (copy , nonatomic)NSArray *imagesArray;
/* 广告数据数组 */
@property (strong , nonatomic)NSMutableArray<ADGoodsModel *> *goodExceedItem;
///** 数据模型 */
//@property(nonatomic,strong)ADStarGoodsModel *model;
@end

static NSString *const ADStarGoodsSubclassCellID = @"ADStarGoodsSubclassCell";

@implementation DCExceedApplianceCell

#pragma mark - lazyload
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(kScreenWidth * 0.25, self.dc_height * 0.35+5);
//        layout.minimumInteritemSpacing = 2; //X
//        layout.minimumLineSpacing = 3;  //Y
//        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self addSubview:_collectionView];
        _collectionView.frame = CGRectMake(0, kScreenWidth * 0.35 + DCMargin, kScreenWidth, self.dc_height * 0.7+10);
        _collectionView.scrollEnabled = NO;
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
    
    _headImageView = [[UIImageView alloc] init];
    [self addSubview:_headImageView];

}

- (NSMutableArray<ADGoodsModel *> *)goodExceedItem
{
    if (!_goodExceedItem) {
        _goodExceedItem = [NSMutableArray array];
    }
    return _goodExceedItem;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.left.mas_equalTo(self);
        make.width.mas_equalTo(self);
        make.height.mas_equalTo(kScreenWidth * 0.32);
    }];
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if(self.goodExceedItem.count >3){
       return 2;
    }else{
        return 1;
    }

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(self.goodExceedItem.count >3){
        return 3;
    }else{
        return self.goodExceedItem.count;
    }

}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);//分别为上、左、下、右
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ADStarGoodsSubclassCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ADStarGoodsSubclassCellID forIndexPath:indexPath];
    NSInteger temp = indexPath.row+indexPath.section*3;
    cell.model = _goodExceedItem[temp];
//    cell.backgroundColor = [UIColor redColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"点击了智能硬件%zd",indexPath.row);
    //    [self lookDetailForGoods];
    
    ADGoodsModel *model = _goodExceedItem[indexPath.row];
    NSDictionary *dict = @{@"exceedID":model.idx};
    //创建通知
    NSNotification *notification =[NSNotification notificationWithName:@"exceedID" object:nil userInfo:dict];
    //通过通知中心发送通知
    NSLog(@"智能硬件发通知了");
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
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


#pragma mark - Setter Getter Methods
-(void)loadDataWithNSString:(NSString *)exceedPath and:(NSMutableArray<ADGoodsModel *> *)goodExceedItem
{
//    NSLog(@"exceedPath = %@",exceedPath);
//    NSLog(@"goodExceedItem.count = %lu",goodExceedItem.count);
//    _goodExceedArray = goodExceedArray;
    _goodExceedItem = goodExceedItem;
//    _imagesArray = goodExceedArray;
    if (!exceedPath){
        [_headImageView setImage:[UIImage imageNamed:@"image_default"]];
        return;
    }else{
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:exceedPath]];
    }
}

//#pragma mark - 点击事件
//- (void)lookDetailForGoods
//{
//    !_lookDetailBlock ? : _lookDetailBlock();
//}

@end
