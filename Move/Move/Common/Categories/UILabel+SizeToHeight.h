//
//  UILabel+SizeToHeight.h
//  AdaptHeight
//
//  Created by 舒鑫 on 16/9/26.
//  Copyright © 2016年 舒鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (SizeToHeight)

+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title Font:(UIFont *)font;

+ (CGFloat)getWidthWithTitle:(NSString *)title Font:(UIFont *)font;

@end
