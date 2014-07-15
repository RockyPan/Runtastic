//
//  RTDurationViewController.m
//  Runtastic
//
//  Created by PanKyle on 14-6-19.
//  Copyright (c) 2014年 PanKyle. All rights reserved.
//

#import "RTDurationViewController.h"

@interface RTDurationViewController ()

@end

@implementation RTDurationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.navigationItem setHidesBackButton:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    self.picker.date = [self.delegate valueForKey:@"duration"];
}


- (IBAction)done:(id)sender {
    [self.delegate setValue:self.picker.date forKeyPath:@"duration"];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
