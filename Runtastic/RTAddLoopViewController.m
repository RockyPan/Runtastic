//
//  RTAddLoopViewController.m
//  Runtastic
//
//  Created by PanKyle on 14-6-24.
//  Copyright (c) 2014年 PanKyle. All rights reserved.
//

#import "RTAddLoopViewController.h"
#import "RTAppDelegate.h"
#import "RTFormater.h"

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
    self.lableDuration.text = [RTFormater stringWithDuration:self.duration];
    self.labelDistance.text = [RTFormater stringWithDistance:self.distance];
    self.lableType.text = [self.type valueForKey:@"name"];    
}

#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    id destinationVC = [segue destinationViewController];
    [destinationVC setValue:self forKey:@"delegate"];
    
    if ([segue.identifier isEqualToString:@"segueLoopDuration"]) {
        [destinationVC setValue:self.duration forKey:@"duration"];
    }
    if ([segue.identifier isEqualToString:@"segueLoopDistance"]) {
        [destinationVC setValue:self.distance forKey:@"distance"];
    }
    if ([segue.identifier isEqualToString:@"segueLoopType"]) {
        [destinationVC setValue:self.type forKey:@"type"];
    }
    
}


- (IBAction)done:(id)sender {
    //PK to-do 检查数据合法性
    
    RTAppDelegate * appD = (RTAppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext * context = appD.managedObjectContext;
    NSManagedObject * loop = [NSEntityDescription insertNewObjectForEntityForName:@"Loop" inManagedObjectContext:context];
    [loop setValue:self.distance forKeyPath:@"distance"];
    [loop setValue:self.duration forKeyPath:@"duration"];
    [loop setValue:self.loopNo forKeyPath:@"loopNo"];
    [loop setValue:self.type forKeyPath:@"type"];
    [appD saveContext];
    
    NSMutableArray * loops = (NSMutableArray *)[self.delegate valueForKey:@"loops"];
    [loops addObject:loop];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
