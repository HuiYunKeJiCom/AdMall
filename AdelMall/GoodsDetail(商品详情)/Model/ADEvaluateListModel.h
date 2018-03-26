//
//  ADEvaluateListModel.h
//  AdelMall
//
//  Created by 张锐凌 on 2018/3/8.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADEvaluateListModel : NSObject
/** id */
@property (nonatomic, copy) NSString      *idx;
/** 用户名称 */
@property (nonatomic, copy) NSString      *userName;
/** 评论时间 */
@property (nonatomic, copy) NSString      *evaluateTime;
/** 评论内容 */
@property (nonatomic, copy) NSString      *evaluateContent;
@end
