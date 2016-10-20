//
//  PLBounceWeightView.m
//  Move
//
//  Created by 胡梦龙 on 16/10/20.
//  Copyright © 2016年 PhelanGeek. All rights reserved.
//

#import "PLBounceWeightView.h"

@interface PLBounceWeightView ()

@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UITextField *weightLabel;


@end




@implementation PLBounceWeightView


- (void)awakeFromNib {

    [super awakeFromNib];
    
    self.saveButton.layer.borderColor = [UIColor colorWithRed:245 / 255.f green:184 / 255.f blue:20 / 255.f alpha:1].CGColor;
    self.saveButton.layer.borderWidth = 1;

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
