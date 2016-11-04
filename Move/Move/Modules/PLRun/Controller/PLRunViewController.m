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
#import "MyCalendarItem.h"
@interface PLRunViewController ()

<
UIGestureRecognizerDelegate
>

@property (weak, nonatomic) IBOutlet UIImageView *runImageView;

@property (nonatomic, strong)MyCalendarItem *calendarView;

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UILabel *calendarLabel;
@end

@implementation PLRunViewController

-(MyCalendarItem *)calendarView{
    if (!_calendarView) {
        _calendarView = [[MyCalendarItem alloc] init];
        _calendarView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width * 6 / 7 +  94);
        
    }
    return _calendarView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initHKHealth];
    
    [self createRunNowButton];
    
    [self createCalendar];
    
    [self createNavigationTitleView];
    
    

}

- (void)createNavigationTitleView {
    UIView *navigationTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 108, 25)];
    navigationTitleView.backgroundColor = ColorWith51Black;
    self.navigationItem.titleView = navigationTitleView;
    
    UIImageView *calendarImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"c5"]];
    calendarImage.frame = CGRectMake(0, 3, 20, 20);
    [navigationTitleView addSubview:calendarImage];
    
    self.calendarLabel = [[UILabel alloc] initWithFrame:CGRectMake(28, 0, 80, 25)];
    _calendarLabel.text = @"11月04日";
    _calendarLabel.textColor = [UIColor whiteColor];
    [navigationTitleView addSubview:_calendarLabel];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(navigationTitleViewTap)];
    tap.cancelsTouchesInView = NO;
    tap.numberOfTouchesRequired = 1;
    tap.numberOfTapsRequired = 1;
    [navigationTitleView addGestureRecognizer:tap];

}


- (void)navigationTitleViewTap {
    
    [self ml_appear];
}



- (void)createCalendar {
    
 
    __weak typeof(self) weakSelf = self;
    
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height + [UIScreen mainScreen].bounds.size.width * 6 / 7 +  94)];
    self.calendarView.date = [NSDate date];
    [_backView addSubview:self.calendarView];
    _calendarView.calendarBlock = ^(NSInteger day, NSInteger month, NSInteger year) {
        
        NSLog(@"%ld-%02ld-%02ld", year, month, day);
        
        weakSelf.calendarLabel.text = [NSString stringWithFormat:@"%02ld月%02ld日", month, day];
        
        [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            weakSelf.backView.frame = CGRectMake(0, - ([UIScreen mainScreen].bounds.size.width * 6 / 7 +  94), [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height + [UIScreen mainScreen].bounds.size.width * 6 / 7 +  94);
            weakSelf.backView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        } completion:^(BOOL finished) {
            weakSelf.backView.hidden = YES;
            
        }];
        
        
        
        
    };
    
    
    
    _backView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:_backView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:nil];
    tap.delegate = self;
    [_backView addGestureRecognizer:tap];
    

}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {

        if ([touch.view isEqual:_backView]) {
            [self ml_dismiss];
        }
    return YES;


}

- (void)ml_appear {
    
    self.backView.hidden = NO;
    
    [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _backView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        _backView.frame = CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height + [UIScreen mainScreen].bounds.size.width * 6 / 7 +  94);
    } completion:^(BOOL finished) {
        //
    }];
    
    
}

- (void)ml_dismiss {
    [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _backView.frame = CGRectMake(0, - ([UIScreen mainScreen].bounds.size.width * 6 / 7 +  94), [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height + [UIScreen mainScreen].bounds.size.width * 6 / 7 +  94);
        _backView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    } completion:^(BOOL finished) {
        _backView.hidden = YES;
        
    }];

}

#pragma mark - guo work space

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




@end
