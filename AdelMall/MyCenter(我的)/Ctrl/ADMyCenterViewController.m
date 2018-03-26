//
//  ADMyCenterViewController.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/1/29.
//  Copyright © 2018年 Adel. All rights reserved.
//  我的

#import "ADMyCenterViewController.h"
#import "ADMycenterHeaderView.h"
#import "ADCenterTopToolView.h"
#import "DCGridItem.h"
#import "ADLMyInfoTableView.h"
#import "ADOrderListViewController.h"//订单页面
#import "ADAfterSaleServiceViewController.h"//售后
//#import "ADGoodsDetailViewController.h"
#import "ADCouponViewController.h"//优惠券
#import "ADReceivingAddressViewController.h"//收货地址
#import "ADEvaluationGoodsViewController.h"//评价商品
#import "YWAddressViewController.h"//收货地址 编辑页面

@interface ADMyCenterViewController ()<ADLMyInfoTableViewDelegate>
/* headView */
@property (strong , nonatomic)ADMycenterHeaderView *headView;
/* 头部背景图片 */
@property (nonatomic, strong) UIImageView *headerBgImageView;
/* tableView */
//@property (strong , nonatomic)UITableView *tableView;
/* 顶部Nva */
@property (strong , nonatomic)ADCenterTopToolView *topToolView;

/* 我的订单数据 */
@property (strong , nonatomic)NSMutableArray<DCGridItem *> *orderItem;

@property (strong, nonatomic) ADLMyInfoTableView   *otherTableView;
@end



@implementation ADMyCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpData];
    [self.view addSubview:self.otherTableView];
    [self setUpBase];
    [self setUpNavTopView];
    [self setUpHeaderCenterView];
    [self makeConstraints];
    
}

- (void)makeConstraints {
    WEAKSELF
    [self.otherTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.view);
        make.bottom.mas_equalTo(weakSelf.view).with.offset(-50);
        make.left.right.mas_equalTo(weakSelf.view);
    }];
}

#pragma mark - 获取数据
- (void)setUpData
{
    _orderItem = [DCGridItem mj_objectArrayWithFilename:@"MyServiceFlow.plist"];
    [self.otherTableView.data addObject:[[ADLMyInfoModel alloc] initWithTitle:KLocalizableStr(@"我的订单") imageName:@"my_ico_order" num:KLocalizableStr(@"全部")]];
    [self.otherTableView.data addObject:[[ADLMyInfoModel alloc] initWithTitle:KLocalizableStr(@"评价商品") imageName:@"my_ico_goods" num:KLocalizableStr(@"全部")]];
    [self.otherTableView.data addObject:[[ADLMyInfoModel alloc] initWithTitle:KLocalizableStr(@"喜欢的商品") imageName:@"my_ico_like" num:KLocalizableStr(@"全部")]];
    [self.otherTableView.data addObject:[[ADLMyInfoModel alloc] initWithTitle:KLocalizableStr(@"优惠券") imageName:@"my_ico_coupon" num:KLocalizableStr(@"全部")]];
    [self.otherTableView.data addObject:[[ADLMyInfoModel alloc] initWithTitle:KLocalizableStr(@"收货地址") imageName:@"my_ico_address" num:KLocalizableStr(@"编辑")]];
    [self.otherTableView.data addObject:[[ADLMyInfoModel alloc] initWithTitle:KLocalizableStr(@"常见问题") imageName:@"my_ico_question" num:KLocalizableStr(@"查看")]];
}

#pragma mark - initialize
- (void)setUpBase {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.otherTableView.tableFooterView = [UIView new]; //去除多余分割线
}

#pragma mark - 导航栏处理
- (void)setUpNavTopView
{
    _topToolView = [[ADCenterTopToolView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    _topToolView.hidden = NO;
    
    [self.view addSubview:_topToolView];
    
}

#pragma mark - 初始化头部
- (void)setUpHeaderCenterView{
    self.otherTableView.tableHeaderView = self.headView;
    self.headerBgImageView.frame = self.headView.bounds;
    [self.headView insertSubview:self.headerBgImageView atIndex:0]; //将背景图片放到最底层
}

#pragma mark - LazyLoad
- (ADLMyInfoTableView *)otherTableView {
    WEAKSELF
    if (!_otherTableView) {
        _otherTableView = [[ADLMyInfoTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _otherTableView.backgroundColor = kBACKGROUNDCOLOR;
        _otherTableView.bounces = NO;
        _otherTableView.tbDelegate = self;
        _otherTableView.isRefresh = NO;
        _otherTableView.isLoadMore = NO;
        _otherTableView.orderItemArray = _orderItem;
        if (@available(iOS 11.0, *)) {
            _otherTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _otherTableView.viewBtnClickBlock = ^{
            // 这里传入需要编辑的地址信息，例如:
            YWAddressViewController *addressVC = [[YWAddressViewController alloc] init];
            YWAddressInfoModel *model = [YWAddressInfoModel alloc];
            model.phoneStr = @"18888888888";
            model.nameStr = @"袁伟";
            model.areaAddress = @"四川省成都市武侯区";
            model.detailAddress = @"下一站都市B座406";
            model.isDefaultAddress = NO; // 如果是默认地址则传入YES
            addressVC.model = model;
            // 保存后的地址回调
            addressVC.addressBlock = ^(YWAddressInfoModel *model) {
                NSLog(@"用户地址信息填写回调：");
                NSLog(@"姓名：%@", model.nameStr);
                NSLog(@"电话：%@", model.phoneStr);
                NSLog(@"地区：%@", model.areaAddress);
                NSLog(@"详细地址：%@", model.detailAddress);
                NSLog(@"是否设为默认：%@", model.isDefaultAddress ? @"是" : @"不是");
            };
            
            [weakSelf.navigationController pushViewController:addressVC animated:YES];
        };
        //        _tableView.tableFooterView = self.footerView;
    }
    return _otherTableView;
}

- (ADMycenterHeaderView *)headView
{
    if (!_headView) {
        _headView = [[ADMycenterHeaderView alloc] init];
        _headView.frame =  CGRectMake(0, 0, kScreenWidth, 200);
        _headView.headClickBlock = ^{
            NSLog(@"点击了头像");
        };
    }
    return _headView;
}

- (UIImageView *)headerBgImageView{
    if (!_headerBgImageView) {
        _headerBgImageView = [[UIImageView alloc] init];
//        [_headerBgImageView setImage:[UIImage imageNamed:@"icon"]];
        [_headerBgImageView setBackgroundColor:k_UIColorFromRGB(0xFF4040)];
        [_headerBgImageView setContentMode:UIViewContentModeScaleAspectFill];
        [_headerBgImageView setClipsToBounds:YES];
    }
    return _headerBgImageView;
}

- (NSMutableArray<DCGridItem *> *)orderItem
{
    if (!_orderItem) {
        _orderItem = [NSMutableArray array];
    }
    return _orderItem;
}

#pragma mark - ADLMyInfoTableViewDelegate

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger index = indexPath.section;
    
    switch (index) {
        case 0:{
            NSLog(@"点击了我的订单");
//            [self enterHelp];
            ADOrderListViewController *orderListOrder=[[ADOrderListViewController alloc]init];
            orderListOrder.index=0;
            [self.navigationController pushViewController:orderListOrder animated:YES];
//            ADGoodsDetailViewController *goodsDetail = [[ADGoodsDetailViewController alloc]init];
//            goodsDetail.index = 2;
//            [self.navigationController pushViewController:goodsDetail animated:YES];
        }
            break;
        case 1:{
            NSLog(@"点击了评价商品");
            ADEvaluationGoodsViewController *evaluationGoods=[[ADEvaluationGoodsViewController alloc]init];
            evaluationGoods.index=0;
            [self.navigationController pushViewController:evaluationGoods animated:YES];
//            [self enterAdvice];
        }
            break;
        case 2:{
            NSLog(@"点击了喜欢的商品");
//            [self enterChat];
        }
            break;
        case 3:{
            NSLog(@"点击了优惠券");
            ADCouponViewController *couponVC=[[ADCouponViewController alloc]init];
            couponVC.index=0;
            [self.navigationController pushViewController:couponVC animated:YES];
//            [self enterUserRoomRecord];
        }
            break;
        case 4:{
            NSLog(@"点击了收货地址");
            ADReceivingAddressViewController *receivingAddress = [[ADReceivingAddressViewController alloc]init];
            [self.navigationController pushViewController:receivingAddress animated:YES];
//            [self enterSetting];
        }
            break;
        case 5:{
            NSLog(@"点击了常见问题");
            //            [self enterSetting];
        }
            break;
        default:
            break;
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger index = indexPath.row;
    switch (index) {
        case 0:{
                NSLog(@"点击了未支付");
            ADOrderListViewController *orderListOrder=[[ADOrderListViewController alloc]init];
            orderListOrder.index=1;
            [self.navigationController pushViewController:orderListOrder animated:YES];
            }
            break;
        case 1:{
            NSLog(@"点击了未发货");
            ADOrderListViewController *orderListOrder=[[ADOrderListViewController alloc]init];
            orderListOrder.index=2;
            [self.navigationController pushViewController:orderListOrder animated:YES];
            //            [self enterSetting];
        }
            break;
        case 2:{
            NSLog(@"点击了售后");
            ADAfterSaleServiceViewController *AfterSale = [[ADAfterSaleServiceViewController alloc]init];
            [self.navigationController pushViewController:AfterSale animated:YES];
            
            //            [self enterSetting];
        }
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
