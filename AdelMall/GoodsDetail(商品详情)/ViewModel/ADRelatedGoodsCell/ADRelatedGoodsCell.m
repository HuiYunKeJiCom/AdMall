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

@property (nonatomic,strong)UILabel *label1;
@property (nonatomic,strong)UILabel *label2;
@property (nonatomic,strong)UILabel *label3;
@property (nonatomic,strong)UILabel *label4;

@end

@implementation ADRelatedGoodsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _imgView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _label1 = [[UILabel alloc]initWithFrame:CGRectZero];
        _label2 = [[UILabel alloc]initWithFrame:CGRectZero];
        _label3 = [[UILabel alloc]initWithFrame:CGRectZero];
        _label4 = [[UILabel alloc]initWithFrame:CGRectZero];
        
        [self.contentView addSubview:_imgView];
        [self.contentView addSubview:_label1];
        [self.contentView addSubview:_label2];
        [self.contentView addSubview:_label3];
        [self.contentView addSubview:_label4];
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

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _imgView.size = ADRelateGoodLayout_ImgSize;
    _imgView.top = ADRelateGoodLayout_ImgTopMargin;
    _imgView.left = ADRelateGoodLayout_ImgLeftMargin;
    
    //    [_imgView sd_setImageWithURL:[NSURL URLWithString:_layout.item.goods_image_path]];;
    _imgView.backgroundColor = [UIColor greenColor];
    
    _label1.attributedText = _layout.string1;
    _label2.attributedText = _layout.string2;
    _label3.attributedText = _layout.string3;
    _label4.attributedText = _layout.string4;
    
    _label1.size = _layout.string1Size;
    _label1.top = _layout.string1Top;
    _label1.right = self.contentView.width - ADRelateGoodLayout_RightMargin;
    
    _label2.size = _layout.string2Size;
    _label2.top = _layout.string2Top;
    _label2.right = _label1.right;
    
    _label3.size = _layout.string3Size;
    _label3.top = _layout.string3Top;
    _label3.right = _label1.right;
    
    _label4.size = _layout.string4Size;
    _label4.top = _layout.string4Top;
    _label4.right = _label1.right;
    
}

@end
