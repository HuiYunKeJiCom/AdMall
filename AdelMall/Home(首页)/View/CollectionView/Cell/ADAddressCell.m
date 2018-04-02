//
//  ADAddressCell.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/16.
//  Copyright © 2018年 Adel. All rights reserved.
//  抢购商品详情页面-收货地址

#import "ADAddressCell.h"
#import "MRDropDownView.h"
#import "ADAddressView.h"
#import "ADAddressModel.h"//地址模型


@interface ADAddressCell()
@property (nonatomic, strong) UIView* bgView;
// 筛选框 Filter box
@property (nonatomic, strong) MRDropDownView *dropView;
//@property (nonatomic, assign) CGRect cellFrame;
/** 模型数组 */
@property(nonatomic,strong)NSMutableArray *modelArr;
@end

@implementation ADAddressCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
//        self.userInteractionEnabled = YES;
        self.modelArr = [NSMutableArray array];
        [self makeDataForModel];
        [self setUpUI];
        [self setUpData];
    }
    return self;
}

- (void)setUpUI{

    [self.contentView addSubview:self.bgView];
    [self.contentView addSubview:self.dropView];
    
    [self loadData];
}

-(void)loadData{
    [RequestTool getAddress:nil withSuccessBlock:^(NSDictionary *result) {
        NSLog(@"获取收货地址result = %@",result);
    } withFailBlock:^(NSString *msg) {
        NSLog(@"获取收货地址msg = %@",msg);
    }];
}

-(void)makeDataForModel{
    NSArray *dataArr = @[@{@"id":@"123456",@"address":@"广东省 深圳市 宝安区 松柏路南岗第二工业区",@"addressLabelName":@"家",@"receiverName":@"黄先生",@"phone":@"137 0000 0000",@"zipCode":@"518000"},@{@"id":@"123456",@"address":@"广东省 深圳市 宝安区 松柏路南岗第二工业区",@"addressLabelName":@"公司",@"receiverName":@"老张",@"phone":@"137 0000 0000",@"zipCode":@"518000"},@{@"id":@"123456",@"address":@"广东省 深圳市 宝安区 松柏路南岗第二工业区",@"addressLabelName":@"公司",@"receiverName":@"刘先生",@"phone":@"137 0000 0000",@"zipCode":@"518000"},@{@"id":@"123456",@"address":@"广东省 深圳市 宝安区 松柏路南岗第二工业区",@"addressLabelName":@"公司",@"receiverName":@"叶先生",@"phone":@"137 0000 0000",@"zipCode":@"518000"}];
    for (NSDictionary *dic in dataArr) {
        
        ADAddressModel *model = [ADAddressModel mj_objectWithKeyValues:dic];
        [self.modelArr addObject:model];
    }
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    NSLog(@"调用layoutSubviews");
    [self makeConstraints];
}

#pragma mark - 填充数据
-(void)setUpData{
}

- (void)makeConstraints {
    WEAKSELF
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.top.equalTo(weakSelf);
//        make.bottom.equalTo(weakSelf.mas_bottom);
        make.height.mas_equalTo(40);
    }];
    
//    [self.contentView mas_makeConstraints:^(MASConstraintMaker*make) {
//
//        make.top.equalTo(weakSelf);
//        make.left.equalTo(weakSelf.mas_left);
//        make.width.mas_equalTo(kScreenWidth);
//        make.bottom.equalTo(self.bgView.mas_bottom);
//
//    }];
}

- (UICollectionViewLayoutAttributes*)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes*)layoutAttributes {
    
    [self setNeedsLayout];
    
    [self layoutIfNeeded];
    NSLog(@"调用setNeedsLayout");
    CGSize size = [self.contentView systemLayoutSizeFittingSize: layoutAttributes.size];

    CGRect cellFrame = layoutAttributes.frame;

    cellFrame.size.height= size.height;
    
    layoutAttributes.frame= cellFrame;
    return layoutAttributes;
    
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectZero];
        _bgView.backgroundColor = [UIColor redColor];
//        _bgView.userInteractionEnabled = YES;
    }
    return _bgView;
}

// MARK: 懒加载 Lazy loading
- (MRDropDownView *)dropView{
    
    if(!_dropView){
        NSMutableArray *viewArray = [NSMutableArray array];
        ADAddressView *view1 = [[ADAddressView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
        view1.model = self.modelArr[0];
        ADAddressView *view2 = [[ADAddressView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
        view2.model = self.modelArr[1];
        ADAddressView *view3 = [[ADAddressView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
        view3.model = self.modelArr[2];
        ADAddressView *view4 = [[ADAddressView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
        view4.model = self.modelArr[3];
        [viewArray addObject:view1];
        [viewArray addObject:view2];
        [viewArray addObject:view3];
        [viewArray addObject:view4];
        // 创建筛选器 Create a filter box
        _dropView = [[MRDropDownView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40) andOptions:viewArray];
        WEAKSELF
        _dropView.openViewClickBlock = ^{
            NSLog(@"打开View");
            [weakSelf openView];
        };
        _dropView.closeViewClickBlock = ^{
            NSLog(@"关闭View");
            [weakSelf closeView];
        };
        _dropView.tag = 100;
        _dropView.backgroundColor = [UIColor whiteColor];

        //// MARK: 点击选项调用的方法 Click on the option method call
        [self.dropView didseletedWithBlock:^(NSInteger tag, NSInteger index) {
            //            @strongify(self);
            NSArray *array = @[@"with time", @"abcdefg", @"hijklmn", @"opqrsturwxyz"];
            NSLog(@"dropView.tag -> %ld, seleted -> %@", tag, array[index]);
            // 关闭筛选框 Close the screen box
            [self.dropView closeBgView];
        }];
        
        /// 当点击筛选框时, 调用的方法 When click the filter box, the method called
        [_dropView clickBackGroundBlock:^{
//                        @strongify(self);
            NSLog(@"点了这里");
            [self.dropView closeBgView];
        }];
    }
    return _dropView;
}

-(void)openView{
    !_openViewClickBlock ? : _openViewClickBlock();
}

-(void)closeView{
    !_closeViewClickBlock ? : _closeViewClickBlock();
}

@end
