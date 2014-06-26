//
//  RTFormater.m
//  Runtastic
//
//  Created by PanKyle on 14-6-26.
//  Copyright (c) 2014年 PanKyle. All rights reserved.
//

#import "RTFormater.h"

@implementation RTFormater

+ (NSString *) stringWithDistance:(NSNumber *)distance{
    
    NSString * res = nil;
    NSInteger di = distance.integerValue;
    if (di >= 1000) {
        if (0 == di % 1000) {
            res = [NSString stringWithFormat:@"%d公里", di / 1000];
        } else {
            res = [NSString stringWithFormat:@"%d公里%d米", di / 1000, di % 1000];
        }
    } else {
        res = [NSString stringWithFormat:@"%d米", di];
    }
    return res;
}

+ (NSString *) stringWithDuration:(NSNumber *)duration {
    NSString * res = nil;
    NSInteger du = duration.integerValue;
    NSInteger m = du / 60;
    NSInteger s = du % 60;
    res = [NSString stringWithFormat:@"%d分%d秒", m, s];
    return res;
}

@end
