//
//  RTFormater.h
//  Runtastic
//
//  Created by PanKyle on 14-6-26.
//  Copyright (c) 2014年 PanKyle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTFormater : NSObject

+ (NSString *) stringWithDistance:(NSNumber *)distance;
+ (NSString *) stringWithDuration:(NSNumber *)duration;

@end
