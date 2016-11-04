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
#import "PLDetailInfoView.h"
#import <AVFoundation/AVFoundation.h>
#import "NSString+TimeFormat.h"
@import CoreMotion;

@interface PLRunNowViewController ()
<
    MAMapViewDelegate,
    AMapSearchDelegate
>
@property (nonatomic, retain) MAMapView *mapView;
@property (nonatomic, strong) MAUserLocation *userLocation;
@property (nonatomic, strong) AMapSearchAPI *mapSearchAPI;
@property (nonatomic, strong) AMapLocalWeatherLive *live;
@property (nonatomic, strong) AMapLocalWeatherForecast *forecast;
@property (nonatomic, strong) AMapLocalDayWeatherForecast *dayForecast;
@property (nonatomic, strong) AMapReGeocodeSearchRequest *regeo;

@property (nonatomic, strong) NSString *address;

@property (nonatomic, retain) UIButton *beginButton;
@property (nonatomic, retain) UIButton *backButton;
@property (nonatomic, retain) UIButton *locationButton;
@property (nonatomic, retain) UIButton *voiceButton;
@property (nonatomic, assign) BOOL flag;

@property (nonatomic, retain) PLMenuView *plMenuView;
@property (nonatomic, retain) PLDetailInfoView *plDetailView;

@property (nonatomic, retain) UIView *blurView;
@property (nonatomic, retain) UILabel *timeLabel;
@property (nonatomic, assign) NSInteger temp;
@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, retain) NSTimer *runTimer;
@property (nonatomic, assign) int runTime;

@property (nonatomic, retain) AVSpeechUtterance *utterance;

@property (nonatomic, assign) NSInteger bigCalorie;

@property (nonatomic, retain) NSMutableArray *commonPolylineCoords;


@property (nonatomic, assign) BOOL startMoving;
/** 计步 */
@property (strong, nonatomic) CMPedometer *pedometer;

/** 语言数组 */
@property (nonatomic, strong) NSArray<AVSpeechSynthesisVoice *> *laungeVoices;

/** 语音合成器 */
@property (nonatomic, strong) AVSpeechSynthesizer *synthesizer;

@property (nonatomic, copy) NSString *speakingString;

@property (nonatomic, retain) UIImage *voiceOpenImage;
@property (nonatomic, retain) UIImage *voiceCloseImage;
@end

@implementation PLRunNowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.commonPolylineCoords = [NSMutableArray array];
    _flag = YES;
    _startMoving = NO;
    _bigCalorie = 0;
    [self setupMap];
    [self setupButton];
    [self initLocationButton];
    [self initVoiceButton];
}

#pragma mark - 懒加载
- (NSArray<AVSpeechSynthesisVoice *> *)laungeVoices {
    if (_laungeVoices == nil) {
        _laungeVoices = @[
                          //美式英语
                          [AVSpeechSynthesisVoice voiceWithLanguage:@"en-US"],
                          //英式英语
                          [AVSpeechSynthesisVoice voiceWithLanguage:@"en-GB"],
                          //中文
                          [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"]
                          ];
    }
    return _laungeVoices;
}

- (AVSpeechSynthesizer *)synthesizer {
    if (_synthesizer == nil) {
        _synthesizer = [[AVSpeechSynthesizer alloc] init];
        _synthesizer.delegate = (id)self;
    }
    return _synthesizer;
}

- (CMPedometer *)pedometer {
    
    if (!_pedometer) {
        _pedometer = [[CMPedometer alloc]init];
    }
    return _pedometer;
}

#pragma mark - 设置

- (void)setupMap {
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
    // 设置地图logo位置
    _mapView.logoCenter = CGPointMake(CGRectGetWidth(_mapView.bounds)-35, CGRectGetHeight(_mapView.bounds)-10);
    
    
    //代理
    _mapView.delegate = self;
    
    self.mapSearchAPI = [[AMapSearchAPI alloc] init];
    _mapSearchAPI.delegate = self;
    
    
    self.regeo = [[AMapReGeocodeSearchRequest alloc] init];
    
 
    
    [self.view addSubview:_mapView];

}

- (void)initLocationButton
{

    self.locationButton = [[UIButton alloc] initWithFrame:CGRectMake(PLWIDTH - 40, PLHEIGHT - PLHEIGHT / 2 - 64 + 70, 30, 30)];
    _locationButton.backgroundColor = [UIColor blackColor];
    _locationButton.layer.cornerRadius = 15;
    [_locationButton setImage:[UIImage imageNamed:@"myLocation"] forState:UIControlStateNormal];
    _locationButton.imageEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
    [self.locationButton addTarget:self action:@selector(actionLocation) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.locationButton];
}

- (void)initVoiceButton {
    self.voiceButton = [[UIButton alloc] initWithFrame:CGRectMake(10, PLHEIGHT - PLHEIGHT / 2 - 64 + 70, 30, 30)];
    _voiceButton.backgroundColor = [UIColor blackColor];
    _voiceButton.layer.cornerRadius = 15;
    self.voiceOpenImage = [UIImage imageNamed:@"openVoice"];
    self.voiceCloseImage = [UIImage imageNamed:@"closeVoice"];

    [_voiceButton setImage:_voiceOpenImage forState:UIControlStateNormal];
    _voiceButton.imageEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
    [_voiceButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{

        if (_flag == YES) {

            [_voiceButton setImage:_voiceCloseImage forState:UIControlStateNormal];
            _flag = NO;
            //立即暂停播放
            [self.synthesizer pauseSpeakingAtBoundary:AVSpeechBoundaryImmediate];
        }else {

             [_voiceButton setImage:_voiceOpenImage forState:UIControlStateNormal];
            _flag = YES;
            //继续播放
            [self.synthesizer continueSpeaking];
        }
        
    }];
    
    [self.view addSubview:self.voiceButton];
}

- (void)setupNavigationView {
    // 设置导航栏view
    PLNavigationView *plNavigationView = [[PLNavigationView alloc] init];
    plNavigationView.frame = CGRectMake(0, 0, PLWIDTH, 64);
    plNavigationView.titleString = @"GPS运动";
    [plNavigationView.cancelButton setBackgroundImage:[UIImage imageNamed:@"weather"] forState:UIControlStateNormal];
    [plNavigationView.deleteButton setBackgroundImage:[UIImage imageNamed:@"historyRecord"] forState:UIControlStateNormal];
    plNavigationView.cancelButtonBlock = ^(UIButton *button){
        // 天气信息
        NSString *address = [NSString stringWithFormat:@"%@", _live.city];
        NSString *weather = [NSString stringWithFormat:@"天气 : %@", _live.weather];
        NSString *temperature = [NSString stringWithFormat:@"温度 : %@°", _live.temperature];
        NSString *humidity = [NSString stringWithFormat:@"湿度 : %@%%", _live.humidity];
        NSString *wind = [NSString stringWithFormat:@"%@风%@级", _live.windDirection, _live.windPower];

        
        [FTPopOverMenu showForSender:button withMenu:@[address, weather, temperature, humidity, wind] doneBlock:^(NSInteger selectedIndex) {

        } dismissBlock:nil];
        
        
        
    };
    plNavigationView.deleteButtonBlock = ^(UIButton *button) {
        NSLog(@"hello");
    };
    [self.view addSubview:plNavigationView];
    
    self.plMenuView = [[PLMenuView alloc] init];
    _plMenuView.frame = CGRectMake(0, 64, PLWIDTH, PLHEIGHT - PLHEIGHT / 2 - 64 );
    [self.view addSubview:_plMenuView];
    
    self.plDetailView = [[PLDetailInfoView alloc] init];
    _plDetailView.alpha = 0.0;
    _plDetailView.frame = CGRectMake(0, 64, PLWIDTH, PLHEIGHT - PLHEIGHT / 2 - 64 );
    [self.view addSubview:_plDetailView];
    
    
}



- (void)setupButton {
    
        self.beginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _beginButton.layer.cornerRadius = 5.0f;
        _beginButton.titleLabel.font = [UIFont systemFontOfSize:15];
        CGFloat buttonW = (PLWIDTH - 20 * 3) / 2;
        CGFloat buttonH = 50;
        CGFloat buttonX = 20;
        CGFloat buttonY = PLHEIGHT - 20 - buttonH;
        _beginButton.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        [_beginButton setTitle:@"开始" forState:UIControlStateNormal];
        [_beginButton setTitleColor:PLBLACK forState:UIControlStateNormal];
        [_beginButton setBackgroundColor:PLYELLOW];
        [self.view addSubview:_beginButton];
    
        [_beginButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            if ([_beginButton.titleLabel.text isEqualToString:@"开始"]) {
                
                // start live tracking
                [self.pedometer startPedometerUpdatesFromDate:[NSDate date] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
                    
                    // this block is called for each live update
                    
                    [self updateLabels:pedometerData];
                    
                }];
                
       
                
                
                // 为地图添加临时模糊效果
                self.blurView = [[UIView alloc] init];
                _blurView.backgroundColor = [UIColor blackColor];
                _blurView.frame = _mapView.frame;
                _blurView.alpha = 0.5f;
                
                self.temp = 3;
                // 倒计时Label
                self.timeLabel = [[UILabel alloc] init];
                _timeLabel.textAlignment = NSTextAlignmentCenter;
                [_blurView addSubview:_timeLabel];
                [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.center.mas_equalTo(_blurView);
                    make.width.mas_equalTo(_blurView);
                    make.height.mas_equalTo(@100);
                }];
                
                _timeLabel.font = [UIFont systemFontOfSize:100];
                _timeLabel.textColor = [UIColor whiteColor];
                _plMenuView.hidden = YES;
                _beginButton.hidden = YES;
                _backButton.hidden = YES;
                [self.view addSubview:_blurView];
                
                self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
                [_timer fire];
            
                [UIView animateWithDuration:3.0f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{

                _plMenuView.alpha = 0.0f;
                _plDetailView.alpha = 1.0f;
        
                } completion:^(BOOL finished) {
                
                }];
            
                [UIView animateWithDuration:0 delay:3.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{

                    _blurView.alpha = 0.0;

                    
                } completion:^(BOOL finished) {
                    if(finished) {
                        _beginButton.hidden = NO;
                        _backButton.hidden = NO;
                        [_beginButton setTitle:@"结束" forState:UIControlStateNormal];
                        [_backButton setTitle:@"暂停" forState:UIControlStateNormal];
                        [_timer invalidate];
                        
                        if ([_voiceButton.currentImage isEqual:_voiceOpenImage]) {
                            self.speakingString = @"运动开始";
                            //创建一个会话
                            self.utterance = [[AVSpeechUtterance alloc] initWithString:_speakingString];
                            //选择语言发音的类别，如果有中文，一定要选择中文，要不然无法播放语音
                            _utterance.voice = self.laungeVoices[2];
                            
                            //播放语言
                            [self.synthesizer speakUtterance:_utterance];
                            
                            
                            // 设置开关
                            _startMoving = YES;
                            
                            // 开始计时
                            self.runTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(callTime) userInfo:nil repeats:YES];
                        }

                    }
                }];
     

            }else {
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"结束本次运动?" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                    if ([_voiceButton.currentImage isEqual:_voiceOpenImage]) {
                        self.speakingString = @"运动结束";
                        //创建一个会话
                        self.utterance = [[AVSpeechUtterance alloc] initWithString:_speakingString];
                        _utterance.voice = self.laungeVoices[2];
                        [self.synthesizer speakUtterance:_utterance];
                        
                        _startMoving = NO;

                        
                    }
                    [_beginButton setTitle:@"开始" forState:UIControlStateNormal];
                    [_backButton setTitle:@"返回" forState:UIControlStateNormal];
                    
                  
                }];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                [alert addAction:sureAction];
                [alert addAction:cancelAction];
                [self presentViewController:alert animated:YES completion:nil];

            }
   
            }];

    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _backButton.layer.cornerRadius = 5.0f;
    _backButton.titleLabel.font = [UIFont systemFontOfSize:15];
    _backButton.frame = CGRectMake(20 * 2 + buttonW, buttonY, buttonW, buttonH);
    [_backButton setTitle:@"返回" forState:UIControlStateNormal];
    [_backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_backButton setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:_backButton];
    [_backButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        if ([_backButton.titleLabel.text isEqualToString:@"返回"]) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }else if([_backButton.titleLabel.text isEqualToString:@"暂停"]) {
            [_backButton setTitle:@"继续" forState:UIControlStateNormal];
            if ([_voiceButton.currentImage isEqual:_voiceOpenImage]) {
                _speakingString = @"运动暂停";
                self.utterance = [[AVSpeechUtterance alloc] initWithString:_speakingString];
                _utterance.voice = self.laungeVoices[2];
                [self.synthesizer speakUtterance:_utterance];
                
                // 暂停定时器
                [self.runTimer invalidate];
                self.runTimer = nil;
            }
        }else {
            [_backButton setTitle:@"暂停" forState:UIControlStateNormal];
            if ([_voiceButton.currentImage isEqual:_voiceOpenImage]) {
                _speakingString = @"运动继续";
                self.utterance = [[AVSpeechUtterance alloc] initWithString:_speakingString];
                _utterance.voice = self.laungeVoices[2];
                [self.synthesizer speakUtterance:_utterance];
                
                
                // 开启定时器
                self.runTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(callTime) userInfo:nil repeats:YES];
            }
        }
        
    }];
}

#pragma mark - timerAction
- (void)timerAction {

    _timeLabel.text = [NSString stringWithFormat:@"%ld", _temp];
    _temp--;
}

#pragma mark - map Delegate

// 实时更新定位
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {
    self.userLocation = userLocation;
    // 参数1 : 纬度   参数2 : 经度
    _regeo.location = [AMapGeoPoint locationWithLatitude:_mapView.userLocation.coordinate.latitude longitude:_mapView.userLocation.coordinate.longitude];
    // 是否返回扩展信息
    _regeo.requireExtension = YES;
    [self.mapSearchAPI AMapReGoecodeSearch:_regeo];
    
    if (_startMoving == YES) {
        //构造折线数据对象
        CLLocation *currLocation = [[CLLocation alloc] initWithLatitude:_mapView.userLocation.coordinate.latitude longitude:_mapView.userLocation.coordinate.longitude];
        [self.commonPolylineCoords addObject:currLocation];
        
        
        MAMapPoint *arrayPoint = malloc(sizeof(MAMapPoint) * _commonPolylineCoords.count);
        for (int i = 0; i < _commonPolylineCoords.count; i++) {
            CLLocation *location = [_commonPolylineCoords objectAtIndex:i];
            MAMapPoint point = MAMapPointForCoordinate(location.coordinate);
            arrayPoint[i] = point;
        }
        MAPolyline *line = [MAPolyline polylineWithPoints:arrayPoint count:_commonPolylineCoords.count];
        [_mapView addOverlay:line];
        free(arrayPoint);
    }
    
}

// 逆地理编码回调
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response {
    if (response.regeocode != nil) {
        AMapReGeocode *reGeocode = response.regeocode;
        self.address = reGeocode.addressComponent.adcode;
        [self showWeatherInfo];
    }
}

// 设置折线的样式
- (MAOverlayView *)mapView:(MAMapView *)mapView viewForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineView *polylineView = [[MAPolylineView alloc] initWithPolyline:overlay];
        
        polylineView.lineWidth = 5.f;
        polylineView.strokeColor = [UIColor redColor];
        polylineView.lineJoin = kCGLineJoinMiter;//连接类型
        polylineView.lineCap = kCGLineCapRound;//端点类型
        
        return polylineView;
    }
    return nil;
}

- (void)actionLocation
{
    [self.mapView setUserTrackingMode:MAUserTrackingModeFollow];
}

#pragma mark - 天气信息
- (void)showWeatherInfo {
    AMapWeatherSearchRequest *weatherRequest = [[AMapWeatherSearchRequest alloc] init];
    weatherRequest.city = _address;
    weatherRequest.type = AMapWeatherTypeLive;
    [self.mapSearchAPI AMapWeatherSearch:weatherRequest];
    
    AMapWeatherSearchRequest *weatherRequest2 = [[AMapWeatherSearchRequest alloc] init];
    weatherRequest2.city = _address;
    weatherRequest2.type = AMapWeatherTypeForecast;
    
    [self.mapSearchAPI AMapWeatherSearch:weatherRequest2];
}

- (void)onWeatherSearchDone:(AMapWeatherSearchRequest *)request response:(AMapWeatherSearchResponse *)response {
    if (request.type == AMapWeatherTypeLive) {
        if (response.lives.count == 0) {
            return;
        }
        for (AMapLocalWeatherLive *live in response.lives) {
            self.live = live;
        }
    } else {
        if(response.forecasts.count == 0)
        {
            return;
        }
        for (AMapLocalWeatherForecast *forecast in response.forecasts) {
            self.forecast = forecast;
        }
    }
}

#pragma mark - update sports infomation

- (void)updateLabels:(CMPedometerData *)pedometerData {
   
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    formatter.maximumFractionDigits = 2;
    
    // step counting
    if ([CMPedometer isStepCountingAvailable]) {
        NSLog(@"stepNumber:%@", [pedometerData.numberOfSteps stringValue]);
        self.plDetailView.stepCount = [pedometerData.numberOfSteps stringValue];
        if ([pedometerData.numberOfSteps integerValue] % 30 >= 0) {
            _bigCalorie++;
            self.plDetailView.calorie = [NSString stringWithFormat:@"%ld", _bigCalorie];
        }
    } else {
        NSLog(@"Step Counter not available");
    }
   
    // distance
    if ([CMPedometer isDistanceAvailable]) {
        CGFloat meter = [pedometerData.distance floatValue];
        NSLog(@"%.1f", meter / 1000);
        self.plDetailView.km = [NSString stringWithFormat:@"%.1f", meter / 1000];

    } else {
        NSLog(@"Distance not available");
    }
    
    // cadence
    if ([CMPedometer isCadenceAvailable] && pedometerData.currentCadence) {
        NSLog(@"currentPace : %ld", [pedometerData.currentCadence integerValue]);
        self.plDetailView.rate = [NSString stringWithFormat:@"%ld", [pedometerData.currentCadence integerValue] ];
    }
}

- (void)callTime
{
    
    self.runTime ++;
    
    // 分别计算 时分秒
    int hour = _runTime / 3600;
    int minute = (_runTime - hour * 3600) / 60;
    int second = _runTime - hour * 3600 - minute * 60;
    
    if (hour > 0) {
        // 保证数字是两位，如果不满足，使用0来补位
        _plDetailView.time = [NSString stringWithFormat:@"%02d:%02d:%02d", hour, minute, second];
    }else if(minute > 0){
        _plDetailView.time = [NSString stringWithFormat:@"%02d:%02d", minute, second];
    }else {
        _plDetailView.time = [NSString stringWithFormat:@"00:%02d", second];
    }

}

@end
