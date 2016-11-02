//
//  PLXCalorieViewController.m
//  Move
//
//  Created by dllo on 2016/11/2.
//  Copyright © 2016年 PhelanGeek. All rights reserved.
//

#import "PLXCalorieViewController.h"
#import "PLXTouchView.h"

@interface PLXCalorieViewController ()
<
PNChartDelegate
>

@property (nonatomic, strong) UILabel *avgLabel;
@property (nonatomic, strong) UILabel *sumLabel;
@property (nonatomic, strong) PNBarChart *barChart;
@property (nonatomic, strong) PLXTouchView *touchView;
@property (nonatomic, assign) NSInteger lastTouch;

@end

@implementation PLXCalorieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _lastTouch = -1;
    [self createLabel];
    [self createTouchView];
    [self createBarChart];
    
    
}

- (void)createLabel {
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH / 5, HEIGHT / 20, WIDTH / 5, HEIGHT / 30)];
    label1.text = @"平均大卡";
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = [UIColor whiteColor];
    label1.font = [UIFont systemFontOfSize:WIDTH / 21];
    [self.view addSubview:label1];
    
    self.avgLabel = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH / 5, label1.frame.size.height + label1.frame.origin.y + 10, WIDTH / 5,  HEIGHT / 29)];
    _avgLabel.text = @"100";
    _avgLabel.textAlignment = NSTextAlignmentCenter;
    _avgLabel.textColor = [UIColor colorWithRed:0.9 green:0.7 blue:0.1 alpha:1];
    _avgLabel.font = [UIFont systemFontOfSize:WIDTH / 12];
    [self.view addSubview:_avgLabel];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH / 5 * 3, HEIGHT / 20, WIDTH / 5, HEIGHT / 29)];
    label2.text = @"总大卡";
    label2.textAlignment = NSTextAlignmentCenter;
    label2.textColor = [UIColor whiteColor];
    label2.font = [UIFont systemFontOfSize:WIDTH / 21];
    [self.view addSubview:label2];
    
    self.sumLabel = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH / 5 * 3, label2.frame.size.height + label2.frame.origin.y + 10, WIDTH / 5,  HEIGHT / 30)];
    _sumLabel.text = @"697";
    _sumLabel.textAlignment = NSTextAlignmentCenter;
    _sumLabel.textColor = [UIColor colorWithRed:0.9 green:0.7 blue:0.1 alpha:1];
    _sumLabel.font = [UIFont systemFontOfSize:WIDTH / 12];
    [self.view addSubview:_sumLabel];
}


- (void)createBarChart {
    
    self.barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(0, _sumLabel.frame.origin.y + _sumLabel.frame.size.height + 50, WIDTH, HEIGHT - _sumLabel.frame.origin.y - _sumLabel.frame.size.height - 60 - 64 - 49)];
    _barChart.yChartLabelWidth = 20.0;
    _barChart.chartMarginLeft = 30.0;
    _barChart.chartMarginRight = 10.0;
    _barChart.chartMarginTop = 5.0;
    _barChart.chartMarginBottom = 10.0;
    _barChart.labelMarginTop = 2.0;
    
    _barChart.showChartBorder = NO;
    _barChart.isShowNumbers = NO;
    _barChart.isGradientShow = NO;
    _barChart.barBackgroundColor = [UIColor clearColor];
    _barChart.backgroundColor = [UIColor clearColor];
    [_barChart setStrokeColor:[UIColor colorWithRed:0.9 green:0.7 blue:0.1 alpha:1]];
    
    [_barChart setXLabels:@[@"周一", @"周二", @"周三", @"周四", @"周五", @"周六", @"周日"]];
    [_barChart setYValues:@[@100, @20, @200, @124, @111, @56, @88]];
    [_barChart strokeChart];
    _barChart.delegate = self;
    
    
    
    //    for (int i = 0; i < 7; i++) {
    //        PNBar *bar =  _barChart.bars[i];
    //        CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
    //        gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:0.9 green:0.7 blue:0.1 alpha:1].CGColor, (__bridge id)[UIColor colorWithRed:1 green:0 blue:0 alpha:1].CGColor];
    //        gradientLayer.startPoint = CGPointMake(0, 1);
    //        gradientLayer.endPoint = CGPointMake(0, 0);
    //        gradientLayer.frame = bar.bounds;
    //        [bar.gradeLayer addSublayer:gradientLayer];
    //    }
    
    
    
    
    [self.view addSubview:_barChart];
    
}

- (void)userClickedOnBarAtIndex:(NSInteger)barIndex {
    PNBar *bar = _barChart.bars[barIndex];
    if (_lastTouch == barIndex) {
        _touchView.hidden = !_touchView.hidden;
    }
    else {
        CGFloat height =  bar.frame.size.height * bar.grade;
        CGFloat spaceHeight = _barChart.frame.size.height - 15 - height;
        CGRect frame = CGRectMake(bar.frame.origin.x, _barChart.frame.origin.y + spaceHeight - 46, bar.frame.size.width, 46);
        _touchView.frame = frame;
        _touchView.text = [NSString stringWithFormat:@"%ld", (NSInteger)(bar.grade * bar.maxDivisor)];
        _touchView.hidden = NO;
    }
    _lastTouch = barIndex;
}

- (void)createTouchView {
    self.touchView = [[PLXTouchView alloc] initWithFrame:CGRectZero];
    _touchView.hidden = YES;
    [self.view addSubview:_touchView];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
