//
//  PLRunViewController.m
//  Move
//
//  Created by PhelanGeek on 2016/10/19.
//  Copyright © 2016年 PhelanGeek. All rights reserved.
//

#import "PLRunViewController.h"
#import "PLHealthManager.h"

@interface PLRunViewController ()

@end

@implementation PLRunViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initHKHealth];
    
}

- (void)initHKHealth{
    
    PLHealthManager *manager = [[PLHealthManager alloc] init];
    [manager getIphoneHealthData];
    
}
@end
