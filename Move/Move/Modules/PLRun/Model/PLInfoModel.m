//
//  PLInfoModel.m
//  Move
//
//  Created by 舒鑫 on 2016/11/5.
//  Copyright © 2016年 舒鑫. All rights reserved.
//

#import "PLInfoModel.h"

@implementation PLInfoModel

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_time forKey:@"time"];
    [aCoder encodeObject:_km forKey:@"km"];
    [aCoder encodeObject:_calorie forKey:@"calorie"];
    [aCoder encodeObject:_rate forKey:@"rate"];
    [aCoder encodeObject:_stepCount forKey:@"stepCount"];
    [aCoder encodeObject:_date forKey:@"date"];
    [aCoder encodeObject:_type forKey:@"type"];
    [aCoder encodeObject:_title forKey:@"title"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.time = [aDecoder decodeObjectForKey:@"time"];
        self.km = [aDecoder decodeObjectForKey:@"km"];
        self.calorie = [aDecoder decodeObjectForKey:@"calorie"];
        self.rate = [aDecoder decodeObjectForKey:@"rate"];
        self.stepCount = [aDecoder decodeObjectForKey:@"stepCount"];
        self.date = [aDecoder decodeObjectForKey:@"date"];
        self.type = [aDecoder decodeObjectForKey:@"type"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
    }
    return self;
}
@end
