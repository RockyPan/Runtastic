//
//  RTLocationPickerViewController.m
//  Runtastic
//
//  Created by PanKyle on 14-6-17.
//  Copyright (c) 2014年 PanKyle. All rights reserved.
//

#import "RTLocationPickerViewController.h"
#import <CoreData/CoreData.h>
#import "RTAppDelegate.h"

@interface RTLocationPickerViewController ()

@property (nonatomic, strong) NSArray * locations;
@property (nonatomic, weak) RTAppDelegate * appDelegate;
@end

@implementation RTLocationPickerViewController

- (void)getLocations {
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"Location" inManagedObjectContext:self.appDelegate.managedObjectContext];
    [request setEntity:entity];
    NSError * error = nil;
    self.locations = [[self.appDelegate.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
}

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
    self.textNewLocation.delegate = self;
    self.appDelegate = (RTAppDelegate *)[UIApplication sharedApplication].delegate;
 
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getLocations];
}

//PK 触摸屏幕时结束编辑，收回软键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
    NSManagedObjectContext * context = self.appDelegate.managedObjectContext;
    
    NSManagedObject * location = [NSEntityDescription insertNewObjectForEntityForName:@"Location" inManagedObjectContext:context];
    [location setValue:self.textNewLocation.text forKey:@"location"];
    [self.appDelegate saveContext];
    [self getLocations];
    [self.picker reloadAllComponents];
    self.textNewLocation.text = @"";
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
    return [self.locations[row] valueForKey:@"location"];
}

#pragma mark - textfield

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    CGPoint center = self.view.center;
    center.y -= 100;
    self.view.center = center;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    CGPoint center = self.view.center;
    center.y += 100;
    self.view.center = center;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    [self addNewLocation:nil];
    return YES;
}
@end
