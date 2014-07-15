//
//  RTMutableValue.h
//  Runtastic
//
//  Created by PanKyle on 14-7-11.
//  Copyright (c) 2014年 PanKyle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface RTMutableValue : NSObject

@property (nonatomic, retain) NSNumber * valueNumber;
@property (nonatomic, retain) NSManagedObject * valueMrgObj;

@end
