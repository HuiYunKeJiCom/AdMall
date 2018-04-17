//
//  DCClassGoodsItem.h
//  CDDMall
//
//  Created by apple on 2017/6/8.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCClassGoodsItem : NSObject

///** 文标题  */
//@property (nonatomic, copy ,readonly) NSString *title;
///** plist  */
//@property (nonatomic, copy ,readonly) NSString *fileName;

/** 分类id (用来获取列表数据) */
@property (nonatomic, copy) NSString      *idx;
/** 分类创建时间  */
@property (nonatomic, copy) NSString *addTime;
/** 分类名称  */
@property (nonatomic, copy) NSString *className;
/** 是否显示  */
@property (nonatomic, copy) NSString *display;
/** 分类级别  */
@property (nonatomic, copy) NSString *level;
/** 是否为推荐分类  */
@property (nonatomic, copy) NSString *recommend;
/** 序列  */
@property (nonatomic, copy) NSString *sequence;
/** 父级分类id  */
@property (nonatomic, copy) NSString *parent_id;
/** 分类图标类型  */
@property (nonatomic, copy) NSString *icon_type;
/** 分类图标系统  */
@property (nonatomic, copy) NSString *icon_sys;
/** 分类图标路径  */
@property (nonatomic, copy) NSString *icon_path;
/** 子分类  */
@property (nonatomic, strong) NSArray<DCClassGoodsItem *> *children;
@end
