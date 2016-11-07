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

+ (id)shareInstance;




@property (nonatomic, assign) NSInteger days;


@property (nonatomic, strong) NSMutableArray *healthSteps;
@property (nonatomic, strong) NSMutableArray *healthDistances;
@property (nonatomic, strong) NSMutableArray *healthStairsClimbed;
//@property (nonatomic, copy) id

@end
