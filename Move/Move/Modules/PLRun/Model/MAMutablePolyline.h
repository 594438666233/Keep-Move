//
//  MAMutablePolyline.h
//  Move
//
//  Created by 舒鑫 on 2016/11/5.
//  Copyright © 2016年 舒鑫. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAOverlay.h>

@interface MAMutablePolyline : NSObject<MAOverlay>

/* save MAMapPoints by NSValue */
@property (nonatomic, strong) NSMutableArray *pointArray;

- (instancetype)initWithPoints:(NSArray *)nsvaluePoints;

- (MAMapRect)showRect;

- (MAMapPoint)mapPointForPointAt:(NSUInteger)index;

- (void)updatePoints:(NSArray *)points;

- (void)appendPoint:(MAMapPoint)point;

@end
