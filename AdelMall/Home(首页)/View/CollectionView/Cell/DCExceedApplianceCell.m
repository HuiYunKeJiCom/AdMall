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
#import "ADStarGoodsModel.h"
// Vendors
#import <UIImageView+WebCache.h>

@interface DCExceedApplianceCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

/* collectionView */
@property (strong , nonatomic)UICollectionView *collectionView;
/* 头部ImageView */
@property (strong , nonatomic)UIImageView *headImageView;
/* 图片数组 */
@property (copy , nonatomic)NSArray *imagesArray;
/* 广告数据数组 */
@property (strong , nonatomic)NSMutableArray<ADStarGoodsModel *> *goodExceedItem;
/** 数据模型 */
@property(nonatomic,strong)ADStarGoodsModel *model;
@end

static NSString *const ADStarGoodsSubclassCellID = @"ADStarGoodsSubclassCell";

@implementation DCExceedApplianceCell

#pragma mark - lazyload
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(kScreenWidth * 0.25, self.dc_height * 0.9+10);
//        layout.minimumInteritemSpacing = 2; //X
//        layout.minimumLineSpacing = 3;  //Y
//        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self addSubview:_collectionView];
        _collectionView.frame = CGRectMake(0, kScreenWidth * 0.35 + DCMargin, kScreenWidth, self.dc_height * 1.8+20);
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

-(void)loadDataWithFloorID:(NSString *)floorID{
//    @"65680"
    [RequestTool getAppointFloorData:@{@"floorId":floorID} withSuccessBlock:^(NSDictionary *result) {
        NSLog(@"智能硬件result = %@",result);
        
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
    NSArray *dataInfo = dict[@"data"][@"goodsList"][@"resultList"];
    NSMutableArray *tempAdvertArr = [NSMutableArray array];
    _goodExceedItem = [ADStarGoodsModel mj_objectArrayWithKeyValuesArray:dataInfo];
    if(_goodExceedItem.count <6){
        self.model = [ADStarGoodsModel mj_objectWithKeyValues:dataInfo];
    }
    for (ADStarGoodsModel *model in _goodExceedItem) {
                    NSLog(@"model = %@",model.mj_keyValues);
        [tempAdvertArr addObject:model.goods_image_path];
    }
    self.goodExceedArray = tempAdvertArr;
    [self.collectionView reloadData];
    //    NSLog(@"self.imageGroupArray = %@",self.imageGroupArray);
}

- (NSMutableArray<ADStarGoodsModel *> *)goodExceedItem
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
    return UIEdgeInsetsMake(0, 0, 10, 0);//分别为上、左、下、右
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ADStarGoodsSubclassCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ADStarGoodsSubclassCellID forIndexPath:indexPath];
    cell.model = _goodExceedItem[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self lookDetailForGoods];
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
- (void)setGoodExceedArray:(NSArray *)goodExceedArray
{
    _goodExceedArray = goodExceedArray;
    _imagesArray = goodExceedArray;
    if (goodExceedArray.count == 0){
        [_headImageView setImage:[UIImage imageNamed:@"image_default"]];
        return;
    }else{
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:goodExceedArray[0]]];
    }
}

#pragma mark - 点击事件
- (void)lookDetailForGoods
{
    !_lookDetailBlock ? : _lookDetailBlock();
}

@end
