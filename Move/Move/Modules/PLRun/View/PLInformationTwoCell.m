//
//  PLInformationTwoCell.m
//  Move
//
//  Created by PhelanGeek on 2016/11/9.
//  Copyright © 2016年 PhelanGeek. All rights reserved.
//

#import "PLInformationTwoCell.h"
#import "PLInfoModel.h"

@interface PLInformationTwoCell ()
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *sportTime;
@property (weak, nonatomic) IBOutlet UILabel *stepCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *kmLabel;
@property (weak, nonatomic) IBOutlet UILabel *calorieLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation PLInformationTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setInfoModel:(PLInfoModel *)infoModel {
    _typeLabel.text = infoModel.title;
    _sportTime.text = infoModel.time;
    _stepCountLabel.text = infoModel.stepCount;
    _kmLabel.text = infoModel.km;
    _calorieLabel.text = infoModel.calorie;
    _dateLabel.text = infoModel.date;
}

@end
