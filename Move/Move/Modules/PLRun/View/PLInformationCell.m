//
//  PLInformationCell.m
//  Move
//
//  Created by PhelanGeek on 2016/11/5.
//  Copyright © 2016年 PhelanGeek. All rights reserved.
//

#import "PLInformationCell.h"
#import "PLInfoModel.h"

@interface PLInformationCell ()

@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *calorieLabel;
@property (weak, nonatomic) IBOutlet UILabel *stepCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *rhythmLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation PLInformationCell

- (void)setInfoModel:(PLInfoModel *)infoModel {
    if (infoModel.km == nil) {
       _distanceLabel.text = [NSString stringWithFormat:@"步行/跑步 - 0 公里"];
    }else {
        
        _distanceLabel.text = [NSString stringWithFormat:@"步行/跑步 - %@ 公里",infoModel.km];
    }
    _timeLabel.text = [NSString stringWithFormat:@"%@", infoModel.time];
    
    if (infoModel.calorie == nil) {
        _calorieLabel.text = [NSString stringWithFormat:@"0 大卡"];

    }else {
        
        _calorieLabel.text = [NSString stringWithFormat:@"%@ 大卡", infoModel.calorie];
    }
    
    if (infoModel.stepCount == nil) {
        _stepCountLabel.text = [NSString stringWithFormat:@"0 步"];

    }else {
        
        _stepCountLabel.text = [NSString stringWithFormat:@"%@ 步", infoModel.stepCount];
    }
    
    if (infoModel.rate == nil) {
        _rhythmLabel.text = [NSString stringWithFormat:@"0 步/秒"];
    }else {
        
        _rhythmLabel.text = [NSString stringWithFormat:@"%@ 步/秒", infoModel.rate];
    }
    _dateLabel.text = infoModel.date;
}

@end
