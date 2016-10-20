//
//  PLGoalViewController.m
//  Move
//
//  Created by PhelanGeek on 2016/10/19.
//  Copyright © 2016年 PhelanGeek. All rights reserved.
//

#import "PLGoalViewController.h"
#import "PLGoalHeaderView.h"
#import "PLTargetView.h"
#import "PLDefeatView.h"
#import "PLCareerView.h"


@interface PLGoalViewController ()

@property (nonatomic, retain) PLGoalHeaderView *plGoalHeaderView;
@property (nonatomic, retain) PLTargetView *plTargetView;
@property (nonatomic, retain) PLDefeatView *plDefeatView;
@property (nonatomic, retain) PLCareerView *plCareerView;

@end

@implementation PLGoalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createHeaderView];
    [self createTargetView];
    [self createDefeatView];
    [self createCareerView];
    [self createButton];
    
}

- (void)createHeaderView {
    self.plGoalHeaderView = [[PLGoalHeaderView alloc] init];
    _plGoalHeaderView.frame = CGRectMake(0, 64, self.view.bounds.size.width, HEIGHT / 4);
    NSLog(@"width :%f", WIDTH);
    [self.view addSubview:_plGoalHeaderView];
}

- (void)createTargetView {
    self.plTargetView = [[PLTargetView alloc] init];
    _plTargetView.alpha = 0.0;
    _plTargetView.frame = CGRectMake(0, 64, self.view.bounds.size.width, HEIGHT / 4);
    [self.view addSubview:_plTargetView];
}

- (void)createDefeatView {
    self.plDefeatView = [[PLDefeatView alloc] init];
    _plDefeatView.alpha = 0.0;
    _plDefeatView.frame = CGRectMake(0, 64, self.view.bounds.size.width, HEIGHT / 4);
    [self.view addSubview:_plDefeatView];
    
}

- (void)createCareerView {
    self.plCareerView = [[PLCareerView alloc] init];
    _plCareerView.alpha = 0.0;
    _plCareerView.frame = CGRectMake(0, 64, self.view.bounds.size.width, HEIGHT / 4);
    [self.view addSubview:_plCareerView];
    
}

- (void)createButton {
    CGFloat margin = (WIDTH - 150) / 4;
    for (int i = 1; i <= 3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 1000 + i;
        [button handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            switch (button.tag) {
                case 1001:
                        {
                            [UIView animateWithDuration:0.5f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut  animations:^{
                                
                                _plGoalHeaderView.alpha = 0.0f;
                              

                                
                            } completion:^(BOOL finished) {
                                if (finished) {
                                    [UIView animateWithDuration:0.5f animations:^{
                                       
                                        _plTargetView.alpha = 1.0f;
                                     
                                    } completion:^(BOOL finished) {
                                        
                                     
                                        
                                    }];
                                    
                                }
                            }];
                        }
                    break;
                case 1002:
                {
                    [UIView animateWithDuration:0.5f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut  animations:^{
                        
                        _plTargetView.alpha = 0.0f;

                        
                    } completion:^(BOOL finished) {
                        if (finished) {
                            [UIView animateWithDuration:0.5f animations:^{
                                
                                _plCareerView.alpha = 1.0f;
                                
                            } completion:^(BOOL finished) {
                                
                                
                                
                            }];
                            
                        }
                    }];
                }
                    break;
                case 1003:
                {
                    [UIView animateWithDuration:0.5f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut  animations:^{
                        
                        _plGoalHeaderView.alpha = 0.0f;
                        
                        
                    } completion:^(BOOL finished) {
                        if (finished) {
                            [UIView animateWithDuration:0.5f animations:^{
                                
//                                _plDefeatView.alpha = 1.0f;
                                _plDefeatView.alpha = 1.0;
                                
                            } completion:^(BOOL finished) {
                                
                                
                                
                            }];
                            
                        }
                    }];
                }
                    break;
                default:
                    break;
            }
        }];
        [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"goal%d", i]] forState:UIControlStateNormal];
        button.frame = CGRectMake(margin * i + (i - 1) * 50, HEIGHT - 49 - 100, 50, 50);
        [self.view addSubview:button];
    }
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"weight_empty_pic.png"]];
    imageView.frame = CGRectMake(WIDTH / 2 -150, HEIGHT / 2 - 50, 310, 222);
    [self.view addSubview:imageView];

}


@end
