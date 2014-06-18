//
//  RTAddActivityDelegate.h
//  Runtastic
//
//  Created by PanKyle on 14-6-17.
//  Copyright (c) 2014年 PanKyle. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RTAddActivityDelegate <NSObject>

@optional

- (void) setDate:(NSDate *)date;
- (void) setDistance:(float)distance;

@end
