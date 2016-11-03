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

@interface PLRunNowViewController ()
<
    MAMapViewDelegate
>
@property (nonatomic, retain) MAMapView *mapView;
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

@property (nonatomic, retain) AVSpeechUtterance *utterance;

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
    
    _flag = YES;
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
        _synthesizer.delegate = self;
    }
    return _synthesizer;
}

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
    [plNavigationView.cancelButton setBackgroundImage:[UIImage imageNamed:@"music"] forState:UIControlStateNormal];
    [plNavigationView.deleteButton setBackgroundImage:[UIImage imageNamed:@"historyRecord"] forState:UIControlStateNormal];
    plNavigationView.cancelButtonBlock = ^(UIButton *button){
        [self dismissViewControllerAnimated:YES completion:nil];
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

- (void)actionLocation
{
    [self.mapView setUserTrackingMode:MAUserTrackingModeFollow];
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
            }
        }else {
            [_backButton setTitle:@"暂停" forState:UIControlStateNormal];
            if ([_voiceButton.currentImage isEqual:_voiceOpenImage]) {
                _speakingString = @"运动继续";
                self.utterance = [[AVSpeechUtterance alloc] initWithString:_speakingString];
                _utterance.voice = self.laungeVoices[2];
                [self.synthesizer speakUtterance:_utterance];
            }
        }
        
    }];
}

- (void)timerAction {

    _timeLabel.text = [NSString stringWithFormat:@"%ld", _temp];
    _temp--;
}


@end
