//
//  PLDataBaseManager.m
//  Move
//
//  Created by 胡梦龙 on 16/10/20.
//  Copyright © 2016年 PhelanGeek. All rights reserved.
//

#import "PLDataBaseManager.h"
#import "PLHistoryInformation.h"

#import "PLPersonInformation.h"
@interface PLDataBaseManager ()

@property (nonatomic, strong) FMDatabaseQueue *dbQueue;

@property (nonatomic, assign) BOOL flag1;
@property (nonatomic, assign) BOOL flag2;

@property (nonatomic, assign) CGFloat weight;
@property (nonatomic, copy) NSString *time;

@property (nonatomic, strong) NSMutableArray *historyArray;

@end

@implementation PLDataBaseManager
+ (PLDataBaseManager *)shareManager {
    static PLDataBaseManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[PLDataBaseManager alloc] init];
    }) ;
    
    return manager;

}

- (BOOL)createPersonTable {
    _flag1 = NO;
    _flag2 = NO;

    self.historyArray = [NSMutableArray array];
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *sqlFilePath = [path stringByAppendingPathComponent:@"move.sqlite"];
    
    
    self.dbQueue = [FMDatabaseQueue databaseQueueWithPath:sqlFilePath];
    

    
    [_dbQueue inDatabase:^(FMDatabase *db) {
        
        BOOL success = [db executeUpdate:@"create table if not exists Person (id integer primary key autoincrement, gender text , brithday integer , height real , goalweight real, goalstep real)"];
        
        if (success) {
            NSLog(@"创建表成功");
            _flag1 = YES;
        } else {
            NSLog(@"创建表失败");
        }
        
    }];
    
    [_dbQueue inDatabase:^(FMDatabase *db) {
        
        BOOL success = [db executeUpdate:@"create table if not exists Record (id integer primary key autoincrement, time text , weight real)"];
        
        if (success) {
            NSLog(@"创建表成功");
            _flag2 = YES;
        } else {
            NSLog(@"创建表失败");
        }
        
    }];
    
    if (_flag1 && _flag2) {
        return YES;
    }
    return NO;

}

- (BOOL)insertPerson:(PLPersonInformation *)person {
    _flag1 = NO;
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        
        BOOL success = [db executeUpdate:[NSString stringWithFormat:@"insert into Person values (null,'%@','%ld', '%f','%f','%f')", person.gender, person.brithday, person.height, person.goalWeight, person.goalStep]];
        
        if (success) {
            NSLog(@"插入成功");
            _flag1 = YES;
            
        } else {
            NSLog(@"插入失败");
        }
        
        
    }];
    return _flag1;
    
}

/*
 PLPersonInformation *person = [[PLPersonInformation alloc] init];
 person.gender = @"男";
 person.brithday = 1994;
 person.height = 1.53;
 person.goalWeight = 66.f;
 person.goalStep = 10000.f;
 
 [[PLDataBaseManager shareManager] insertPerson:person];
 */

- (BOOL)insertHistoryRecord:(PLHistoryInformation *)history {
    _flag1 = NO;
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        
        BOOL success = [db executeUpdate:[NSString stringWithFormat:@"insert into Record values (null,'%@','%f')",history.time, history.weight]];
        
        if (success) {
            NSLog(@"插入成功");
            _flag1 = YES;
            
        } else {
            NSLog(@"插入失败");
        }
        
        
    }];
    return _flag1;

}


- (CGFloat)currentWeight {

    
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *result = [db executeQuery:@"SELECT weight FROM Record"];
        self.weight = 0;
        while ([result next]) {
            
            self.weight = [result intForColumnIndex:0];
            
            
        }
    }];
    
    return _weight;

}


//CGFloat f = [[PLDataBaseManager shareManager] currentWeight];

- (NSArray *)ArrayWithRecordWeight {

    [self.dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *result = [db executeQuery:@"SELECT * FROM Record"];
        
        while ([result next]) {
            
            self.time = [result stringForColumnIndex:1];
            self.weight = [result doubleForColumnIndex:2];
            
            PLHistoryInformation *history = [[PLHistoryInformation alloc] init];
            history.time = _time;
            history.weight = _weight;
            [self.historyArray addObject:history];
        }
    }];
    
    return _historyArray;
}

//NSArray *array = [[PLDataBaseManager shareManager] ArrayWithRecordWeight];

- (BOOL)clearRecord {

    _flag1 = NO;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        
        BOOL success = [db executeUpdate:@"DELETE FROM Record"];
        
        if (success) {
            _flag1 = YES;
        } else {
            NSLog(@"失败");
        }
    }];

    return _flag1;
}

// BOOL flag = [[PLDataBaseManager shareManager] clearRecord];



@end
