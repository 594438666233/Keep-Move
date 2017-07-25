//
//  FileHelper.h
//  Move
//
//  Created by 舒鑫 on 2016/11/5.
//  Copyright © 2016年 舒鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileHelper : NSObject

+ (NSString *)filePathWithName:(NSString *)name;

+ (NSMutableArray *)recordsArray;

+ (BOOL)deleteFile:(NSString *)filename;

@end
