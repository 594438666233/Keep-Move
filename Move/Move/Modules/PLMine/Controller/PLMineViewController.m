//
//  PLMineViewController.m
//  Move
//
//  Created by PhelanGeek on 2016/10/19.
//  Copyright © 2016年 PhelanGeek. All rights reserved.
//

#import "PLMineViewController.h"
#import "PLInitialWeightTableViewCell.h"

static NSString *const InitialWeight = @"PLInitialWeightTableViewCell";
static NSString *const cellID = @"cell";
static NSString *const recordCell = @"recordCell";
static NSString *const setCell = @"setCell";


@interface PLMineViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation PLMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor yellowColor];
    
    
    [self.view addSubview:self.tableView];
    
 
    
}



- (UITableView *)tableView {

    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        
    }
    return _tableView;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return 1;
            break;
            
        case 1:
            return 2;
            break;
            
        case 2:
            return 1;
            break;
            
        default:
            break;
    }
    
    
    
    return 0;
    

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        return 230;
    } else{
        return 44;
    }
    

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    
    if (indexPath.section == 0) {
    
        PLInitialWeightTableViewCell *initialCell = [tableView dequeueReusableCellWithIdentifier:InitialWeight];
        
        
        if (!initialCell) {
            initialCell = [[NSBundle mainBundle] loadNibNamed:InitialWeight owner:nil options:nil].lastObject;
        }
        
        return initialCell;
    } else if(indexPath.section == 1){
        if (indexPath.row == 0) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
                
                cell.textLabel.text = @"历史记录";
                
            }
            return cell;
        } else {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:recordCell];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:recordCell];
                cell.imageView.image = [UIImage imageNamed:@"record"];
                cell.textLabel.text = @"没有近期活动日志";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
            }
            return cell;
        
        }
        
    
    
    } else {
    
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:setCell];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:setCell];
            cell.imageView.image = [UIImage imageNamed:@"set"];
            cell.textLabel.text = @"数据与设置";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
        }
        return cell;
    
    
    }


    
    
}



@end
