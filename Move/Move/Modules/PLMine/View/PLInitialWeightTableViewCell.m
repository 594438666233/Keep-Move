//
//  PLInitialWeightTableViewCell.m
//  Move
//
//  Created by 胡梦龙 on 16/10/19.
//  Copyright © 2016年 PhelanGeek. All rights reserved.
//

#import "PLInitialWeightTableViewCell.h"

#import "PLBounceWeightView.h"

@interface PLInitialWeightTableViewCell ()

@property (nonatomic, strong) UIView *glassView;

@end

@implementation PLInitialWeightTableViewCell


- (IBAction)writeWeight:(id)sender {
    
    self.glassView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *visualView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    visualView.frame = [UIScreen mainScreen].bounds;
    [_glassView addSubview:visualView];
    [self.window addSubview:_glassView];
    
    
    PLBounceWeightView *bounceWeight = [[NSBundle mainBundle] loadNibNamed:@"PLBounceWeightView" owner:nil options:nil].lastObject;
    bounceWeight.layer.cornerRadius = 10.f;
    bounceWeight.frame = CGRectMake((WIDTH - (WIDTH - 40)) / 2, 100, WIDTH - 40, 300);
    
    [_glassView addSubview:bounceWeight];
    
    
    
    
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
