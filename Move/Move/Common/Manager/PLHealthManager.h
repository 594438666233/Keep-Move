//
//  PLHealthManager.h
//  Move
//
//  Created by PhelanGeek on 2016/10/21.
//  Copyright © 2016年 PhelanGeek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PLHealthManager : NSObject

- (void)getIphoneHealthData;

@property (nonatomic, assign) NSInteger days;

@end
