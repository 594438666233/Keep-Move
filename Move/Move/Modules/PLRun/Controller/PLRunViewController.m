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


@end

@implementation PLRunViewController

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
    self.runImageView.image = runImage;
    _runImageView.userInteractionEnabled = YES;
    
    [self.view addSubview:_runImageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [tap addTarget:self action:@selector(tapAction:)];
    [_runImageView addGestureRecognizer:tap];
    
}

- (void)tapAction:(UITapGestureRecognizer *)tap {
    PLRunNowViewController *runNowVC = [[PLRunNowViewController alloc] init];
    [self presentViewController:runNowVC animated:YES completion:nil];
}


#pragma mark - mlWorkSpace

@end
