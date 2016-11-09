//
//  PLGoalHeaderModel.m
//  Move
//
//  Created by PhelanGeek on 2016/10/20.
//  Copyright © 2016年 PhelanGeek. All rights reserved.
//

#import "PLGoalHeaderModel.h"
#import "PLXHealthManager.h"

@implementation PLGoalHeaderModel


- (NSString *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    NSString *timeString = [formatter stringFromDate:[NSDate date]];
    return timeString;
}

- (NSString *)stepCount {
    PLXHealthManager *manager = [PLXHealthManager shareInstance];
    manager.isDay = YES;
    manager.days = 1;
    __block NSString *temp = @"";
    [manager getStepCount:^(double value, NSArray *array, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            temp = [NSString stringWithFormat:@"%lf", value];
        });
    }];
    return temp;
}

@end
