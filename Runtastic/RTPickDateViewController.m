//
//  RTPickDateViewController.m
//  Runtastic
//
//  Created by PanKyle on 14-6-16.
//  Copyright (c) 2014年 PanKyle. All rights reserved.
//

#import "RTPickDateViewController.h"

@interface RTPickDateViewController ()

@end

@implementation RTPickDateViewController

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    id vc = segue.destinationViewController;
    [vc setValue:self.datePicker.date forKey:@"date"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)done:(id)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
