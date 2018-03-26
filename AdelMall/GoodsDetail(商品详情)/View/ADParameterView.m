//
//  ADParameterView.m
//  AdelMall
//
//  Created by 张锐凌 on 2018/2/8.
//  Copyright © 2018年 Adel. All rights reserved.
//  商品详情-参数-参数表

#import "ADParameterView.h"

@interface ADParameterView()
/** 品牌标题 */
@property(nonatomic,strong)UILabel *brandTitLab;
/** 品牌名称 */
@property(nonatomic,strong)UILabel *brandNameLab;
/** 型号标题 */
@property(nonatomic,strong)UILabel *typeTitLab;
/** 型号名称 */
@property(nonatomic,strong)UILabel *typeNameLab;
/** 颜色标题 */
@property(nonatomic,strong)UILabel *colorTitLab;
/** 颜色名称 */
@property(nonatomic,strong)UILabel *colorNameLab;
/** 面板材质标题 */
@property(nonatomic,strong)UILabel *panelTitLab;
/** 面板材质名称 */
@property(nonatomic,strong)UILabel *panelNameLab;
/** 电源类型标题 */
@property(nonatomic,strong)UILabel *powerTitLab;
/** 电源类型名称 */
@property(nonatomic,strong)UILabel *powerNameLab;
/** 电子类型标题 */
@property(nonatomic,strong)UILabel *electronicsTitLab;
/** 电子类型名称 */
@property(nonatomic,strong)UILabel *electronicsNameLab;
/** 数据存储标题 */
@property(nonatomic,strong)UILabel *storageTitLab;
/** 数据存储名称 */
@property(nonatomic,strong)UILabel *storageNameLab;
@end

@implementation ADParameterView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
        
    }
    
    return self;
}

- (void)initViews {
    [self addSubview:self.brandTitLab];
    [self addSubview:self.brandNameLab];
    [self addSubview:self.typeTitLab];
    [self addSubview:self.typeNameLab];
    [self addSubview:self.colorTitLab];
    [self addSubview:self.colorNameLab];
    [self addSubview:self.panelTitLab];
    [self addSubview:self.panelNameLab];
    [self addSubview:self.powerTitLab];
    [self addSubview:self.powerNameLab];
    [self addSubview:self.electronicsTitLab];
    [self addSubview:self.electronicsNameLab];
    [self addSubview:self.storageTitLab];
    [self addSubview:self.storageNameLab];
    
    [self makeConstraints];
    [self setUpData];
    
}

-(void)setUpData{
    self.brandTitLab.text = @"品牌：";
    self.typeTitLab.text = @"型号：";
    self.colorTitLab.text = @"饰面颜色：";
    self.panelTitLab.text = @"面板及执手材质：";
    self.powerTitLab.text = @"电源类型：";
    self.electronicsTitLab.text = @"电子类型：";
    self.storageTitLab.text = @"数据存储类型：";
    
    self.brandNameLab.text = @"ADEL/爱迪尔";
    self.typeNameLab.text = @"US99";
//    self.colorNameLab.text = @"三合一(亮金色)";
    self.panelNameLab.text = @"锌合金";
    self.powerNameLab.text = @"4节AA电池供电，可使用应急外接电源";
    self.electronicsNameLab.text = @"感应锁 密码锁 指纹锁";
    self.storageNameLab.text = @"离线";
    
    NSArray *colorArr = @[@"三合一(亮金色)",@"三合一(亮铬色)",@"三合一(红古铜色)",@"三合一(咖啡铜色)"];
    NSMutableString *newStr = [[NSMutableString alloc] init];
    NSString *colorText = @"";
    for(int i=0;i<colorArr.count;i++){
        [newStr appendString:[NSString stringWithFormat:@"%@\n",colorArr[i]]];
    }
    colorText = newStr;
    if ([colorText hasSuffix:@"\n"]) {
        colorText = [colorText substringToIndex:newStr.length-1];
    }

    //改变行间距
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:colorText];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:10];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [colorText length])];
    [self.colorNameLab setAttributedText:attributedString1];
    [self.colorNameLab sizeToFit];
    
    self.colorNameLab.text = colorText;
}

- (void)makeConstraints {
    WEAKSELF
    
    [self.brandTitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(30);
        make.top.equalTo(weakSelf).with.offset(10);
    }];
    
    [self.brandNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.brandTitLab.mas_right);
        make.top.equalTo(weakSelf).with.offset(10);
    }];
    
    [self.typeTitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(30);
        make.top.equalTo(weakSelf.brandTitLab.mas_bottom).with.offset(10);
    }];
    
    [self.typeNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.typeTitLab.mas_right);
        make.top.equalTo(weakSelf.brandTitLab.mas_bottom).with.offset(10);
    }];
    
    [self.colorTitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(30);
        make.top.equalTo(weakSelf.typeTitLab.mas_bottom).with.offset(10);
    }];
    
    [self.colorNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.colorTitLab.mas_right);
        make.top.equalTo(weakSelf.typeTitLab.mas_bottom).with.offset(10);
    }];
    
    [self.panelTitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(30);
        make.top.equalTo(weakSelf.colorNameLab.mas_bottom).with.offset(10);
    }];
    
    [self.panelNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.panelTitLab.mas_right);
        make.top.equalTo(weakSelf.colorNameLab.mas_bottom).with.offset(10);
    }];
    
    [self.powerTitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(30);
        make.top.equalTo(weakSelf.panelNameLab.mas_bottom).with.offset(10);
    }];
    
    [self.powerNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.powerTitLab.mas_right);
        make.top.equalTo(weakSelf.panelNameLab.mas_bottom).with.offset(10);
    }];
    
    [self.electronicsTitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(30);
        make.top.equalTo(weakSelf.powerNameLab.mas_bottom).with.offset(10);
    }];
    
    [self.electronicsNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.electronicsTitLab.mas_right);
        make.top.equalTo(weakSelf.powerNameLab.mas_bottom).with.offset(10);
    }];
    
    [self.storageTitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(30);
        make.top.equalTo(weakSelf.electronicsNameLab.mas_bottom).with.offset(10);
    }];
    
    [self.storageNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.storageTitLab.mas_right);
        make.top.equalTo(weakSelf.electronicsNameLab.mas_bottom).with.offset(10);
    }];
    
}

- (UILabel *)brandTitLab {
    if (!_brandTitLab) {
        _brandTitLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor blackColor]];
    }
    return _brandTitLab;
}

- (UILabel *)brandNameLab {
    if (!_brandNameLab) {
        _brandNameLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor blackColor]];
    }
    return _brandNameLab;
}

- (UILabel *)typeTitLab {
    if (!_typeTitLab) {
        _typeTitLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor blackColor]];
    }
    return _typeTitLab;
}

- (UILabel *)typeNameLab {
    if (!_typeNameLab) {
        _typeNameLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor blackColor]];
    }
    return _typeNameLab;
}

- (UILabel *)colorTitLab {
    if (!_colorTitLab) {
        _colorTitLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor blackColor]];
    }
    return _colorTitLab;
}

- (UILabel *)colorNameLab {
    if (!_colorNameLab) {
        _colorNameLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor blackColor]];
        _colorNameLab.numberOfLines = 0;
        
    }
    return _colorNameLab;
}

- (UILabel *)panelTitLab {
    if (!_panelTitLab) {
        _panelTitLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor blackColor]];
    }
    return _panelTitLab;
}

- (UILabel *)panelNameLab {
    if (!_panelNameLab) {
        _panelNameLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor blackColor]];
    }
    return _panelNameLab;
}

- (UILabel *)powerTitLab {
    if (!_powerTitLab) {
        _powerTitLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor blackColor]];
    }
    return _powerTitLab;
}

- (UILabel *)powerNameLab {
    if (!_powerNameLab) {
        _powerNameLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor blackColor]];
    }
    return _powerNameLab;
}

- (UILabel *)electronicsTitLab {
    if (!_electronicsTitLab) {
        _electronicsTitLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor blackColor]];
    }
    return _electronicsTitLab;
}

- (UILabel *)electronicsNameLab {
    if (!_electronicsNameLab) {
        _electronicsNameLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor blackColor]];
    }
    return _electronicsNameLab;
}

- (UILabel *)storageTitLab {
    if (!_storageTitLab) {
        _storageTitLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor blackColor]];
    }
    return _storageTitLab;
}

- (UILabel *)storageNameLab {
    if (!_storageNameLab) {
        _storageNameLab = [[UILabel alloc] initWithFrame:CGRectZero FontSize:kFontNum14 TextColor:[UIColor blackColor]];
    }
    return _storageNameLab;
}

@end
