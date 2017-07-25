//
//  Record.h
//  Move
//
//  Created by 舒鑫 on 2016/11/5.
//  Copyright © 2016年 舒鑫. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;

@interface Record : NSObject

- (NSString *)title;

- (NSString *)subTitle;

- (void)addLocation:(CLLocation *)location;

- (NSInteger)numOfLocations;

- (CLLocation *)startLocation;

- (CLLocation *)endLocation;

- (CLLocationCoordinate2D *)coordinates;

- (CLLocationDistance)totalDistance;

- (NSTimeInterval)totalDuration;

@end
