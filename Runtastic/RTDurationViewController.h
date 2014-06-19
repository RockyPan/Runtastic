//
//  RTDurationViewController.h
//  Runtastic
//
//  Created by PanKyle on 14-6-19.
//  Copyright (c) 2014年 PanKyle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTAddActivityDelegate.h"

@interface RTDurationViewController : UIViewController

@property (nonatomic, weak) id<RTAddActivityDelegate> delegate;
@property (nonatomic, strong) NSDate * duration;

@property (weak, nonatomic) IBOutlet UIDatePicker *picker;

- (IBAction)done:(id)sender;

@end
