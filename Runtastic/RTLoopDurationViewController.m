//
//  RTLoopDurationViewController.m
//  Runtastic
//
//  Created by PanKyle on 14-6-25.
//  Copyright (c) 2014年 PanKyle. All rights reserved.
//

#import "RTLoopDurationViewController.h"

@interface RTLoopDurationViewController ()

@end

@implementation RTLoopDurationViewController

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
    NSInteger du = ((NSNumber *)[self.delegate valueForKey:@"duration"]).integerValue;
    if (0 != du) {
        NSInteger m = du / 60;
        NSInteger s = du % 60;
        self.textMinutes.text = [NSString stringWithFormat:@"%ld", m];
        self.textSeconds.text = [NSString stringWithFormat:@"%ld", s];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)done:(id)sender {
    int m = self.textMinutes.text.intValue;
    int s = self.textSeconds.text.intValue;
    if (s > 59) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"秒数应该小于60，请修改后重新确认。" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    [self.delegate setValue:[NSNumber numberWithInt:(m*60+s)] forKey:@"duration"];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
