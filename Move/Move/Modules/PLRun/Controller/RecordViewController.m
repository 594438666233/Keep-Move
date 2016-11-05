//
//  RecordViewController.m
//  iOS_2D_RecordPath
//
//  Created by PC on 15/8/3.
//  Copyright (c) 2015年 FENGSHENG. All rights reserved.
//

#import "RecordViewController.h"
#import "DisplayViewController.h"
#import "Record.h"
#import "FileHelper.h"
#import "PLNavigationView.h"

@interface RecordViewController()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *recordArray;

@end

@implementation RecordViewController

#pragma mark - UITableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DisplayViewController *displayController = [[DisplayViewController alloc] initWithNibName:nil bundle:nil];
    [displayController setRecord:self.recordArray[indexPath.row]];
    [self presentViewController:displayController animated:YES completion:nil];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle != UITableViewCellEditingStyleDelete)
    {
        return;
    }
    
    [FileHelper deleteFile:[[self.recordArray objectAtIndex:indexPath.row] title]];
    [self.recordArray removeObjectAtIndex:indexPath.row];
  
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - UITableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.recordArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentifier = @"recordCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIndentifier];
    }
    
    Record *record = self.recordArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = PLBLACK;
    cell.textLabel.text = [record title];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.text = [record subTitle];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    
    return cell;
}

#pragma mark - Life Cycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
       _recordArray = [FileHelper recordsArray];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNavigationView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, PLWIDTH, PLHEIGHT - 64)];
    _tableView.backgroundColor = PLBLACK;
    _tableView.rowHeight = 80.f;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    

}

- (void)setupNavigationView {
    // 设置导航栏view
    PLNavigationView *plNavigationView = [[PLNavigationView alloc] init];
    plNavigationView.frame = CGRectMake(0, 0, PLWIDTH, 64);
    plNavigationView.titleString = @"运动记录";
    plNavigationView.deleteButton.hidden = YES;
    plNavigationView.cancelButtonBlock = ^(UIButton *button){
        [self dismissViewControllerAnimated:YES completion:nil];

    };
    plNavigationView.deleteButtonBlock = ^(UIButton *button) {
        NSLog(@"hello");
    };
    [self.view addSubview:plNavigationView];
    

    
}

@end
