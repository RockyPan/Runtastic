//
//  RTTemperatureViewController.m
//  Runtastic
//
//  Created by PanKyle on 14-7-21.
//  Copyright (c) 2014年 PanKyle. All rights reserved.
//

#import "RTTemperatureViewController.h"

@interface RTTemperatureViewController ()

@end

@implementation RTTemperatureViewController

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
    [self.navigationItem setHidesBackButton:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    NSNumber * temp = [self.delegate valueForKey:@"temperature"];
    if (0 != [temp integerValue]) {
        self.textTemp.text = [NSString stringWithFormat:@"%ld", (long)[temp integerValue]];
    }
}

- (IBAction)done:(id)sender {
    [self.delegate setValue:[NSNumber numberWithInteger:[self.textTemp.text integerValue]] forKey:@"temperature"];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
