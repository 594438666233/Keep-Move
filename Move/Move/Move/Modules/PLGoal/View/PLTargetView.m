//
//  PLTargetView.m
//  Move
//
//  Created by PhelanGeek on 2016/10/19.
//  Copyright © 2016年 PhelanGeek. All rights reserved.
//

#import "PLTargetView.h"
#import "PLTargetModel.h"

@interface PLTargetView ()
@property (weak, nonatomic) IBOutlet UILabel *targetLabel;
@property (weak, nonatomic) IBOutlet UILabel *basicGoalLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastWeekCalorieLabel;

@end

@implementation PLTargetView
- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].lastObject;
    }
    return self;
}

- (void)setPlTargetModel:(PLTargetModel *)plTargetModel {
    _targetLabel.text = plTargetModel.target;
    _basicGoalLabel.text = plTargetModel.basicGoal;
    _lastWeekCalorieLabel.text = plTargetModel.lastWeekCalorie;
}

@end
