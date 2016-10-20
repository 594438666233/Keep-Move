//
//  PLDefeatView.m
//  
//
//  Created by PhelanGeek on 2016/10/20.
//
//

#import "PLDefeatView.h"

@implementation PLDefeatView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].lastObject;
    }
    return self;
}

@end
