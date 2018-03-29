//
//  ADCountDownActivityModel.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/27.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADCountDownActivityModel : NSObject
/** 抢购活动id */
@property (nonatomic, copy) NSString      *idx;
/** 活动创建时间 */
@property (nonatomic, copy) NSString      *addTime;
/** 活动开始时间 */
@property (nonatomic, copy) NSString      *startTime;
/** 活动结束时间 */
@property (nonatomic, copy) NSString      *closeTime;
/** 活动名称 */
@property (nonatomic, copy) NSString      *group_name;
/** 抢购活动状态 */
@property (nonatomic, copy) NSString      *status;
@end
