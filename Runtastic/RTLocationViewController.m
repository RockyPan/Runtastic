//
//  RTLocationViewController.m
//  Runtastic
//
//  Created by PanKyle on 14-6-19.
//  Copyright (c) 2014年 PanKyle. All rights reserved.
//

#import "RTLocationViewController.h"
#import <CoreData/CoreData.h>
#import "RTAppDelegate.h"

@interface RTLocationViewController ()

@property (nonatomic, strong) NSArray * locations;
@property (nonatomic, weak) RTAppDelegate * appDelegate;

@end

@implementation RTLocationViewController

- (void)getLocations {
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"Location" inManagedObjectContext:self.appDelegate.managedObjectContext];
    [request setEntity:entity];
    NSError * error = nil;
    self.locations = [[self.appDelegate.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
}

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
    
    self.appDelegate = (RTAppDelegate *)[UIApplication sharedApplication].delegate;
    [self getLocations];
    
    [self.navigationItem setHidesBackButton:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (0 == section) return 1;
    else return [self.locations count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = nil;
    
    if (0 == indexPath.section) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cellAddNew"];
    }
    
    if (1 == indexPath.section) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cellLocation"];
        cell.textLabel.text = [self.locations[indexPath.row] valueForKey:@"location"];
        if (self.location == self.locations[indexPath.row]) {
            [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString * res = nil;
    if (0 == section) {
        res = @"添加一个新地点：";
    } else {
        res = @"选择地点：";
    }
   return res;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];
    
    if (0 == indexPath.section) {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        return;
    }
    
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addNewLocation:(id)sender {
    UITableViewCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UITextField * text = (UITextField *)[cell viewWithTag:102];
    NSString * location = text.text;
    text.text = @"";
    
    NSManagedObjectContext * context = self.appDelegate.managedObjectContext;
    NSManagedObject * newLocation = [NSEntityDescription insertNewObjectForEntityForName:@"Location" inManagedObjectContext:context];
    [newLocation setValue:location forKey:@"location"];
    [self.appDelegate saveContext];
    [self getLocations];
    
    [self.tableView reloadData];
}

- (IBAction)done:(id)sender {
    NSInteger row = [self.tableView indexPathForSelectedRow].row;
    //NSManagedObjectID * obj = [self.locations[row] objectID];
    [self.delegate setLocationValue:self.locations[row]];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
