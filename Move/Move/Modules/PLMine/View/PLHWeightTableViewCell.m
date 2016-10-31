//
//  PLHWeightTableViewCell.m
//  Move
//
//  Created by 胡梦龙 on 16/10/21.
//  Copyright © 2016年 PhelanGeek. All rights reserved.
//

#import "PLHWeightTableViewCell.h"
#import "PLBounceWeightView.h"
#import "PLMineViewController.h"

#import "PLHistoryInformation.h"
@interface PLHWeightTableViewCell ()

<
PLBounceWeightViewDelegate,
UITextFieldDelegate

>

@property (nonatomic, strong) UIView *glassView;

@property (weak, nonatomic) IBOutlet UILabel *currentWeight;


@property (weak, nonatomic) IBOutlet UILabel *BMI;

@property (weak, nonatomic) IBOutlet UILabel *goalWeight;

@end

@implementation PLHWeightTableViewCell


- (IBAction)writeGoalWeight:(id)sender {
    NSLog(@"writeGoal");
}



- (IBAction)writeWeight:(id)sender {
    
    
    [self pl_createGlass];
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.currentWeight.text = [NSString stringWithFormat:@"%.1f", [[PLDataBaseManager shareManager] currentWeight]];

}

#pragma mark - textField协议

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    return [self validateNumberByRegExp:string];
}




#pragma mark - 私有方法


- (BOOL)validateNumberByRegExp:(NSString *)string {
    BOOL isValid = YES;
    NSUInteger len = string.length;
    if (len > 0) {
        NSString *numberRegex = @"^[0-9]*$";
        NSPredicate *numberPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegex];
        isValid = [numberPredicate evaluateWithObject:string];
    }
    return isValid;
}



- (void)pl_bouceWeightView:(PLBounceWeightView *)bouceWeightView style:(NSInteger)style {
    if (style == 0) {
        [_glassView removeFromSuperview];
    } else {
        
        
        
        NSInteger num = [bouceWeightView.weightLabel.text integerValue];
        
        if (num < 500 && num > 0) {
            
            
            
            [_glassView removeFromSuperview];
            
            PLHistoryInformation *history = [[PLHistoryInformation alloc] init];
            history.weight = num;
            
            history.time = bouceWeightView.timeLabel.text;
            
            [[PLDataBaseManager shareManager] insertHistoryRecord:history];
            
            
            
            
            
            [((PLMineViewController *)[self ml_viewController]).tableView reloadData];
            
            
            
            
            
            
        } else {
            
            
            
            [UIView showMessage:@"请输入真实体重哦"];
            bouceWeightView.weightLabel.text = nil;
            
            
            
        }
        
        
    }
    
}

- (void)pl_createGlass {
    
    
    self.glassView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *visualView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    visualView.frame = [UIScreen mainScreen].bounds;
    [_glassView addSubview:visualView];
    [self.window addSubview:_glassView];
    
    UIView *view = [[UIView alloc] init];
    view.layer.cornerRadius = 10.f;
    view.frame = CGRectMake((WIDTH - (WIDTH - 40)) / 2, 100, WIDTH - 40, 240);
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.7;
    [_glassView addSubview:view];
    
    
    
    
    PLBounceWeightView *bounceWeight = [[NSBundle mainBundle] loadNibNamed:@"PLBounceWeightView" owner:nil options:nil].lastObject;
    bounceWeight.layer.cornerRadius = 10.f;
    bounceWeight.delegate = self;
    [bounceWeight.weightLabel becomeFirstResponder];
    bounceWeight.weightLabel.delegate = self;
    bounceWeight.frame = CGRectMake((WIDTH - (WIDTH - 40)) / 2, 100, WIDTH - 40, 240);
    [_glassView addSubview:bounceWeight];
    
    
}

- (UIViewController *)ml_viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
