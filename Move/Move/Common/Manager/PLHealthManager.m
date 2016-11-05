//
//  PLHealthManager.m
//  Move
//
//  Created by PhelanGeek on 2016/10/21.
//  Copyright © 2016年 PhelanGeek. All rights reserved.
//

#import "PLHealthManager.h"

#import "PLHealthManager.h"
#import <HealthKit/HealthKit.h>

@interface PLHealthManager (){
    HKHealthStore  *store;    
}

@property (nonatomic, strong) NSMutableArray *healthSteps;
@property (nonatomic, strong) NSMutableArray *healthDistances;
@property (nonatomic, strong) NSMutableArray *healthStairsClimbed;
@property (nonatomic, strong) NSMutableArray *healthActiveEnergy;

@end

@implementation PLHealthManager

- (void)getIphoneHealthData{
    self.healthSteps = [NSMutableArray array];
    self.healthDistances = [NSMutableArray array];
    self.healthStairsClimbed = [NSMutableArray array];
    self.healthActiveEnergy = [NSMutableArray array];
    
    NSSet *getData;
    
    // 1.判断设备是否支持HealthKit框架
    if ([HKHealthStore isHealthDataAvailable]) {
        
        getData = [self getData];
        
    } else {
        NSLog(@"---------不支持 HealthKit 框架");
    }
    
    store = [[HKHealthStore alloc] init];
    
    // 2.请求苹果健康的认证
    [store requestAuthorizationToShareTypes:nil readTypes:getData completion:^(BOOL success, NSError * _Nullable error) {
        if (!success) {
            NSLog(@"--------请求苹果健康认证失败");
            
            return ;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // 3.获取苹果健康数据
            [self getHealthStepData];
            [self getHealthDistanceData];
            [self getHealthStairsClimbedData];
            [self getHealthEnergyData];
        });
        
    }];
}

- (NSSet *)getData{
    HKQuantityType  *step = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    HKQuantityType *distance = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    HKQuantityType *stairs = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierFlightsClimbed];
    HKQuantityType *energy = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];
    
    return [NSSet setWithObjects:step,distance,stairs,energy, nil];
}

/*
 - (void)updateStep{
 
 NSCalendar *calendar = [NSCalendar currentCalendar];
 
 NSDate *now = [NSDate date];
 
 NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
 
 NSDate *startDate = [calendar dateFromComponents:components];
 
 NSDate *endDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:startDate options:0];
 
 HKQuantityType *sampleType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
 
 NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionStrictStartDate];
 
 HKStatisticsQuery *query = [[HKStatisticsQuery alloc] initWithQuantityType:sampleType quantitySamplePredicate:predicate options:HKStatisticsOptionCumulativeSum completionHandler:^(HKStatisticsQuery *query, HKStatistics *result, NSError *error) {
 //        if (!result) {
 //            if (completionHandler) {
 //                completionHandler(0.0f, error);
 //            }
 //            return;
 //        }
 
 double totalStep = [result.sumQuantity doubleValueForUnit:[HKUnit countUnit]];
 NSLog(@" ***************步数统计是：%f",totalStep);
 }];
 
 [store executeQuery:query];
 
 }
 
 - (void)updateDistance{
 
 NSCalendar *calendar = [NSCalendar currentCalendar];
 
 NSDate *now = [NSDate date];
 
 NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
 
 NSDate *startDate = [calendar dateFromComponents:components];
 
 NSDate *endDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:startDate options:0];
 
 HKQuantityType *sampleType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
 
 NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionStrictStartDate];
 
 HKStatisticsQuery *query = [[HKStatisticsQuery alloc] initWithQuantityType:sampleType quantitySamplePredicate:predicate options:HKStatisticsOptionCumulativeSum completionHandler:^(HKStatisticsQuery *query, HKStatistics *result, NSError *error) {
 //        if (!result) {
 //            if (completionHandler) {
 //                completionHandler(0.0f, error);
 //            }
 //            return;
 //        }
 
 double totalStep = [result.sumQuantity doubleValueForUnit:[HKUnit meterUnit]];
 NSLog(@" -------------距离统计是：%f",totalStep);
 }];
 
 [store executeQuery:query];
 }
 
 - (void)updateEnergy{
 
 NSCalendar *calendar = [NSCalendar currentCalendar];
 
 NSDate *now = [NSDate date];
 
 NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
 
 NSDate *startDate = [calendar dateFromComponents:components];
 
 NSDate *endDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:startDate options:0];
 
 HKQuantityType *sampleType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryEnergyConsumed];
 
 NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionStrictStartDate];
 
 HKStatisticsQuery *query = [[HKStatisticsQuery alloc] initWithQuantityType:sampleType quantitySamplePredicate:predicate options:HKStatisticsOptionCumulativeSum completionHandler:^(HKStatisticsQuery *query, HKStatistics *result, NSError *error) {
 //        if (!result) {
 //            if (completionHandler) {
 //                completionHandler(0.0f, error);
 //            }
 //            return;
 //        }
 
 double totalStep = [result.sumQuantity doubleValueForUnit:[HKUnit calorieUnit]];
 NSLog(@" -------------卡路里统计是：%f",totalStep);
 }];
 
 [store executeQuery:query];
 }
 */
- (void)getHealthStepData{
    HKHealthStore *healthStore = [[HKHealthStore alloc]init];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 设置时间支持单位
    NSDateComponents *anchorComponents =
    [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth |
     NSCalendarUnitYear | NSCalendarUnitWeekday fromDate:[NSDate date]];
    
    NSDate *anchorDate = [calendar dateFromComponents:anchorComponents];
    
    // 获取数据的截止时间 今天
    NSDate *endDate = [NSDate date];
    
    // 获取数据的起始时间 此处取从今日往前推100天的数据
    NSDate *startDate = [NSDate dateWithTimeIntervalSinceNow:-(_days)*24*60*60];
    
    // 数据类型
    HKQuantityType *type = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    
    // Your interval: sum by hour
    NSDateComponents *intervalComponents = [[NSDateComponents alloc] init];
    intervalComponents.day = 1;
    
    // Example predicate 用于获取设置时间段内的数据
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionStrictStartDate];
    
    
    HKStatisticsCollectionQuery *query = [[HKStatisticsCollectionQuery alloc] initWithQuantityType:type quantitySamplePredicate:predicate options:HKStatisticsOptionCumulativeSum anchorDate:anchorDate intervalComponents:intervalComponents];
    
    
    query.initialResultsHandler = ^(HKStatisticsCollectionQuery *query, HKStatisticsCollection *result, NSError *error) {
        
        for (HKStatistics *sample in [result statistics]) {
            //            NSLog(@"--------------%@ 至 %@ : %@", sample.startDate, sample.endDate, sample.sumQuantity);
            NSDate *date = sample.startDate;
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSString *dateTime = [formatter stringFromDate:date];
            
            double totalStep = [sample.sumQuantity doubleValueForUnit:[HKUnit countUnit]];
            NSString *appleHealth = @"com.apple.Health";
            
            double editStep  = 0.0;
            for (HKSource *source in sample.sources) {
                
                if ([source.bundleIdentifier isEqualToString:appleHealth]) {
                    // 获取用户自己添加的数据 并减去，防止用户手动刷数据
                    HKSource *healthSource = source;
                    editStep  = [[sample sumQuantityForSource:healthSource] doubleValueForUnit:[HKUnit countUnit]];
                }
            }
            
            NSInteger step = (NSInteger)totalStep - (NSInteger)editStep;
            
            NSString *value = [NSString stringWithFormat:@"%ld",step];
            
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                 dateTime,@"dateTime",
                                 value,@"value",nil];
            [self.healthSteps addObject:dic];
            //            NSLog(@"gaizaoDateStyle:%@  Dic = %@",self.healthSteps,dic);
        }
        
        
        NSLog(@"步数: %@", self.healthSteps);
        
    };
    
    [healthStore executeQuery:query];
}

- (void)getHealthDistanceData{
    HKHealthStore *healthStore = [[HKHealthStore alloc]init];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *anchorComponents =
    [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth |
     NSCalendarUnitYear | NSCalendarUnitWeekday fromDate:[NSDate date]];
    NSDate *anchorDate = [calendar dateFromComponents:anchorComponents];
    
    NSDate *endDate = [NSDate date];
    NSDate *startDate = [NSDate dateWithTimeIntervalSinceNow:-(_days)*24*60*60];
    
    HKQuantityType *type = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    
    // Your interval: sum by hour
    NSDateComponents *intervalComponents = [[NSDateComponents alloc] init];
    intervalComponents.day = 1;
    
    // Example predicate
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionStrictStartDate];
    
    HKStatisticsCollectionQuery *query = [[HKStatisticsCollectionQuery alloc] initWithQuantityType:type quantitySamplePredicate:predicate options:HKStatisticsOptionCumulativeSum anchorDate:anchorDate intervalComponents:intervalComponents];
    query.initialResultsHandler = ^(HKStatisticsCollectionQuery *query, HKStatisticsCollection *result, NSError *error) {
        for (HKStatistics *sample in [result statistics]) {
            //            NSLog(@"+++++++++++++++%@ 至 %@ : %@", sample.startDate, sample.endDate, sample.sumQuantity);
            NSDate *date = sample.startDate;
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSString *dateTime = [formatter stringFromDate:date];
            
            double totalDistance = [sample.sumQuantity doubleValueForUnit:[HKUnit meterUnit]];
            
            NSString *appleHealth = @"com.apple.Health";
            //            double floor = [sample.sumQuantity doubleValueForUnit:[HKUnit yardUnit]];
            double editDistance  = 0.0;
            for (HKSource *source in sample.sources) {
                if ([source.bundleIdentifier isEqualToString:appleHealth]) {
                    // 获取用户自己添加的数据 并减去，防止用户手动刷数据
                    HKSource *healthSource = source;
                    editDistance = [[sample sumQuantityForSource:healthSource] doubleValueForUnit:[HKUnit meterUnit]];
                }
            }
            
            double distance = totalDistance/1000 - editDistance/1000;
            
            NSString *value = [NSString stringWithFormat:@"%.2f",distance];
            
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                 dateTime,@"dateTime",
                                 value,@"step and running",nil];
            [self.healthDistances addObject:dic];
        }
        
        NSLog(@"走和跑的距离：%@",self.healthDistances);
    };
    
    [healthStore executeQuery:query];
}

- (void)getHealthStairsClimbedData {
    HKHealthStore *healthStore = [[HKHealthStore alloc]init];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 设置时间支持单位
    NSDateComponents *anchorComponents =
    [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth |
     NSCalendarUnitYear | NSCalendarUnitWeekday fromDate:[NSDate date]];
    
    NSDate *anchorDate = [calendar dateFromComponents:anchorComponents];
    
    // 获取数据的截止时间 今天
    NSDate *endDate = [NSDate date];
    // 获取数据的起始时间 此处取从今日往前推100天的数据
    NSDate *startDate = [NSDate dateWithTimeIntervalSinceNow:-(_days)*24*60*60];
    
    // 数据类型
    HKQuantityType *type = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierFlightsClimbed];
    
    // Your interval: sum by hour
    NSDateComponents *intervalComponents = [[NSDateComponents alloc] init];
    intervalComponents.day = 1;
    
    // Example predicate 用于获取设置时间段内的数据
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionStrictStartDate];
    
    
    HKStatisticsCollectionQuery *query = [[HKStatisticsCollectionQuery alloc] initWithQuantityType:type quantitySamplePredicate:predicate options:HKStatisticsOptionCumulativeSum anchorDate:anchorDate intervalComponents:intervalComponents];
    
    
    query.initialResultsHandler = ^(HKStatisticsCollectionQuery *query, HKStatisticsCollection *result, NSError *error) {
        
        for (HKStatistics *sample in [result statistics]) {
            //            NSLog(@"--------------%@ 至 %@ : %@", sample.startDate, sample.endDate, sample.sumQuantity);
            NSDate *date = sample.startDate;
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSString *dateTime = [formatter stringFromDate:date];
            
            double totalStep = [sample.sumQuantity doubleValueForUnit:[HKUnit countUnit]];
            NSString *appleHealth = @"com.apple.Health";
            
            double editStep  = 0.0;
            for (HKSource *source in sample.sources) {
                
                if ([source.bundleIdentifier isEqualToString:appleHealth]) {
                    // 获取用户自己添加的数据 并减去，防止用户手动刷数据
                    HKSource *healthSource = source;
                    editStep  = [[sample sumQuantityForSource:healthSource] doubleValueForUnit:[HKUnit countUnit]];
                }
            }
            
            NSInteger step = (NSInteger)totalStep - (NSInteger)editStep;
            
            NSString *value = [NSString stringWithFormat:@"%ld",step];
            
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                 dateTime,@"dateTime",
                                 value,@"value",nil];
            [self.healthStairsClimbed addObject:dic];
            //            NSLog(@"gaizaoDateStyle:%@  Dic = %@",self.healthSteps,dic);
        }
        
        
        NSLog(@"楼层: %@", self.healthStairsClimbed);
        
    };
    
    [healthStore executeQuery:query];
}



- (void)getHealthEnergyData {
    HKHealthStore *healthStore = [[HKHealthStore alloc]init];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 设置时间支持单位
    NSDateComponents *anchorComponents =
    [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth |
     NSCalendarUnitYear | NSCalendarUnitWeekday fromDate:[NSDate date]];
    
    NSDate *anchorDate = [calendar dateFromComponents:anchorComponents];
    
    // 获取数据的截止时间 今天
    NSDate *endDate = [NSDate date];
    // 获取数据的起始时间 此处取从今日往前推100天的数据
    NSDate *startDate = [NSDate dateWithTimeIntervalSinceNow:-(_days)*24*60*60];
    
    // 数据类型
    HKQuantityType *type = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];
    
    // Your interval: sum by hour
    NSDateComponents *intervalComponents = [[NSDateComponents alloc] init];
    intervalComponents.day = 1;
    
    // Example predicate
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionStrictStartDate];
    
    HKStatisticsCollectionQuery *query = [[HKStatisticsCollectionQuery alloc] initWithQuantityType:type quantitySamplePredicate:predicate options:HKStatisticsOptionCumulativeSum anchorDate:anchorDate intervalComponents:intervalComponents];
    query.initialResultsHandler = ^(HKStatisticsCollectionQuery *query, HKStatisticsCollection *result, NSError *error) {
        for (HKStatistics *sample in [result statistics]) {
            //            NSLog(@"+++++++++++++++%@ 至 %@ : %@", sample.startDate, sample.endDate, sample.sumQuantity);
            NSDate *date = sample.startDate;
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSString *dateTime = [formatter stringFromDate:date];
            
            double totalDistance = [sample.sumQuantity doubleValueForUnit:[HKUnit kilocalorieUnit]];
            
            NSString *appleHealth = @"com.apple.Health";
            //            double floor = [sample.sumQuantity doubleValueForUnit:[HKUnit yardUnit]];
            double editDistance  = 0.0;
            for (HKSource *source in sample.sources) {
                if ([source.bundleIdentifier isEqualToString:appleHealth]) {
                    // 获取用户自己添加的数据 并减去，防止用户手动刷数据
                    HKSource *healthSource = source;
                    editDistance = [[sample sumQuantityForSource:healthSource] doubleValueForUnit:[HKUnit kilocalorieUnit]];
                }
            }
            
            double distance = totalDistance - editDistance;
            
            NSString *value = [NSString stringWithFormat:@"%.2f",distance];
            
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                 dateTime,@"dateTime",
                                 value,@"activeEnergy",nil];
            [self.healthActiveEnergy addObject:dic];
        }
        
        NSLog(@"活动能量：%@",self.healthActiveEnergy);
    };
    
    [healthStore executeQuery:query];
}




@end
