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

<
PLBounceWeightViewDelegate,
UITextFieldDelegate
>

@property (nonatomic, strong) UIView *glassView;

@end

@implementation PLInitialWeightTableViewCell


- (IBAction)writeWeight:(id)sender {
    
    
    [self pl_createGlass];
    
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


@end
