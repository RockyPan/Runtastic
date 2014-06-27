//
//  RTLoopDistanceViewController.m
//  Runtastic
//
//  Created by PanKyle on 14-6-26.
//  Copyright (c) 2014年 PanKyle. All rights reserved.
//

#import "RTLoopDistanceViewController.h"

@interface RTLoopDistanceViewController ()

@end

@implementation RTLoopDistanceViewController

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
    [super viewWillAppear:animated];
    
    NSInteger di = self.distance.integerValue;
    NSInteger km = di / 1000;
    NSInteger me = di % 1000;
    if (km > 0) {
        self.textKM.text = [NSString stringWithFormat:@"%d", km];
    }
    if (me > 0) {
        self.textMeter.text = [NSString stringWithFormat:@"%d", me];
    }
}

- (IBAction)done:(id)sender {
    NSInteger km = self.textKM.text.integerValue;
    NSInteger me = self.textMeter.text.integerValue;
    if (me > 999) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"米数应该小于1000，请修改后重新确认。" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    [self.delegate setValue:[NSNumber numberWithInt:(km*1000+me)] forKey:@"distance"];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
