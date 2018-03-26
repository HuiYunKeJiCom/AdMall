//
//  ADGoodsParameterViewController.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/2/7.
//  Copyright © 2018年 Adel. All rights reserved.
//  商品详情-参数

#import "ADGoodsParameterViewController.h"
#import "ADParameterView.h"

@interface ADGoodsParameterViewController ()
/** 参数View */
@property(nonatomic,strong)ADParameterView *parameterView;
@end

@implementation ADGoodsParameterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createUI];
}

-(void)createUI{
    [self.view addSubview:self.parameterView];
    [self makeConstraints];
}

- (void)makeConstraints {
    WEAKSELF
    
    [self.parameterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left);
//        make.right.equalTo(weakSelf.view.mas_right);
        make.top.equalTo(weakSelf.view.mas_top).with.offset(1);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, GetScaleWidth(260)));
    }];
}

- (ADParameterView *)parameterView {
    if (!_parameterView) {
        _parameterView = [[ADParameterView alloc] initWithFrame:CGRectZero];
        _parameterView.backgroundColor = [UIColor whiteColor];
    }
    return _parameterView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
