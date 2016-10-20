//
//  AppDelegate.m
//  Move
//
//  Created by PhelanGeek on 2016/10/19.
//  Copyright © 2016年 PhelanGeek. All rights reserved.
//

#import "AppDelegate.h"
#import "PLSignViewController.h"
#import "PLGoalViewController.h"
#import "PLRunViewController.h"
#import "PLAnalyseViewController.h"
#import "PLMineViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    // 成就
    PLGoalViewController *goalViewController = [[PLGoalViewController alloc] init];
    UIImage *goalImage = [UIImage imageNamed:@"achieveNormal"];
    goalImage = [goalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *goalSelectedImage = [UIImage imageNamed:@"achieveSelected"];
    goalSelectedImage = [goalSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    goalViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"成就" image:goalImage selectedImage:goalSelectedImage];
    
    // 分析
    PLAnalyseViewController *analyseViewController = [[PLAnalyseViewController alloc] init];
    UIImage *analyseImage = [UIImage imageNamed:@"analyseNormal"];
    analyseImage = [analyseImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *analyseSelectedImage = [UIImage imageNamed:@"analyseSelected"];
    analyseSelectedImage = [analyseSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    analyseViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"分析" image:analyseImage selectedImage:analyseSelectedImage];
    
    // 跑步
    PLRunViewController *runViewController = [[PLRunViewController alloc] init];
    UIImage *runImage = [UIImage imageNamed:@"runNormal"];
    runImage = [runImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *runSelectedImage = [UIImage imageNamed:@"runSelected"];
    runSelectedImage = [runSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    runViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:runImage selectedImage:runSelectedImage];

    
    // 目标
    PLSignViewController *signViewController = [[PLSignViewController alloc] init];
    UIImage *signImage = [UIImage imageNamed:@"goalNormal"];
    
    signImage = [signImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *signSelectedImage = [UIImage imageNamed:@"goalSelected"];
    signSelectedImage = [signSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    signViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"目标" image:signImage selectedImage:signSelectedImage];
    
    
    // 我
    PLMineViewController *myViewController = [[PLMineViewController alloc] init];
    UIImage *mineImage = [UIImage imageNamed:@"mineNormal"];
    mineImage = [mineImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *mineSelectedImage = [UIImage imageNamed:@"mineSelected"];
    mineSelectedImage = [mineSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    myViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我" image:mineImage selectedImage:mineSelectedImage];
    
    
    self.rootTabBarController = [[UITabBarController alloc] init];
    
    _rootTabBarController.viewControllers = @[
                                              goalViewController,
                                              analyseViewController,
                                              runViewController,
                                              signViewController,
                                              myViewController
                                              ];
    
    _rootTabBarController.tabBar.tintColor = PLYELLOW;
    _rootTabBarController.tabBar.barTintColor = [UIColor whiteColor];


    
//    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
//    //     判断是否第一次进入应用
//    if (![userDef boolForKey:@"notFirst"]) {
//        // 如果第一次，进入引导页
//        self.window.rootViewController = [[LeadingPageViewController alloc] init];
//    } else {
//        // 否则直接进入应用
//        self.window.rootViewController = _rootTabBarController;
//    }
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 49)];
    backView.backgroundColor = ColorWith51Black;
    [_rootTabBarController.tabBar insertSubview:backView atIndex:0];
    _rootTabBarController.tabBar.opaque = YES;
    _rootTabBarController.selectedIndex = 2;
    self.window.rootViewController = _rootTabBarController;
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
