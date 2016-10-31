//
//  PLSignViewController.m
//  Move
//
//  Created by PhelanGeek on 2016/10/19.
//  Copyright © 2016年 PhelanGeek. All rights reserved.
//

#import "PLSignViewController.h"
#import "PLRecommendGoalCell.h"
#import "PLAddGoalViewController.h"

static NSString *const cellReusableIdentifier = @"cell";

@interface PLSignViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PLSignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置footerView
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 150)];
    self.tableView.tableFooterView = footView;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"添加目标" forState:UIControlStateNormal];
    [button setTitleColor:PLYELLOW forState:UIControlStateNormal];
    button.layer.cornerRadius = 10.f;
    button.frame = CGRectMake((WIDTH - (WIDTH - 20)) / 2, 50, WIDTH - 20, 44);
    button.layer.borderColor = PLYELLOW.CGColor;
    button.layer.borderWidth = 1.f;
    button.backgroundColor = ColorWith51Black;
    [button handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        PLAddGoalViewController *plAddGoalVC = [[PLAddGoalViewController alloc] init];
        [self presentViewController:plAddGoalVC animated:YES completion:nil];
    }];
    [footView addSubview:button];
    // 设置tableView
    _tableView.backgroundColor = PLBLACK;
    _tableView.rowHeight = 80.f;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerNib:[UINib nibWithNibName:@"PLRecommendGoalCell" bundle:nil] forCellReuseIdentifier:cellReusableIdentifier];
    
}

#pragma mark - UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    }else {
        return 0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"推荐目标";
    }else {
        return @"我的目标";
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 21)];
    view.backgroundColor = PLBLACK;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 3, 100, 21)];
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:15];
    [view addSubview:label];
    if (section == 0) {
        label.text = @"推荐目标";
        return view;
    }else {
        label.text = @"我的目标";
        return view;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PLRecommendGoalCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReusableIdentifier];

    cell.backgroundColor = PLBLACK;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = [UIColor grayColor];
    if (indexPath.section == 0) {
        cell.buttonTitle = @"添加";
        switch (indexPath.row) {
            case 0:
            {
                cell.titleString = @"按时睡觉";
                cell.addButtonBlock = ^(UIButton *button) {
                    NSLog(@"hello world");
                };
                return cell;
            }
            break;
            case 1:
            {
                cell.titleString = @"坚持锻炼";
                cell.iconImage = [UIImage imageNamed:@"dumbbell"];
                cell.addButtonBlock = ^(UIButton *button) {
                    NSLog(@"hello");
                };
                return cell;
            }
            break;
            case 2:
            {
                cell.titleString = @"拒绝啤酒";
                cell.iconImage = [UIImage imageNamed:@"beer"];
                cell.addButtonBlock = ^(UIButton *button) {
                    NSLog(@"hello beer");
                };
                return cell;
            }
            break;
            case 3:
            {
                cell.titleString = @"坚持跑步";
                cell.iconImage = [UIImage imageNamed:@"shoe-1"];
                cell.addButtonBlock = ^(UIButton *button) {
                    NSLog(@"run");
                };
                return cell;
            }
            break;
                
            default:
                break;
        }
    }
//    cell.titleString = @"坚持跑步";
//    cell.iconImage = [UIImage imageNamed:@"shoe-1"];
//    cell.buttonTitle = @"移除";
//    cell.addButtonBlock = ^(UIButton *button) {
//        NSLog(@"run");
//    };
//    return cell;
    return 0;

}

@end
