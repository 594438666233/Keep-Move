//
//  PLCareerView.m
//  Move
//
//  Created by PhelanGeek on 2016/10/20.
//  Copyright © 2016年 PhelanGeek. All rights reserved.
//

#import "PLCareerView.h"

@implementation PLCareerView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]. lastObject;
    }
    return self;
}
@end
