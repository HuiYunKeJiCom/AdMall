//
//  ADRelatedGoodsCell.m
//  AdelMall
//
//  Created by apple on 2018/4/19.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import "ADRelatedGoodsCell.h"

@interface ADRelatedGoodsCell()

@property (nonatomic,strong)UIImageView *imgView;//图片

@end

@implementation ADRelatedGoodsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
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

- (void)setLayout:(ADRelatedGoodsLayout *)layout{
    _layout = layout;
    self.height = _layout.height;
    self.contentView.height = _layout.height;
    
    
    
    
}

@end
