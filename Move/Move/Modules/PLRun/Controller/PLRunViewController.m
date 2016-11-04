//
//  PLRunViewController.m
//  Move
//
//  Created by PhelanGeek on 2016/10/19.
//  Copyright © 2016年 PhelanGeek. All rights reserved.
//

#import "PLRunViewController.h"
#import "PLHealthManager.h"
#import "PLRunNowViewController.h"
#import "UIImage+GIF.h"

@interface PLRunViewController ()



@property (weak, nonatomic) IBOutlet UIImageView *runImageView;
@property (weak, nonatomic) IBOutlet UIButton *runButton;


@end

@implementation PLRunViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"%@",  [NSDate dateWithTimeIntervalSinceReferenceDate:0]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initHKHealth];
    [self createRunNowButton];
    
    
}

- (void)initHKHealth{
    
    PLHealthManager *manager = [[PLHealthManager alloc] init];
    [manager getIphoneHealthData];
    
}

- (void)createRunNowButton {
    
    UIImage *runImage = [UIImage sd_animatedGIFNamed:@"weRunConnecting"];
    _runButton.imageEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 8);
    _runButton.layer.cornerRadius = 20.f;
    _runButton.layer.borderColor = [UIColor grayColor].CGColor;
    _runButton.layer.borderWidth = 1;
    [_runButton setImage:runImage forState:UIControlStateNormal];

    [_runButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        PLRunNowViewController *runNowVC = [[PLRunNowViewController alloc] init];
        [self presentViewController:runNowVC animated:YES completion:nil];
    }];

}


#pragma mark - mlWorkSpace

@end
