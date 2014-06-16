//
//  RTAddActivityViewController.h
//  Runtastic
//
//  Created by PanKyle on 14-6-16.
//  Copyright (c) 2014年 PanKyle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTPickDateViewController.h"

@interface RTAddActivityViewController : UITableViewController <RTPickDateDelegate>

@property (nonatomic, strong) NSDate * actDate;

@end
