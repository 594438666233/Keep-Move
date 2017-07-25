//
//  PLBounceWeightView.h
//  Move
//
//  Created by 舒鑫 on 16/10/20.
//  Copyright © 2016年 舒鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PLBounceWeightView;

@protocol PLBounceWeightViewDelegate <NSObject>

- (void)pl_bouceWeightView:(PLBounceWeightView *)bouceWeightView style:(NSInteger) style;

@end


@interface PLBounceWeightView : UIView

@property (nonatomic, assign) id<PLBounceWeightViewDelegate>delegate;

@property (weak, nonatomic) IBOutlet UITextField *weightLabel;


@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@end
