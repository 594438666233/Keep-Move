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
#import "PLSignCellObject.h"
static NSString *const cellReusableIdentifier = @"cell";

@interface PLSignViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSString *goalPath;
@property (nonatomic, retain) NSMutableArray *dataArray;
@property (nonatomic, retain) NSMutableArray *recommendGoalArray;
@property (nonatomic, assign) BOOL flag;
@property (nonatomic, assign) BOOL tempFlag;


@end

@implementation PLSignViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupPath];
    self.dataArray = [NSMutableArray array];
    NSArray *pArray = [NSKeyedUnarchiver unarchiveObjectWithFile:_goalPath];
    self.dataArray = [NSMutableArray arrayWithArray:pArray];
    if (_dataArray.count == 0) {
        _flag = NO;
        NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
        // 保存用户数据
        [userDef setBool:_flag forKey:@"notFirst"];
        [userDef synchronize];
    }
    
    [_tableView reloadData];
    NSLog(@"%@", self.dataArray);
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tempFlag = YES;
    [self setupTableView];
    
}

- (void)setupTableView {
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

- (void)setupPath {
    // 拼接路径
    NSArray *libraryArray = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *libraryPath = [libraryArray firstObject];
    
    // 列表
    NSString *path = [libraryPath stringByAppendingString:@"/Preferences"];
    path = [path stringByAppendingString:@"/Goal.plist"];
    self.goalPath = path;
    NSLog(@"%@", _goalPath);
}



- (NSMutableArray *)recommendGoalArray {
    if (_recommendGoalArray == nil) {
        self.recommendGoalArray = [NSMutableArray array];
        PLSignCellObject *sign0 = [PLSignCellObject plSignCellObjectWithTitle:@"8小时充足睡眠" andImageView:[UIImage imageNamed:@"stopwatch"]];
        PLSignCellObject *sign1 = [PLSignCellObject plSignCellObjectWithTitle:@"健身房报道" andImageView:[UIImage imageNamed:@"dumbbell"]];
        PLSignCellObject *sign2 = [PLSignCellObject plSignCellObjectWithTitle:@"拒绝啤酒" andImageView:[UIImage imageNamed:@"beer"]];
        PLSignCellObject *sign3 = [PLSignCellObject plSignCellObjectWithTitle:@"每日1万步" andImageView:[UIImage imageNamed:@"shoe-1"]];
        [_recommendGoalArray addObjectsFromArray:@[sign0, sign1, sign2, sign3]];
        
    }

    return _recommendGoalArray;
}

#pragma mark - UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (_tempFlag == YES) {
        
        NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
        // 判断是否第一次进入应用
        if (![userDef boolForKey:@"notFirst"]) {
            // 如果第一次，进入引导页
            if (section == 0) {
                return self.recommendGoalArray.count;
            }else {
                return _dataArray.count;
            }
            
        }
        return _dataArray.count;
    }else{
        if (self.recommendGoalArray.count != 0) {
            if (section == 0) {
                return self.recommendGoalArray.count;
            }else {
                return _dataArray.count;
            }
        }
    }
    return _dataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (_tempFlag == YES) {
        NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
        // 判断是否第一次进入应用
        if (![userDef boolForKey:@"notFirst"]) {
        // 如果第一次，进入引导页
        
            return 2;
        
        
        }
        return 1;
    }else{
        if (self.recommendGoalArray.count != 0) {
            return 2;
        }else{
            return 1;
        }
    }
    
    return 0;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    
    if (_tempFlag == YES) {
        
        NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
        // 判断是否第一次进入应用
        if (![userDef boolForKey:@"notFirst"]) {
            // 如果第一次，进入引导页
            
            if (section == 0) {
                return @"推荐目标";
            }else {
                return @"我的目标";
            }
            
            
        }
        return @"我的目标";
    }else{
        if (_recommendGoalArray.count != 0) {
            if (section == 0) {
                return @"推荐目标";
            }else {
                return @"我的目标";
            }
        }else {
            return @"我的目标";
        }
    }
    

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 21)];
    view.backgroundColor = PLBLACK;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 3, 100, 21)];
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:15];
    [view addSubview:label];
    
    if (_tempFlag == YES) {
        
        NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
        // 判断是否第一次进入应用
        if (![userDef boolForKey:@"notFirst"]) {
            // 如果第一次，进入引导页
            
            if (section == 0) {
                label.text = @"推荐目标";
                return view;
            }else {
                label.text = @"我的目标";
                return view;
            }
            
            
        }
        label.text = @"我的目标";
        return view;
    }else {
        if (self.recommendGoalArray.count != 0) {
            if (section == 0) {
                label.text = @"推荐目标";
                return view;
            }else {
                label.text = @"我的目标";
                return view;
            }
        }
    }
    label.text = @"我的目标";
    return view;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    __weak PLRecommendGoalCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell = [[NSBundle mainBundle] loadNibNamed:@"PLRecommendGoalCell" owner:nil options:nil].lastObject;

    cell.backgroundColor = PLBLACK;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = [UIColor grayColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (_tempFlag == YES) {
        NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
        // 判断是否第一次进入应用
        if (![userDef boolForKey:@"notFirst"]) {
            // 如果第一次，进入引导页
            if (self.recommendGoalArray.count != 0) {
                
                if (indexPath.section == 0) {
                    cell.buttonTitle = @"添加";
                    PLSignCellObject *sign = _recommendGoalArray[indexPath.row];
                    cell.titleString = sign.titleString;
                    cell.iconImage = sign.imageView;
                    switch (indexPath.row) {
                        case 0:
                        {
                            cell.addButtonBlock = ^(UIButton *button) {
                                
                                [self.dataArray addObject:sign];
                                [NSKeyedArchiver archiveRootObject:_dataArray toFile:_goalPath];
                                [cell removeFromSuperview];
                                _tempFlag = NO;
                                [_recommendGoalArray removeObject:sign];
                                [_tableView reloadData];
                                
                                _flag = YES;
                                
                                NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
                                // 保存用户数据
                                [userDef setBool:_flag forKey:@"notFirst"];
                                [userDef synchronize];
                                
                                
                            };
                            return cell;
                        }
                            break;
                        case 1:
                        {
                            
                            cell.addButtonBlock = ^(UIButton *button) {
                                [self.dataArray addObject:sign];
                                [NSKeyedArchiver archiveRootObject:_dataArray toFile:_goalPath];
                                [cell removeFromSuperview];
                                _tempFlag = NO;
                                [_recommendGoalArray removeObject:sign];
                                [_tableView reloadData];
                                
                                _flag = YES;
                                NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
                                // 保存用户数据
                                [userDef setBool:_flag forKey:@"notFirst"];
                                [userDef synchronize];
                            };
                            return cell;
                        }
                            break;
                        case 2:
                        {
                            
                            cell.addButtonBlock = ^(UIButton *button) {
                                [self.dataArray addObject:sign];
                                [NSKeyedArchiver archiveRootObject:_dataArray toFile:_goalPath];
                                [cell removeFromSuperview];
                                _tempFlag = NO;
                                [_recommendGoalArray removeObject:sign];
                                [_tableView reloadData];
                                
                                _flag = YES;
                                NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
                                // 保存用户数据
                                [userDef setBool:_flag forKey:@"notFirst"];
                                [userDef synchronize];
                            };
                            return cell;
                        }
                            break;
                        case 3:
                        {
                            
                            cell.addButtonBlock = ^(UIButton *button) {
                                [self.dataArray addObject:sign];
                                [NSKeyedArchiver archiveRootObject:_dataArray toFile:_goalPath];
                                [cell removeFromSuperview];
                                _tempFlag = NO;
                                [_recommendGoalArray removeObject:sign];
                                [_tableView reloadData];
                                
                                _flag = YES;
                                NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
                                // 保存用户数据
                                [userDef setBool:_flag forKey:@"notFirst"];
                                [userDef synchronize];
                            };
                            return cell;
                        }
                            break;
                            
                        default:
                            break;
                    }
                }
            }

        }else {
            PLSignCellObject *sign = _dataArray[indexPath.row];
            
            cell.titleString = sign.titleString;
            cell.iconImage = [UIImage imageNamed:@"unover"];
            cell.buttonTitle = @"打卡";
            
            
            cell.addButtonBlock = ^(UIButton *button) {
                cell.iconImage = [UIImage imageNamed:@"over"];
                cell.buttonTitle = @"已打卡";
                
            };
            return cell;
        }
    }else {
        if (self.recommendGoalArray.count != 0) {
            
            if (indexPath.section == 0) {
                cell.buttonTitle = @"添加";
                PLSignCellObject *sign = _recommendGoalArray[indexPath.row];
                cell.titleString = sign.titleString;
                cell.iconImage = sign.imageView;
                switch (indexPath.row) {
                    case 0:
                    {
                        cell.addButtonBlock = ^(UIButton *button) {
                            
                            [self.dataArray addObject:sign];
                            [NSKeyedArchiver archiveRootObject:_dataArray toFile:_goalPath];
                            [cell removeFromSuperview];
                            _tempFlag = NO;
                            [_recommendGoalArray removeObject:sign];
                            [_tableView reloadData];
                            
                            _flag = YES;
                            
                            NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
                            // 保存用户数据
                            [userDef setBool:_flag forKey:@"notFirst"];
                            [userDef synchronize];
                            
                            
                        };
                        return cell;
                    }
                        break;
                    case 1:
                    {
                        
                        cell.addButtonBlock = ^(UIButton *button) {
                            [self.dataArray addObject:sign];
                            [NSKeyedArchiver archiveRootObject:_dataArray toFile:_goalPath];
                            [cell removeFromSuperview];
                            [_recommendGoalArray removeObject:sign];
                            [_tableView reloadData];
                            
                            _flag = YES;
                            NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
                            // 保存用户数据
                            [userDef setBool:_flag forKey:@"notFirst"];
                            [userDef synchronize];
                        };
                        return cell;
                    }
                        break;
                    case 2:
                    {
                        
                        cell.addButtonBlock = ^(UIButton *button) {
                            [self.dataArray addObject:sign];
                            [NSKeyedArchiver archiveRootObject:_dataArray toFile:_goalPath];
                            [cell removeFromSuperview];
                            [_recommendGoalArray removeObject:sign];
                            [_tableView reloadData];
                            
                            _flag = YES;
                            NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
                            // 保存用户数据
                            [userDef setBool:_flag forKey:@"notFirst"];
                            [userDef synchronize];
                        };
                        return cell;
                    }
                        break;
                    case 3:
                    {
                        
                        cell.addButtonBlock = ^(UIButton *button) {
                            [self.dataArray addObject:sign];
                            [NSKeyedArchiver archiveRootObject:_dataArray toFile:_goalPath];
                            [cell removeFromSuperview];
                            [_recommendGoalArray removeObject:sign];
                            [_tableView reloadData];
                            
                            _flag = YES;
                            NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
                            // 保存用户数据
                            [userDef setBool:_flag forKey:@"notFirst"];
                            [userDef synchronize];
                        };
                        return cell;
                    }
                        break;
                        
                    default:
                        break;
                }
            }
        }
        PLSignCellObject *sign = _dataArray[indexPath.row];
        
        cell.titleString = sign.titleString;
        cell.iconImage = [UIImage imageNamed:@"unover"];
        cell.buttonTitle = @"打卡";
        
        
        cell.addButtonBlock = ^(UIButton *button) {
            cell.iconImage = [UIImage imageNamed:@"over"];
            cell.buttonTitle = @"已打卡";
            
        };
        return cell;

    }
    return 0;

}

@end
