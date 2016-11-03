//
//  PLRunNowViewController.m
//  Move
//
//  Created by PhelanGeek on 2016/11/2.
//  Copyright © 2016年 PhelanGeek. All rights reserved.
//

#import "PLRunNowViewController.h"
#import <MAMapKit/MAMapKit.h>
#import "PLNavigationView.h"
#import "PLMenuView.h"

@interface PLRunNowViewController ()
<
    MAMapViewDelegate
>
@property (nonatomic, retain) MAMapView *mapView;
@property (nonatomic, retain) UIButton *beginButton;
@property (nonatomic, retain) UIButton *backButton;

@end

@implementation PLRunNowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 初始化地图
    self.mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, PLHEIGHT / 2, PLWIDTH, PLHEIGHT / 2)];
    [self setupNavigationView];
 
    // 地图语言
    _mapView.language = MAMapLanguageZhCN;
    // 地图类型
    _mapView.mapType = MAMapTypeStandard;
    // 隐藏指南针
    _mapView.showsCompass = NO;
    // 隐藏比例尺
    _mapView.showsScale= NO;
    // 开启定位
    _mapView.showsUserLocation = YES;
    // 地图跟随用户位置移动
    [_mapView setUserTrackingMode: MAUserTrackingModeFollow animated:YES]; //地图跟着位置移动
    // 后台持续定位
    _mapView.pausesLocationUpdatesAutomatically = NO;
    _mapView.allowsBackgroundLocationUpdates = YES;//iOS9以上系统必须配置
    

    //代理
    _mapView.delegate = self;
    
    //构造折线数据对象
    CLLocationCoordinate2D commonPolylineCoords[4];
    commonPolylineCoords[0].latitude = 39.832136;
    commonPolylineCoords[0].longitude = 116.34095;
    
    commonPolylineCoords[1].latitude = 39.832136;
    commonPolylineCoords[1].longitude = 116.42095;
    
    commonPolylineCoords[2].latitude = 39.902136;
    commonPolylineCoords[2].longitude = 116.42095;
    
    commonPolylineCoords[3].latitude = 39.902136;
    commonPolylineCoords[3].longitude = 116.44095;
    
    //构造折线对象
    MAPolyline *commonPolyline = [MAPolyline polylineWithCoordinates:commonPolylineCoords count:4];
    
    //在地图上添加折线对象
    [_mapView addOverlay: commonPolyline];
    
    [self.view addSubview:_mapView];
    [self setupButton];

}

- (void)setupNavigationView {
    // 设置导航栏view
    PLNavigationView *plNavigationView = [[PLNavigationView alloc] init];
    plNavigationView.frame = CGRectMake(0, 0, PLWIDTH, 64);
    plNavigationView.titleString = @"GPS运动";
    [plNavigationView.cancelButton setBackgroundImage:[UIImage imageNamed:@"music"] forState:UIControlStateNormal];
    [plNavigationView.deleteButton setBackgroundImage:[UIImage imageNamed:@"historyRecord"] forState:UIControlStateNormal];
    plNavigationView.cancelButtonBlock = ^(UIButton *button){
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    plNavigationView.deleteButtonBlock = ^(UIButton *button) {
        NSLog(@"hello");
    };
    [self.view addSubview:plNavigationView];
    
    PLMenuView *plMeauView = [[PLMenuView alloc] init];
    plMeauView.frame = CGRectMake(0, 64, PLWIDTH, PLHEIGHT - PLHEIGHT / 2 - 64 );
    [self.view addSubview:plMeauView];
    
    
}

- (void)setupButton {
    for (int i = 1; i <= 2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.layer.cornerRadius = 5.0f;
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        CGFloat buttonW = (PLWIDTH - 20 * 3) / 2;
        CGFloat buttonH = 50;
        CGFloat buttonX = i * 20 + (i - 1) * buttonW;
        CGFloat buttonY = PLHEIGHT - 20 - buttonH;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        if (i == 1) {
            [button setTitle:@"开始" forState:UIControlStateNormal];
            [button setTitleColor:PLBLACK forState:UIControlStateNormal];
            [button setBackgroundColor:PLYELLOW];
            [button handleControlEvent:UIControlEventTouchUpInside withBlock:^{
                // code begin run
   
            }];
        }else {
            [button setTitle:@"返回" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setBackgroundColor:[UIColor grayColor]];
            [button handleControlEvent:UIControlEventTouchUpInside withBlock:^{
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
        }
        [self.view addSubview:button];
    }
}

#pragma mark - mapView代理 -
//地图区域将要改变
- (void)mapView:(MAMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
    NSLog(@"地图区域将要改变");
}
//地图区域改变完毕
- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    NSLog(@"地图区域已经变化");
}
//地图将要移动
- (void)mapView:(MAMapView *)mapView mapWillMoveByUser:(BOOL)wasUserAction {
    NSLog(@"地图将要移动");
}
//地图移动完毕
- (void)mapView:(MAMapView *)mapView mapDidMoveByUser:(BOOL)wasUserAction {
    NSLog(@"地图已经移动完毕");
}
//地图将要缩放
- (void)mapView:(MAMapView *)mapView mapWillZoomByUser:(BOOL)wasUserAction {
    NSLog(@"地图将要缩放");
}
//地图缩放完毕
- (void)mapView:(MAMapView *)mapView mapDidZoomByUser:(BOOL)wasUserAction {
    NSLog(@"地图已经缩放完毕");
}

- (MAOverlayView *)mapView:(MAMapView *)mapView viewForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineView *polylineView = [[MAPolylineView alloc] initWithPolyline:overlay];
        
        polylineView.lineWidth = 10.f;
        polylineView.strokeColor = [UIColor greenColor];
        polylineView.lineJoin = kCGLineJoinRound;//连接类型
        polylineView.lineCap = kCGLineCapRound;//端点类型
        
        return polylineView;
    }
    return nil;
}

-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation)
    {
        //取出当前位置的坐标
        NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
    }
}
@end
