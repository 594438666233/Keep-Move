//
//  RootViewController.m
//  GP_ITHome
//
//  Created by PhelanGeek on 16/10/2.
//  Copyright © 2016年 PhelanGeek. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = PLBLACK;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = ColorWith51Black;
    self.navigationController.navigationBar.tintColor = PLYELLOW;
    
    // leftBarButton
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"camera"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonAction:)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    // rightBarButton
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"dd_creategroup@2x.png"] style:UIBarButtonItemStylePlain target:self action:@selector(rigthBarButtonAction:)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
}

#pragma mark - BarbuttonAction

- (void)leftBarButtonAction:(UIBarButtonItem *)leftBarButton {
    NSLog(@"left");
}

- (void)rigthBarButtonAction:(UIBarButtonItem *)rightBarButton {
    NSLog(@"fd");
}

@end
