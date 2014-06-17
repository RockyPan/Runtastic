//
//  RTPickDateViewController.h
//  Runtastic
//
//  Created by PanKyle on 14-6-16.
//  Copyright (c) 2014年 PanKyle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTAddActivityDelegate.h"

@interface RTPickDateViewController : UIViewController

@property (nonatomic, weak) id<RTAddActivityDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)done:(id)sender;

@end
