//
//  ADAdvertModel.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/28.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADAdvertModel : NSObject
/** 广告id */
@property (nonatomic, copy) NSString      *idx;
/** 广告标题 */
@property (nonatomic, copy) NSString      *ad_title;
/** 广告链接 */
@property (nonatomic, copy) NSString      *ad_url;
/** 广告位状态（0=待审核，1=审核通过，-1=审核失败） */
@property (nonatomic, copy) NSString      *ad_status;
/** 广告序列 */
@property (nonatomic, copy) NSString      *ad_slide_sequence;
/** 广告点击量 */
@property (nonatomic, copy) NSString      *ad_click_num;

/** 广告图片路径 */
@property (nonatomic, copy) NSString      *ad_image_path;
/** 广告图片宽度 */
@property (nonatomic, copy) NSString      *ad_image_width;
/** 广告图片高度 */
@property (nonatomic, copy) NSString      *ad_image_height;
/** 广告内容 */
@property (nonatomic, copy) NSString      *ad_text;
/** 广告所属人id */
@property (nonatomic, copy) NSString      *ad_user_id;
/** 广告生效日期 */
@property (nonatomic, copy) NSString      *ad_begin_time;
/** 广告失效日期 */
@property (nonatomic, copy) NSString      *ad_end_time;
@end
