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
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, strong) UIView *lineView;

@end

@implementation PLTargetView
- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].lastObject;
        [self createLineView];
    }
    return self;
}

- (void)createLineView {
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(_imageView.frame.origin.x, _imageView.frame.origin.y, 0, _imageView.frame.size.height)];
    _lineView.backgroundColor = [UIColor colorWithRed:0.9 green:0.7 blue:0.1 alpha:1];
    [UIView animateWithDuration:3 animations:^{
        _lineView.frame = CGRectMake(_imageView.frame.origin.x, _imageView.frame.origin.y, (WIDTH - 40) * 578 / 904, _imageView.frame.size.height);
    }];
    _imageView.hidden = NO;
    [self addSubview:_lineView];
}

- (void)setPlTargetModel:(PLTargetModel *)plTargetModel {
    _targetLabel.text = plTargetModel.target;
    _basicGoalLabel.text = plTargetModel.basicGoal;
    _lastWeekCalorieLabel.text = plTargetModel.lastWeekCalorie;
}

@end
