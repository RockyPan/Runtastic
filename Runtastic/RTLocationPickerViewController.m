//
//  RTLocationPickerViewController.m
//  Runtastic
//
//  Created by PanKyle on 14-6-17.
//  Copyright (c) 2014年 PanKyle. All rights reserved.
//

#import "RTLocationPickerViewController.h"
#import <CoreData/CoreData.h>

@interface RTLocationPickerViewController ()

@property (nonatomic, strong) NSArray * locations;

@end

@implementation RTLocationPickerViewController

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
    self.picker.dataSource = self;
    self.picker.delegate = self;
    
    // Do any additional setup after loading the view.
    self.locations = [[NSArray alloc] initWithObjects:@"梅林一村小操场", @"大沙河公园", @"深大操场", @"深圳湾绿道", nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)done:(id)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addNewLocation:(id)sender {
    //PK to-do
    NSManagedObjectContext * context = nil;
    
    NSManagedObject * location = nil;
    location = [NSEntityDescription insertNewObjectForEntityForName:@"Location" inManagedObjectContext:context];
    [location setValue:self.textNewLocation.text forKey:@"location"];
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

#pragma mark - Picker View

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.locations count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.locations[row];
}

@end
