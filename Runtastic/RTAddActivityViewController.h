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
@property (nonatomic, assign) float distance;
@property (weak, nonatomic) IBOutlet UILabel *labelDate;
@property (weak, nonatomic) IBOutlet UILabel *labelDistance;
@property (weak, nonatomic) IBOutlet UILabel *labelDuration;
@property (weak, nonatomic) IBOutlet UILabel *labelLocation;
@property (weak, nonatomic) IBOutlet UILabel *labelType;
@property (weak, nonatomic) IBOutlet UILabel *labelLoopInfo;

- (IBAction)doneAddActivity:(id)sender;

@end
