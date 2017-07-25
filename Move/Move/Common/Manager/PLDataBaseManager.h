//
//  PLDataBaseManager.h
//  Move
//
//  Created by 舒鑫 on 16/10/20.
//  Copyright © 2016年 舒鑫. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PLPersonInformation;

@class PLHistoryInformation, PLPersonInformation;

@interface PLDataBaseManager : NSObject

+ (PLDataBaseManager *)shareManager;

- (BOOL)createPersonTable;



- (BOOL)insertHistoryRecord:(PLHistoryInformation *)history;


- (CGFloat)currentWeight;

- (NSArray *)ArrayWithRecordWeight;

- (BOOL)clearRecord;

- (BOOL)insertPerson:(PLPersonInformation *)person;

- (BOOL)updatePerson:(PLPersonInformation *)person;

- (PLPersonInformation *)personInformation;

- (CGFloat)goalWeight;
@end
