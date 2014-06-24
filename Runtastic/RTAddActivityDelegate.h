//
//  RTAddActivityDelegate.h
//  Runtastic
//
//  Created by PanKyle on 14-6-17.
//  Copyright (c) 2014年 PanKyle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@protocol RTAddActivityDelegate <NSObject>

@optional

- (void) setDateValue:(NSDate *)date;
- (void) setDistanceValue:(float)distance;
- (void) setDurationValue:(NSDate *)duration;
- (void) setLocationValue:(NSManagedObject *)location;
- (void) setTypeValue:(NSManagedObject *)type;
- (void) setLoopsValue:(NSArray *) loops;

@end
