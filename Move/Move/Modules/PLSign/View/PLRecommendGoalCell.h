//
//  PLRecommendGoalCell.h
//  Move
//
//  Created by 舒鑫 on 2016/10/31.
//  Copyright © 2016年 舒鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^AddButtonBlock)(UIButton *);

@interface PLRecommendGoalCell : UITableViewCell

@property (nonatomic, retain) UIImage *iconImage;
@property (nonatomic, copy) NSString *titleString;
@property (nonatomic, copy) NSString *buttonTitle;
@property (nonatomic, copy) AddButtonBlock addButtonBlock;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@end
