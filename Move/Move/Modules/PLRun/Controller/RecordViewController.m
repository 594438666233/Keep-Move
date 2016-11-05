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
#import "PLInformationCell.h"
#import "PLInfoModel.h"

static NSString *cellIndentifier = @"recordCell";

@interface RecordViewController()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSString *goalPath;

@property (nonatomic, strong) NSMutableArray *recordArray;
@property (nonatomic, strong) NSMutableArray *dataArray;


@end

@implementation RecordViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupPath];
    NSArray *pArray = [NSKeyedUnarchiver unarchiveObjectWithFile:_goalPath];
    self.dataArray = [NSMutableArray arrayWithArray:pArray];
    
    if (_dataArray.count == 0) {
        [_tableView removeFromSuperview];
        self.view.backgroundColor = PLBLACK;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH / 2 - 100, HEIGHT / 2 - 50, 200, 50)];
        label.text = @"运动记录为空";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = PLYELLOW;
        [self.view addSubview:label];
    }
}

- (void)setupPath {
    
 
    // 拼接路径
    NSArray *libraryArray = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *libraryPath = [libraryArray firstObject];
    
    // 列表
    NSString *path = [libraryPath stringByAppendingString:@"/Preferences"];
    path = [path stringByAppendingString:@"/RunRecord.plist"];
    self.goalPath = path;
    NSLog(@"%@", _goalPath);
}

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
    
    [self.dataArray removeObjectAtIndex:indexPath.row];
    [NSKeyedArchiver archiveRootObject:_dataArray toFile:_goalPath];
  
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - UITableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return self.recordArray.count;
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    PLInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    
    if (cell == nil)
    {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIndentifier];
        cell = [[PLInformationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    
//    Record *record = self.recordArray[indexPath.row];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.backgroundColor = PLBLACK;
//    cell.textLabel.text = [record title];
//    cell.textLabel.textColor = [UIColor whiteColor];
//    cell.detailTextLabel.text = [record subTitle];
//    cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
//    cell.detailTextLabel.textColor = [UIColor whiteColor];
    PLInfoModel *infoModel = _dataArray[indexPath.row];
    cell.infoModel = infoModel;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
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
    
    [self setupTableView];
            

}

- (void)setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, PLWIDTH, PLHEIGHT - 64)];
    _tableView.backgroundColor = PLBLACK;
    _tableView.rowHeight = PLHEIGHT * 0.35;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerNib:[UINib nibWithNibName:@"PLInformationCell" bundle:nil] forCellReuseIdentifier:cellIndentifier];
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
