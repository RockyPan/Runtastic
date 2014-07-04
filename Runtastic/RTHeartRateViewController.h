//
//  RTHeartRateViewController.h
//  Runtastic
//
//  Created by PanKyle on 14-7-4.
//  Copyright (c) 2014年 PanKyle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTHeartRateViewController : UITableViewController

@property (nonatomic, retain) NSNumber * heartRate;

@property (weak, nonatomic) IBOutlet UITextField *textHeartRate;

- (IBAction)done:(id)sender;

@end
