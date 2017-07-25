//
//  PLLabel.m
//  Move
//
//  Created by 舒鑫 on 2016/11/10.
//  Copyright © 2016年 舒鑫. All rights reserved.
//

#import "PLLabel.h"

@implementation PLLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.font = [UIFont fontWithName:@"Helvetica" size:23.0];
        self.textAlignment = NSTextAlignmentCenter;
        self.textColor = [UIColor whiteColor];
    }
    return self;
}
@end
