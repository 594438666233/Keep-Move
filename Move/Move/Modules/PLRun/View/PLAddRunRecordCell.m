//
//  PLAddRunRecordCell.m
//  Move
//
//  Created by 舒鑫 on 2016/11/8.
//  Copyright © 2016年 舒鑫. All rights reserved.
//

#import "PLAddRunRecordCell.h"

@interface PLAddRunRecordCell ()
@property (weak, nonatomic) IBOutlet UIButton *iconButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation PLAddRunRecordCell

- (void)setIconImage:(UIImage *)iconImage {
//    _iconButton.backgroundColor = PLYELLOW;
//    _iconButton.layer.cornerRadius = 15;
//    _iconButton.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [_iconButton setBackgroundImage:iconImage forState:UIControlStateNormal];
}

- (void)setTitleString:(NSString *)titleString {
    _titleLabel.text = titleString;
}
@end
