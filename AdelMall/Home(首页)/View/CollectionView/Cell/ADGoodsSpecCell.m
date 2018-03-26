//
//  ADGoodsSpecCell.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/17.
//  Copyright © 2018年 Adel. All rights reserved.
//  商品规格

#import "ADGoodsSpecCell.h"
#import "GoodAttrModel.h"
#import "GoodAttributesView.h"

// 筛选框 上下的图片
#define kDownImg [UIImage imageNamed:@"arrow_down.png"]
#define kUpImg [UIImage imageNamed:@"arrow_up.png"]

@interface ADGoodsSpecCell()
@property (nonatomic, strong) UIView* bgView;
/** 已选择 标题 */
@property (strong , nonatomic)UILabel *chosenTitLabel;
/** 已选择  */
@property (strong , nonatomic)UILabel *chosenLabel;
/** 规格选择View  */
@property (strong , nonatomic)GoodAttributesView *attributesView;
/** 展开选择页面 按钮 */
@property(nonatomic,strong)UIButton *openSpecViewBtn;
@property (nonatomic, strong) NSArray *goodAttrsArr;
/** 是否打开地址筛选框 */
@property(nonatomic,assign)BOOL isOpen;
@end


@implementation ADGoodsSpecCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        //        self.userInteractionEnabled = YES;
        [self setUpUI];
        [self setUpData];
    }
    return self;
}

- (void)setUpUI{
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.chosenTitLabel];
    [self.bgView addSubview:self.chosenLabel];
    [self.bgView addSubview:self.openSpecViewBtn];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self makeConstraints];
}

#pragma mark - 填充数据
-(void)setUpData{
    self.chosenTitLabel.text = @"未选择:";
    self.chosenLabel.text = @"类型/数量";
//    [self.openSpecViewBtn setTitle:@"v" forState:UIControlStateNormal];
    [self.openSpecViewBtn setImage:kDownImg forState:UIControlStateNormal];

    [self createData];
}

- (void)createData {
    GoodAttrModel *model0 = [GoodAttrModel new];
    model0.attr_id = @"10";
    model0.attr_name = @"方向";
    GoodAttrValueModel *value1 = [GoodAttrValueModel new];
    value1.attr_value = @"左侧开";
    GoodAttrValueModel *value2 = [GoodAttrValueModel new];
    value2.attr_value = @"右侧开";
    model0.attr_value = [NSArray arrayWithObjects:value1, value2, nil];
    
    GoodAttrModel *model1 = [GoodAttrModel new];
    model1.attr_id = @"11";
    model1.attr_name = @"颜色";
    GoodAttrValueModel *value10 = [GoodAttrValueModel new];
    value10.attr_value = @"三合一(金色)";
    GoodAttrValueModel *value20 = [GoodAttrValueModel new];
    value20.attr_value = @"三合一(亮铬色)";
    GoodAttrValueModel *value30 = [GoodAttrValueModel new];
    value30.attr_value = @"三合一(红古铜色)";
    GoodAttrValueModel *value40 = [GoodAttrValueModel new];
    value40.attr_value = @"三合一(咖啡铜色)";
    GoodAttrValueModel *value50 = [GoodAttrValueModel new];
    value50.attr_value = @"三合一(亮金色)";
    GoodAttrValueModel *value60 = [GoodAttrValueModel new];
    value60.attr_value = @"三合一(亮铬色)";
    model1.attr_value = [NSArray arrayWithObjects:value10, value20, value30, value40, value50, value60, nil];
    
    self.goodAttrsArr = [NSArray arrayWithObjects:model1, model0, nil];
}

- (void)createAttributesView {
    //    __weak typeof(self) _weakSelf = self;
    self.attributesView = [[GoodAttributesView alloc] initWithFrame:(CGRect){0, 40, kScreenWidth, kScreenHeight}];
    self.attributesView.goodAttrsArr = self.goodAttrsArr;
    //    attributesView.good_img = self.goodDetailModel.goods_img;
    //    attributesView.good_name = self.goodDetailModel.goods_name;
    //    attributesView.good_price = self.goodDetailModel.shop_price;

//    self.attributesView.backgroundColor = [UIColor redColor];
    [self.attributesView showInView:self.bgView];
}

- (void)makeConstraints {
    WEAKSELF
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.top.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf.mas_bottom);
//        make.height.mas_equalTo(40);
    }];
    
    [self.chosenTitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(40);
        make.top.equalTo(weakSelf.bgView.mas_top).with.offset(10);
    }];
    
    [self.chosenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.chosenTitLabel.mas_right).with.offset(20);
        make.top.equalTo(weakSelf.bgView.mas_top).with.offset(10);
    }];
    
    [self.openSpecViewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.bgView.mas_right).with.offset(-16);
        make.top.equalTo(weakSelf.bgView.mas_top).with.offset(10);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(20);
    }];

}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectZero];
        _bgView.backgroundColor = [UIColor whiteColor];
        //        _bgView.userInteractionEnabled = YES;
    }
    return _bgView;
}

- (UILabel *)chosenTitLabel {
    if (!_chosenTitLabel) {
        _chosenTitLabel = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor blackColor]];
    }
    return _chosenTitLabel;
}

- (UILabel *)chosenLabel {
    if (!_chosenLabel) {
        _chosenLabel = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor blackColor]];
    }
    return _chosenLabel;
}

- (UIButton *)openSpecViewBtn {
    if (!_openSpecViewBtn) {
        _openSpecViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _openSpecViewBtn.titleLabel.font = [UIFont systemFontOfSize:kFontNum11];
        _openSpecViewBtn.backgroundColor = [UIColor clearColor];
        [_openSpecViewBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_openSpecViewBtn addTarget:self action:@selector(openSpecViewBtnButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _openSpecViewBtn;
}

#pragma mark - 展开选择页面 点击
- (void)openSpecViewBtnButtonClick {
    WEAKSELF
    NSLog(@"展开选择页面");
    if(self.isOpen){
        NSLog(@"收起");
        self.isOpen = NO;
        [self.openSpecViewBtn setImage:kDownImg forState:UIControlStateNormal];
        self.attributesView.sureBtnsClick = ^(NSString *num, NSString *attrs, NSString *goods_attr_value_1, NSString *goods_attr_value_2) {
            NSLog(@"\n购物数量：%@ \n 第一个属性：%@ \n 第二个属性：%@", num, goods_attr_value_1, goods_attr_value_2);
            if(goods_attr_value_1 && goods_attr_value_2){
                weakSelf.chosenTitLabel.text = @"已选择:";
                weakSelf.chosenLabel.text = [NSString stringWithFormat:@"\"%@\"、\"%@\"、数量:%@",goods_attr_value_1,goods_attr_value_2,num];
            }
        };
        [self.attributesView sureBtnClick];
        [self.attributesView removeFromSuperview];
        [self closeView];
    }else{
        NSLog(@"展开");
        self.isOpen = YES;
        [self.openSpecViewBtn setImage:kUpImg forState:UIControlStateNormal];
        [self createAttributesView];
        [self openView];
    }
}

-(void)openView{
    !_openViewClickBlock ? : _openViewClickBlock();
}

-(void)closeView{
    !_closeViewClickBlock ? : _closeViewClickBlock();
}
@end
