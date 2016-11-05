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
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"截图已保存到本地相册" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        UIWindow *screenWindow = [[UIApplication sharedApplication] keyWindow];
        UIGraphicsBeginImageContextWithOptions(screenWindow.frame.size, NO, [UIScreen mainScreen].scale);
        [screenWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        UIImageWriteToSavedPhotosAlbum(image, nil, nil,nil);
        
    }];
    [alert addAction:sureAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)rigthBarButtonAction:(UIBarButtonItem *)rightBarButton {
    NSLog(@"fd");
}

@end
