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
    NSNumber * distance = (NSNumber *)[self.delegate valueForKey:@"distance"];
    if (0 != [distance integerValue]) {
        self.textDistance.text = [[NSString alloc] initWithFormat:@"%.2f", [distance integerValue] / 1000.0f];
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
    
    [self.delegate setValue:[NSNumber numberWithInteger:distance * 1000] forKeyPath:@"distance"];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
