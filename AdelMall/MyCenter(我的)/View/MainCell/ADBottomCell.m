//
//  ADBottomCell.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/21.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import "ADBottomCell.h"

@interface ADBottomCell()
@property (nonatomic, strong) UIView *bgView;
/** 底部图片 */
@property(nonatomic,strong)UIImageView *tipIV;
@end

@implementation ADBottomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self initViews];
        [self makeConstraints];
        
    }
    return self;
}

-(void)setFrame:(CGRect)frame {
    //    frame.origin.y += 10;
    [super setFrame:frame];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

#pragma mark - private methord

- (void)initViews{
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.tipIV];
}

- (void)makeConstraints {
    WEAKSELF
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.top.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf.mas_bottom);
    }];
    
    [self.tipIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView.mas_left);
        make.right.equalTo(weakSelf.bgView.mas_right);
        make.bottom.equalTo(weakSelf.bgView.mas_bottom);
        make.height.mas_equalTo(35);
    }];
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectZero];
        _bgView.backgroundColor = [UIColor clearColor];
    }
    return _bgView;
}

-(UIImageView *)tipIV{
    if (!_tipIV) {
        _tipIV = [[UIImageView alloc] init];
        _tipIV.image = [UIImage imageNamed:@"to_bottom"];;
        [_tipIV setContentMode:UIViewContentModeScaleAspectFill];
    }
    return _tipIV;
}


@end
