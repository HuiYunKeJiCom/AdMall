//
//  ADLMyInfoTableViewFooterCell.m
//  EasyLife
//
//  Created by 朱鹏 on 16/10/24.
//  Copyright © 2016年 CCJ. All rights reserved.
//

#import "ADLMyInfoTableViewFooterCell.h"
#import "ADLMyInfoModel.h"

@interface ADLMyInfoTableViewFooterCell ()


@end

@implementation ADLMyInfoTableViewFooterCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initViews];
        [self makeConstraints];
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - getter


- (UIImageView *)leftImgView {
    
    if (!_leftImgView) {
        _leftImgView = [[UIImageView alloc] initWithImage:IMAGE(@"my_exit")];
    }
    
    return _leftImgView;
}

- (UILabel *)titleLb {
    
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] initWithFrame:CGRectZero FontSize:15 TextColor:KColorText323232];
        _titleLb.text = KLocalizableStr(@"退出登录");
    }
    
    return _titleLb;
    
}

#pragma mark - private methord

- (void)initViews{
    
    [self.contentView addSubview:self.leftImgView];
    [self.contentView addSubview:self.titleLb];
    
}

- (void)makeConstraints {
    
    WEAKSELF
    [self.leftImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).with.offset(23);
        make.centerY.equalTo(weakSelf.contentView);
//        make.size.mas_equalTo(CGSizeMake(17, 18));
    }];
    
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.leftImgView.mas_right).with.offset(8);
        make.centerY.equalTo(weakSelf.contentView);
    }];
    
}

@end
