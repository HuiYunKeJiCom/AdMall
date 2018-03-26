//
//  ADEvaluateListTableViewCell.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/8.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import "ADEvaluateListTableViewCell.h"

@interface ADEvaluateListTableViewCell()
@property (nonatomic, strong) UIView           *bgView;
/** 横线 */
@property(nonatomic,strong)UIView *lineView;
/** 用户头像 */
@property(nonatomic,strong)UIImageView *headerIV;
/** 用户名称 */
@property(nonatomic,strong)UILabel *userNameLab;
/** 购买日期 */
@property(nonatomic,strong)UILabel *purchaseDateLab;
/** 评论内容 */
@property(nonatomic,strong)UILabel *contentLab;
@end

@implementation ADEvaluateListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.lineView];
        [self.bgView addSubview:self.headerIV];
        [self.bgView addSubview:self.userNameLab];
        [self.bgView addSubview:self.purchaseDateLab];
        [self.bgView addSubview:self.contentLab];
        
        [self makeConstraints];
    }
    
    return self;
}

-(void)setFrame:(CGRect)frame {
//    frame.origin.y += 15;
    [super setFrame:frame];
    
}

- (void)setModel:(ADEvaluateListModel *)model {
    _model = model;

    self.userNameLab.text = model.userName;
    self.purchaseDateLab.text = model.evaluateTime;
    self.contentLab.text = model.evaluateContent;
}


#pragma mark - Constraints
- (void)makeConstraints {
    
    WEAKSELF
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.top.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf.mas_bottom);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.bgView.mas_centerX);
        make.top.equalTo(weakSelf.bgView.mas_top);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 1));
    }];
    
    [self.headerIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(10);
        make.top.equalTo(weakSelf.bgView.mas_top).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [self.userNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.headerIV.mas_right).with.offset(10);
        make.centerY.equalTo(weakSelf.headerIV.mas_centerY);
    }];
    
    [self.purchaseDateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.bgView.mas_right).with.offset(-15);
        make.centerY.equalTo(weakSelf.headerIV.mas_centerY);
    }];
    
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(20);
        make.right.equalTo(weakSelf.bgView.mas_right).with.offset(-30);
        make.bottom.equalTo(weakSelf.bgView.mas_bottom).with.offset(-10);
    }];

}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectZero];
        _bgView.backgroundColor = k_UIColorFromRGB(0xffffff);
    }
    return _bgView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectZero];
        _lineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineView;
}

-(UIImageView *)headerIV{
    if (!_headerIV) {
        _headerIV = [[UIImageView alloc] init];
        [_headerIV setBackgroundColor:[UIColor greenColor]];
        [_headerIV setContentMode:UIViewContentModeScaleAspectFill];
        // 设置圆角的大小
        _headerIV.layer.cornerRadius = 5;
        [_headerIV.layer setMasksToBounds:YES];
    }
    return _headerIV;
}

- (UILabel *)userNameLab {
    if (!_userNameLab) {
        _userNameLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor blackColor]];
    }
    return _userNameLab;
}

- (UILabel *)purchaseDateLab {
    if (!_purchaseDateLab) {
        _purchaseDateLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum12 TextColor:[UIColor lightGrayColor]];
    }
    return _purchaseDateLab;
}

- (UILabel *)contentLab {
    if (!_contentLab) {
        _contentLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor blackColor]];
        _contentLab.numberOfLines = 0;
    }
    return _contentLab;
}

@end
