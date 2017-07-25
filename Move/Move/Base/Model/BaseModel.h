//
//  BaseModel.h
//  GP_ITHome
//
//  Created by 舒鑫 on 16/9/19.
//  Copyright © 2016年 舒鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)modelWithDic:(NSDictionary *)dic;

@end
