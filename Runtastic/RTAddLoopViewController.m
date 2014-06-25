//
//  RTAddLoopViewController.m
//  Runtastic
//
//  Created by PanKyle on 14-6-24.
//  Copyright (c) 2014年 PanKyle. All rights reserved.
//

#import "RTAddLoopViewController.h"

@interface RTAddLoopViewController ()

@end

@implementation RTAddLoopViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.duration = [NSNumber numberWithInt:0];
    self.distance = [NSNumber numberWithInt:1000];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.lableNo.text = self.loopNo.stringValue;
    
    NSInteger du = self.duration.integerValue;
    NSInteger m = du / 60;
    NSInteger s = du % 60;
    NSString * duS = [NSString stringWithFormat:@"%d分%d秒", m, s];
    self.lableDuration.text = duS;
    
    NSInteger di = self.distance.integerValue;
    NSString * diS = nil;
    if (di >= 1000) {
        if (0 == di % 1000) {
            diS = [NSString stringWithFormat:@"%d公里", di / 1000];
        } else {
            diS = [NSString stringWithFormat:@"%d公里%d米", di / 1000, di % 1000];
        }
    } else {
        diS = [NSString stringWithFormat:@"%d米", di];
    }
    self.labelDistance.text = diS;
    
}

#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    id destinationVC = [segue destinationViewController];
    [destinationVC setValue:self.duration forKey:@"duration"];
    
}


- (IBAction)done:(id)sender {
}
@end
