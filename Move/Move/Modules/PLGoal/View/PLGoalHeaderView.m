//
//  PLGoalHeaderView.m
//  Move
//
//  Created by PhelanGeek on 2016/10/19.
//  Copyright © 2016年 PhelanGeek. All rights reserved.
//

#import "PLGoalHeaderView.h"
#import "PLGoalHeaderModel.h"

@interface PLGoalHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *stepLabel;

@end

@implementation PLGoalHeaderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].lastObject;
    }
    return self;
}

- (void)setPlGoalHeaderModel:(PLGoalHeaderModel *)plGoalHeaderModel {
    _dateLabel.text = plGoalHeaderModel.date;
    _stepLabel.text = plGoalHeaderModel.stepCount;
}

@end
