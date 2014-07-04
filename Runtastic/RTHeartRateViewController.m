//
//  RTHeartRateViewController.m
//  Runtastic
//
//  Created by PanKyle on 14-7-4.
//  Copyright (c) 2014年 PanKyle. All rights reserved.
//

#import "RTHeartRateViewController.h"

@interface RTHeartRateViewController ()

@end

@implementation RTHeartRateViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    if (0 != [self.heartRate integerValue]) {
        self.textHeartRate.text = [NSString stringWithFormat:@"%@", self.heartRate];
    }
}

- (IBAction)done:(id)sender {
    self.heartRate
}

@end
