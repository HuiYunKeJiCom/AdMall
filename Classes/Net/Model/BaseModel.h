//
//  BaseModel.h
//  AdelMall
//
//  Created by apple on 2018/4/16.
//  Copyright © 2018年 Adel. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface BaseModel : NSObject

@property (nonatomic,assign)NSInteger code;//状态码
@property (nonatomic,copy)NSString *message;//返回信息
@property (nonatomic,strong)NSDictionary *data;//承载主体部分

@end
