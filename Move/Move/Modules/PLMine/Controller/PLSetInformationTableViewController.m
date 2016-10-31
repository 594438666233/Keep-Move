//
//  PLSetInformationTableViewController.m
//  Move
//
//  Created by 胡梦龙 on 16/10/31.
//  Copyright © 2016年 PhelanGeek. All rights reserved.
//

#import "PLSetInformationTableViewController.h"

@interface PLSetInformationTableViewController ()


@property (weak, nonatomic) IBOutlet UITextField *gender;

@property (weak, nonatomic) IBOutlet UITextField *brithYear;

@property (weak, nonatomic) IBOutlet UITextField *height;

@property (weak, nonatomic) IBOutlet UITextField *weight;

@property (weak, nonatomic) IBOutlet UITextField *steps;

@end

@implementation PLSetInformationTableViewController




+ (instancetype)pl_setInformationTableViewController {

    return [[UIStoryboard storyboardWithName:NSStringFromClass(self) bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass(self)];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = ColorWithBackGround;
    
    self.tableView.separatorColor = ColorWithBackGround;
    
    [self createLabel];
    
    self.weight.inputView.backgroundColor = [UIColor blackColor];
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}




- (void)createLabel {
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 200)];
    self.tableView.tableFooterView = footView;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, WIDTH, 20)];
    label.text = @"完善基本信息令运动结果更准确";
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:14.f];
    [footView addSubview:label];
    

}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
