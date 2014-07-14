//
//  RTDistanceViewController.m
//  Runtastic
//
//  Created by PanKyle on 14-6-18.
//  Copyright (c) 2014年 PanKyle. All rights reserved.
//

#import "RTDistanceViewController.h"

@interface RTDistanceViewController ()

@end

@implementation RTDistanceViewController

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
    
    [self.navigationItem setHidesBackButton:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    if (0.0 != [self.distance floatValue]) {
        self.textDistance.text = [[NSString alloc] initWithFormat:@"%.2f", [self.distance floatValue]];
    }
}

- (IBAction)done:(id)sender {
    float distance = [self.textDistance.text floatValue];
    if (0.0 == distance) {
        //PK to-do warming info
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入有效的距离数据。" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alert show];        
        return;
    }
    
    [self.delegate setDistanceValue:distance];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
