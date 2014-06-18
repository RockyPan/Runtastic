//
//  RTDatePickerViewController.h
//  Runtastic
//
//  Created by PanKyle on 14-6-18.
//  Copyright (c) 2014年 PanKyle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTAddActivityDelegate.h"

@interface RTDatePickerViewController : UIViewController

@property (nonatomic, weak) id<RTAddActivityDelegate> delegate;
@property (nonatomic, strong) NSDate * actDate;
@property (weak, nonatomic) IBOutlet UIDatePicker *picker;

- (IBAction)done:(id)sender;

@end