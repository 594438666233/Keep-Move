//
//  PLDetailGoalViewController.m
//  Move
//
//  Created by PhelanGeek on 2016/10/31.
//  Copyright © 2016年 PhelanGeek. All rights reserved.
//

#import "PLDetailGoalViewController.h"
#import "PLRecommendGoalCell.h"
#import "PLNavigationView.h"

static NSString *const cellDetailIdentifier = @"cell";

@interface PLDetailGoalViewController ()
<
    UITableViewDelegate,
    UITableViewDelegate
>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PLDetailGoalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏view
    PLNavigationView *plNavigationView = [[PLNavigationView alloc] init];
    switch (_type) {
        case 0:
        {
             plNavigationView.titleString = @"作息时间";
        }
            break;
        case 1:
        {
            plNavigationView.titleString = @"运动";
        }
            break;
        case 2:
        {
            plNavigationView.titleString = @"健康饮食";
        }
            break;
        case 3:
        {
            plNavigationView.titleString = @"跑步";
        }
            break;
        case 4:
        {
            plNavigationView.titleString = @"骑车";
        }
            break;
        default:
            break;
    }
   
    plNavigationView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 64);
    plNavigationView.cancelButtonBlock = ^(UIButton *button){
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    [self.view addSubview:plNavigationView];
    // 设置tableView
    _tableView.backgroundColor = PLBLACK;
    _tableView.rowHeight = 80.f;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerNib:[UINib nibWithNibName:@"PLRecommendGoalCell" bundle:nil] forCellReuseIdentifier:cellDetailIdentifier];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (_type) {
        case 0:
        {
            return 4;
        }
            break;
        case 1:
        {
            return 5;
        }
            break;
        case 2:
        {
            return 6;
        }
            break;
        case 3:
        {
            return 4;
        }
            break;
        case 4:
        {
            return 4;
        }
            break;
        default:
            break;
    }
    return 0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak PLRecommendGoalCell *cell = [tableView dequeueReusableCellWithIdentifier:cellDetailIdentifier];
    
    cell.backgroundColor = PLBLACK;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = [UIColor grayColor];
    cell.addButton.hidden = NO;
    cell.buttonTitle = @"添加";
    switch (_type) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {   __block BOOL index = YES;
                    cell.titleString = @"8小时充足睡眠";
                    cell.addButtonBlock = ^(UIButton *button) {
                        NSLog(@"hello world");
                        if (index == YES) {
                            [cell.addButton setTitle:@"移除" forState:UIControlStateNormal];
                            index = NO;
                        }else {
                            [cell.addButton setTitle:@"添加" forState:UIControlStateNormal];
                            index = YES;
                        }
                    };
                    return cell;
                }
                    break;
                case 1:
                {   __block BOOL index = YES;
                    cell.titleString = @"坚持午睡";
                    cell.addButtonBlock = ^(UIButton *button) {
                        NSLog(@"hello world");
                        if (index == YES) {
                            [cell.addButton setTitle:@"移除" forState:UIControlStateNormal];
                            index = NO;
                        }else {
                            [cell.addButton setTitle:@"添加" forState:UIControlStateNormal];
                            index = YES;
                        }
                    };
                    return cell;
                }
                    break;
                case 2:
                {   __block BOOL index = YES;
                    cell.titleString = @"8小时充足睡眠";
                    cell.addButtonBlock = ^(UIButton *button) {
                        NSLog(@"hello world");
                        if (index == YES) {
                            [cell.addButton setTitle:@"移除" forState:UIControlStateNormal];
                            index = NO;
                        }else {
                            [cell.addButton setTitle:@"添加" forState:UIControlStateNormal];
                            index = YES;
                        }
                    };
                    return cell;
                }
                    break;
                case 3:
                {   __block BOOL index = YES;
                    cell.titleString = @"晚上12点前睡觉";
                    cell.addButtonBlock = ^(UIButton *button) {
                        NSLog(@"hello world");
                        if (index == YES) {
                            [cell.addButton setTitle:@"移除" forState:UIControlStateNormal];
                            index = NO;
                        }else {
                            [cell.addButton setTitle:@"添加" forState:UIControlStateNormal];
                            index = YES;
                        }
                    };
                    return cell;
                }
                    break;
                    
                default:
                    break;
            }

        }
            break;
        case 1:
        {
                        switch (indexPath.row) {
                case 0:
                {   __block BOOL index = YES;
                    cell.iconImage = [UIImage imageNamed:@"dumbbell"];
                    cell.titleString = @"健身房报道";
                    cell.addButtonBlock = ^(UIButton *button) {
                        NSLog(@"hello world");
                        if (index == YES) {
                            [cell.addButton setTitle:@"移除" forState:UIControlStateNormal];
                            index = NO;
                        }else {
                            [cell.addButton setTitle:@"添加" forState:UIControlStateNormal];
                            index = YES;
                        }
                    };
                    return cell;
                }
                    break;
                case 1:
                {   __block BOOL index = YES;
                    cell.iconImage = [UIImage imageNamed:@"skipping-rope"];
                    cell.titleString = @"坚持跳绳";
                    cell.addButtonBlock = ^(UIButton *button) {
                        NSLog(@"hello world");
                        if (index == YES) {
                            [cell.addButton setTitle:@"移除" forState:UIControlStateNormal];
                            index = NO;
                        }else {
                            [cell.addButton setTitle:@"添加" forState:UIControlStateNormal];
                            index = YES;
                        }
                    };
                    return cell;
                }
                    break;
                case 2:
                {   __block BOOL index = YES;
                    cell.iconImage = [UIImage imageNamed:@"ping-pong-racket"];
                    cell.titleString = @"坚持打乒乓球";
                    cell.addButtonBlock = ^(UIButton *button) {
                        NSLog(@"hello world");
                        if (index == YES) {
                            [cell.addButton setTitle:@"移除" forState:UIControlStateNormal];
                            index = NO;
                        }else {
                            [cell.addButton setTitle:@"添加" forState:UIControlStateNormal];
                            index = YES;
                        }
                    };
                    return cell;
                }
                    break;
                case 3:
                {   __block BOOL index = YES;
                    cell.iconImage = [UIImage imageNamed:@"tennis"];
                    cell.titleString = @"坚持打网球";
                    cell.addButtonBlock = ^(UIButton *button) {
                        NSLog(@"hello world");
                        if (index == YES) {
                            [cell.addButton setTitle:@"移除" forState:UIControlStateNormal];
                            index = NO;
                        }else {
                            [cell.addButton setTitle:@"添加" forState:UIControlStateNormal];
                            index = YES;
                        }
                    };
                    return cell;
                }
                    break;
                case 4:
                {   __block BOOL index = YES;
                    cell.iconImage = [UIImage imageNamed:@"skates"];
                    cell.titleString = @"坚持滑冰";
                    cell.addButtonBlock = ^(UIButton *button) {
                        NSLog(@"hello world");
                        if (index == YES) {
                            [cell.addButton setTitle:@"移除" forState:UIControlStateNormal];
                            index = NO;
                        }else {
                            [cell.addButton setTitle:@"添加" forState:UIControlStateNormal];
                            index = YES;
                        }
                    };
                    return cell;
                }
                    
                default:
                    break;
            }

        }
            break;
        case 2:
        {
            switch (indexPath.row) {
                case 0:
                {   __block BOOL index = YES;
                    cell.iconImage = [UIImage imageNamed:@"cheese"];
                    cell.titleString = @"拒绝甜食";
                    cell.addButtonBlock = ^(UIButton *button) {
                        NSLog(@"hello world");
                        if (index == YES) {
                            [cell.addButton setTitle:@"移除" forState:UIControlStateNormal];
                            index = NO;
                        }else {
                            [cell.addButton setTitle:@"添加" forState:UIControlStateNormal];
                            index = YES;
                        }
                    };
                    return cell;
                }
                    break;
                case 1:
                {   __block BOOL index = YES;
                    cell.iconImage = [UIImage imageNamed:@"soda-in-the-bank.png"];
                    cell.titleString = @"拒绝碳酸饮料";
                    cell.addButtonBlock = ^(UIButton *button) {
                        NSLog(@"hello world");
                        if (index == YES) {
                            [cell.addButton setTitle:@"移除" forState:UIControlStateNormal];
                            index = NO;
                        }else {
                            [cell.addButton setTitle:@"添加" forState:UIControlStateNormal];
                            index = YES;
                        }
                    };
                    return cell;
                }
                    break;
                case 2:
                {   __block BOOL index = YES;
                    cell.titleString = @"多吃蔬菜";
                    cell.iconImage = [UIImage imageNamed:@"carrot"];
                    cell.addButtonBlock = ^(UIButton *button) {
                        NSLog(@"hello world");
                        if (index == YES) {
                            [cell.addButton setTitle:@"移除" forState:UIControlStateNormal];
                            index = NO;
                        }else {
                            [cell.addButton setTitle:@"添加" forState:UIControlStateNormal];
                            index = YES;
                        }
                    };
                    return cell;
                }
                    break;
                case 3:
                {   __block BOOL index = YES;
                    cell.titleString = @"多吃水果";
                    cell.iconImage = [UIImage imageNamed:@"美食"];
                    cell.addButtonBlock = ^(UIButton *button) {
                        NSLog(@"hello world");
                        if (index == YES) {
                            [cell.addButton setTitle:@"移除" forState:UIControlStateNormal];
                            index = NO;
                        }else {
                            [cell.addButton setTitle:@"添加" forState:UIControlStateNormal];
                            index = YES;
                        }
                    };
                    return cell;
                }
                    break;
                case 4:
                {   __block BOOL index = YES;
                    cell.titleString = @"每天一杯茶";
                    cell.iconImage = [UIImage imageNamed:@"tea"];
                    cell.addButtonBlock = ^(UIButton *button) {
                        NSLog(@"hello world");
                        if (index == YES) {
                            [cell.addButton setTitle:@"移除" forState:UIControlStateNormal];
                            index = NO;
                        }else {
                            [cell.addButton setTitle:@"添加" forState:UIControlStateNormal];
                            index = YES;
                        }
                    };
                    return cell;
                }
                    break;
                case 5:
                {   __block BOOL index = YES;
                    cell.titleString = @"每天一杯牛奶";
                    cell.iconImage = [UIImage imageNamed:@"milk"];
                    cell.addButtonBlock = ^(UIButton *button) {
                        NSLog(@"hello world");
                        if (index == YES) {
                            [cell.addButton setTitle:@"移除" forState:UIControlStateNormal];
                            index = NO;
                        }else {
                            [cell.addButton setTitle:@"添加" forState:UIControlStateNormal];
                            index = YES;
                        }
                    };
                    return cell;
                }
                    break;
                    
                default:
                    break;
            }

        }
            break;
        case 3:
        {
            cell.iconImage = [UIImage imageNamed:@"shoe-1"];
            switch (indexPath.row) {
                case 0:
                {   __block BOOL index = YES;
                    cell.titleString = @"每日3千步";
                    cell.addButtonBlock = ^(UIButton *button) {
                        NSLog(@"hello world");
                        if (index == YES) {
                            [cell.addButton setTitle:@"移除" forState:UIControlStateNormal];
                            index = NO;
                        }else {
                            [cell.addButton setTitle:@"添加" forState:UIControlStateNormal];
                            index = YES;
                        }
                    };
                    return cell;
                }
                    break;
                case 1:
                {   __block BOOL index = YES;
                    cell.titleString = @"每日6千步";
                    cell.addButtonBlock = ^(UIButton *button) {
                        NSLog(@"hello world");
                        if (index == YES) {
                            [cell.addButton setTitle:@"移除" forState:UIControlStateNormal];
                            index = NO;
                        }else {
                            [cell.addButton setTitle:@"添加" forState:UIControlStateNormal];
                            index = YES;
                        }
                    };
                    return cell;
                }
                    break;
                case 2:
                {   __block BOOL index = YES;
                    cell.titleString = @"每日1万步";
                    cell.addButtonBlock = ^(UIButton *button) {
                        NSLog(@"hello world");
                        if (index == YES) {
                            [cell.addButton setTitle:@"移除" forState:UIControlStateNormal];
                            index = NO;
                        }else {
                            [cell.addButton setTitle:@"添加" forState:UIControlStateNormal];
                            index = YES;
                        }
                    };
                    return cell;
                }
                    break;
                case 3:
                {   __block BOOL index = YES;
                    cell.titleString = @"每日2万步";
                    cell.addButtonBlock = ^(UIButton *button) {
                        NSLog(@"hello world");
                        if (index == YES) {
                            [cell.addButton setTitle:@"移除" forState:UIControlStateNormal];
                            index = NO;
                        }else {
                            [cell.addButton setTitle:@"添加" forState:UIControlStateNormal];
                            index = YES;
                        }
                    };
                    return cell;
                }
                    break;
                    
                default:
                    break;
            }

        }
            break;
        case 4:
        {
            cell.iconImage = [UIImage imageNamed:@"bicycle"];
            switch (indexPath.row) {
                case 0:
                {   __block BOOL index = YES;
                    cell.titleString = @"骑行5公里";
                    cell.addButtonBlock = ^(UIButton *button) {
                        NSLog(@"hello world");
                        if (index == YES) {
                            [cell.addButton setTitle:@"移除" forState:UIControlStateNormal];
                            index = NO;
                        }else {
                            [cell.addButton setTitle:@"添加" forState:UIControlStateNormal];
                            index = YES;
                        }
                    };
                    return cell;
                }
                    break;
                case 1:
                {   __block BOOL index = YES;
                    cell.titleString = @"骑行10公里";
                    cell.addButtonBlock = ^(UIButton *button) {
                        NSLog(@"hello world");
                        if (index == YES) {
                            [cell.addButton setTitle:@"移除" forState:UIControlStateNormal];
                            index = NO;
                        }else {
                            [cell.addButton setTitle:@"添加" forState:UIControlStateNormal];
                            index = YES;
                        }
                    };
                    return cell;
                }
                    break;
                case 2:
                {   __block BOOL index = YES;
                    cell.titleString = @"骑行30公里";
                    cell.addButtonBlock = ^(UIButton *button) {
                        NSLog(@"hello world");
                        if (index == YES) {
                            [cell.addButton setTitle:@"移除" forState:UIControlStateNormal];
                            index = NO;
                        }else {
                            [cell.addButton setTitle:@"添加" forState:UIControlStateNormal];
                            index = YES;
                        }
                    };
                    return cell;
                }
                    break;
                case 3:
                {   __block BOOL index = YES;
                    cell.titleString = @"骑行100公里";
                    cell.addButtonBlock = ^(UIButton *button) {
                        NSLog(@"hello world");
                        if (index == YES) {
                            [cell.addButton setTitle:@"移除" forState:UIControlStateNormal];
                            index = NO;
                        }else {
                            [cell.addButton setTitle:@"添加" forState:UIControlStateNormal];
                            index = YES;
                        }
                    };
                    return cell;
                }
                    break;
                    
                default:
                    break;
            }

        }
            break;
        default:
            break;
    }
            return 0;
    
}

@end
