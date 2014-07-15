//
//  RTDatePickerViewController.m
//  Runtastic
//
//  Created by PanKyle on 14-6-18.
//  Copyright (c) 2014年 PanKyle. All rights reserved.
//

#import "RTDatePickerViewController.h"

@interface RTDatePickerViewController ()

@end

@implementation RTDatePickerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationItem setHidesBackButton:YES];
    self.picker.date = [self.delegate valueForKey:@"actDate"];
}

- (IBAction)done:(id)sender {
    [self.delegate setValue:self.picker.date forKeyPath:@"actDate"];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
