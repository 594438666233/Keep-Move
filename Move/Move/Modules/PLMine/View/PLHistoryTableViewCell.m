//
//  PLHistoryTableViewCell.m
//  Move
//
//  Created by 舒鑫 on 16/10/31.
//  Copyright © 2016年 舒鑫. All rights reserved.
//

#import "PLHistoryTableViewCell.h"
#import "PLHistoryInformation.h"

@interface PLHistoryTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *weightLabel;


@end

@implementation PLHistoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    
}

- (void)setHistory:(PLHistoryInformation *)history {
    _history = history;
    self.timeLabel.text = history.time;
    self.weightLabel.text = [NSString stringWithFormat:@"%.1fkg", history.weight];

}


@end
