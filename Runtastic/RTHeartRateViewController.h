//
//  RTHeartRateViewController.h
//  Runtastic
//
//  Created by PanKyle on 14-7-4.
//  Copyright (c) 2014年 PanKyle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTMutableValue.h"

@interface RTHeartRateViewController : UITableViewController

@property (nonatomic, retain) RTMutableValue * heartRate;
@property (weak, nonatomic) id delegate;
@property (weak, nonatomic) IBOutlet UITextField *textHeartRate;

- (IBAction)done:(id)sender;

@end
