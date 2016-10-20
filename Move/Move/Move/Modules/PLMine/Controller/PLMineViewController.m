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

@property (nonatomic, strong) UILabel *timeCopy;

@end

@implementation PLMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = ColorWithBackGround;
    
    
    [self.view addSubview:self.tableView];
    
    [self createButton];
    
}



- (UITableView *)tableView {

    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = ColorWithBackGround;
    }
    return _tableView;
}


#pragma mark - tableView协议方法


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
        return 220;
    } else{
        return 44;
    }
    

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    
    if (indexPath.section == 0) {
    
        PLInitialWeightTableViewCell *initialCell = [tableView dequeueReusableCellWithIdentifier:InitialWeight];
        
        
        if (!initialCell) {
            initialCell = [[NSBundle mainBundle] loadNibNamed:InitialWeight owner:nil options:nil].lastObject;
            initialCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        return initialCell;
    } else if(indexPath.section == 1){
        if (indexPath.row == 0) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
                cell.backgroundColor = ColorWith51Black;
                cell.textLabel.text = @"历史记录";
                cell.textLabel.textColor = [UIColor grayColor];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
            }
            return cell;
        } else {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:recordCell];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:recordCell];
                cell.imageView.image = [UIImage imageNamed:@"record"];
                cell.textLabel.text = @"没有近期活动日志";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.backgroundColor = ColorWith51Black;
                cell.textLabel.textColor = [UIColor grayColor];
                
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
            cell.backgroundColor = ColorWith51Black;
            cell.textLabel.textColor = [UIColor grayColor];
        }
        return cell;
    
    
    }


    
    
}

#pragma mark - 私有方法

- (void)createButton {
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
    self.tableView.tableFooterView = footView;
    self.timeCopy = [[UILabel alloc] initWithFrame:CGRectMake((WIDTH - 300) / 2, 20, 300, 20)];
    _timeCopy.text = @"上次备份时间:无";
    _timeCopy.textColor = [UIColor grayColor];
    _timeCopy.textAlignment = NSTextAlignmentCenter;
    [footView addSubview:_timeCopy];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"现在备份数据" forState:UIControlStateNormal];
    [button setTitleColor:PLYELLOW forState:UIControlStateNormal];
    button.layer.cornerRadius = 10.f;
    button.frame = CGRectMake((WIDTH - (WIDTH - 20)) / 2, 50, WIDTH - 20, 44);
    button.layer.borderColor = PLYELLOW.CGColor;
    button.layer.borderWidth = 1.f;
    button.backgroundColor = ColorWith51Black;
    [footView addSubview:button];
    
    
    

}

@end
