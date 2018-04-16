//
//  ADPriceGoodsViewController.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/13.
//  Copyright © 2018年 Adel. All rights reserved.
//  商品列表-价格筛选

#import "ADPriceGoodsViewController.h"
#import "ADGoodsModel.h"
#import "ADGoodsCell.h"
#import "ADGoodsDetailViewController.h"//商品详情
#import "DCClassGoodsItem.h"
#import "ADBottomCell.h"

@interface ADPriceGoodsViewController ()<UITableViewDelegate,UITableViewDataSource,BaseTableViewDelegate>
@property (nonatomic, strong) BaseTableView         *goodsTable;
/** 当前页数 */
@property(nonatomic)NSInteger currentPage;
@end

@implementation ADPriceGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.goodsTable];
    [self makeConstraints];
}

#pragma mark - Constraints
- (void)makeConstraints {
    
    [self.goodsTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
        //        make.top.equalTo(self.view.mas_bottom).with.offset(GetScaleWidth(10));
    }];
    
}

-(void)loadDataWith:(DCClassGoodsItem *)goodsItem{
    self.currentPage = 1;
    [self requestAllOrder:NO];
}

- (void)requestAllOrder:(BOOL)more {
    [self.goodsTable updateLoadState:more];
    NSLog(@"商品列表goodsID = %@",self.subItem.idx);
    WEAKSELF
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [RequestTool getGoodsList:@{@"orderBy":@"store_price",@"gc_id":self.subItem.idx} withSuccessBlock:^(NSDictionary *result) {
        NSLog(@"获取列表result = %@",result);
        if([result[@"code"] integerValue] == 1){
            [hud hide:YES];
            [weakSelf handleTransferResult:result more:more];
        }else if([result[@"code"] integerValue] == -2){
            self.currentPage -= 1;
            hud.detailsLabelText = @"登录失效";
            hud.mode = MBProgressHUDModeText;
            [hud hide:YES afterDelay:1.0];
        }else if([result[@"code"] integerValue] == -1){
            self.currentPage -= 1;
            hud.detailsLabelText = @"未登录";
            hud.mode = MBProgressHUDModeText;
            [hud hide:YES afterDelay:1.0];
        }else if([result[@"code"] integerValue] == 0){
            self.currentPage -= 1;
            hud.detailsLabelText = @"失败";
            hud.mode = MBProgressHUDModeText;
            [hud hide:YES afterDelay:1.0];
        }else if([result[@"code"] integerValue] == 2){
            self.currentPage -= 1;
            hud.detailsLabelText = @"无返回数据";
            hud.mode = MBProgressHUDModeText;
            [hud hide:YES afterDelay:1.0];
        }
    } withFailBlock:^(NSString *msg) {
        self.currentPage -= 1;
        NSLog(@"商品列表价格msg = %@",msg);
        hud.detailsLabelText = msg;
        hud.mode = MBProgressHUDModeText;
        [hud hide:YES afterDelay:1.0];
    }];
    
//    [weakSelf handleTransferResult:nil more:more];
    //                                   }];
    
}

- (void)handleTransferResult:(NSDictionary *)result more:(BOOL)more{
    
    NSArray *dataArr = [NSArray array];
    if ([result isKindOfClass:[NSDictionary class]]) {
//        NSLog(@"来这里了吗");
        NSArray *dataInfo = result[@"data"][@"goodsList"];
        if ([dataInfo isKindOfClass:[NSArray class]]) {
            dataArr = dataInfo;
        }
    }
    
    [self.goodsTable.data removeAllObjects];
    for (NSDictionary *dic in dataArr) {
        ADGoodsModel *model = [ADGoodsModel mj_objectWithKeyValues:dic];
        [self.goodsTable.data addObject:model];
    }
    
    [self.goodsTable updatePage:more];
    //    self.allOrderTable.isLoadMore = dataArr.count >= k_RequestPageSize ? YES : NO;
    self.goodsTable.noDataView.hidden = self.goodsTable.data.count;
    [self.goodsTable reloadData];
}


- (BaseTableView *)goodsTable {
    if (!_goodsTable) {
        _goodsTable = [[BaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _goodsTable.delegate = self;
        _goodsTable.dataSource = self;
        _goodsTable.isLoadMore = YES;
        _goodsTable.isRefresh = YES;
        _goodsTable.delegateBase = self;
        [_goodsTable registerClass:[ADGoodsCell class] forCellReuseIdentifier:@"ADGoodsCell"];
        [_goodsTable registerClass:[ADBottomCell class] forCellReuseIdentifier:@"ADBottomCell"];
    }
    return _goodsTable;
}

#pragma mark - UITableViewDelegate

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 10.0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.goodsTable.data.count+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == self.goodsTable.data.count){
        return 40+15;
    }else{
        return kScreenWidth == 320 ? 140 : GetScaleWidth(140);
    }
}

//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return self.goodsTable.data.count;
//}

//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    //设置间隔高度
//    return 0.001;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 0.001;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.row == self.goodsTable.data.count){
        ADBottomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ADBottomCell"];
        
        if (!cell) {
            cell = [[ADBottomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ADBottomCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
    }else{
        ADGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ADGoodsCell"];
        if (self.goodsTable.data.count > indexPath.row) {
            ADGoodsModel *model = self.goodsTable.data[indexPath.row];
            cell.model = model;
        }
        
        cell.imageViewBtnClickBlock = ^{
            //商品详情
            ADGoodsDetailViewController *goodsDetailVC = [[ADGoodsDetailViewController alloc] init];
            [self.navigationController pushViewController:goodsDetailVC animated:YES];
        };
        
        return cell;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    if (self.allOrderTable.data.count > indexPath.row) {
    //        WLTransferAccountModel *model = self.accountTable.data[indexPath.row];
    //        NSLog(@"查看的信息model = %@",model.mj_keyValues);
    //        WLInformDetailCtrl *ctrl = [[WLInformDetailCtrl alloc] init];
    //        ctrl.accountModel = model;
    //        ctrl.messageDetail = NO;
    //        [self.navigationController pushViewController:ctrl animated:YES];
    //    }
}

- (void)baseTableVIew:(BaseTableView *)tableView refresh:(BOOL)flag {
    [self requestAllOrder:NO];
}

- (void)baseTableView:(BaseTableView *)tableView loadMore:(BOOL)flag {
    self.currentPage += 1;
    [self requestAllOrder:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
