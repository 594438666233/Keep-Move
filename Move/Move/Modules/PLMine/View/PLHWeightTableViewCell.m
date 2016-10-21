//
//  PLHWeightTableViewCell.m
//  Move
//
//  Created by 胡梦龙 on 16/10/21.
//  Copyright © 2016年 PhelanGeek. All rights reserved.
//

#import "PLHWeightTableViewCell.h"


@interface PLHWeightTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *currentWeight;

@property (weak, nonatomic) IBOutlet UILabel *BMILabel;

@property (weak, nonatomic) IBOutlet UILabel *goalWeightLabel;
@end

@implementation PLHWeightTableViewCell


- (IBAction)currentWeightAction:(id)sender {
}

- (IBAction)goalWeightAction:(id)sender {
}





- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
