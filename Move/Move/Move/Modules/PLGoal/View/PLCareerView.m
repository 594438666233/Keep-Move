//
//  PLCareerView.m
//  Move
//
//  Created by PhelanGeek on 2016/10/20.
//  Copyright © 2016年 PhelanGeek. All rights reserved.
//

#import "PLCareerView.h"
#import "PLCareerModel.h"

@interface PLCareerView ()

@property (weak, nonatomic) IBOutlet UILabel *stepCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *calorieLabel;
@property (weak, nonatomic) IBOutlet UILabel *kilometreLabel;
@property (weak, nonatomic) IBOutlet UILabel *hoursLabel;

@end

@implementation PLCareerView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]. lastObject;
    }
    return self;
}

- (void)setPlCareerModel:(PLCareerModel *)plCareerModel {
    
    _stepCountLabel.text = plCareerModel.stepCount;
    _calorieLabel.text = plCareerModel.calorie;
    _kilometreLabel.text = plCareerModel.kilometre;
    _hoursLabel.text = plCareerModel.hours;
}

@end
