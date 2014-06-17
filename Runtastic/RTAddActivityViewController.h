//
//  RTAddActivityViewController.h
//  Runtastic
//
//  Created by PanKyle on 14-6-16.
//  Copyright (c) 2014年 PanKyle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTAddActivityDelegate.h"

@interface RTAddActivityViewController : UITableViewController <RTAddActivityDelegate>

@property (nonatomic, strong) NSDate * actDate;

- (IBAction)done:(id)sender;

@end
