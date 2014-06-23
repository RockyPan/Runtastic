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

@property (nonatomic, strong) NSArray * items;
@property (nonatomic, weak) RTAppDelegate * appDelegate;

@end

@implementation RTLocationViewController

- (void)getItems {
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    NSEntityDescription * entity = [NSEntityDescription entityForName:self.entityName inManagedObjectContext:self.appDelegate.managedObjectContext];
    [request setEntity:entity];
    NSError * error = nil;
    self.items = [[self.appDelegate.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
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
    [self getItems];
    
    [self.navigationItem setHidesBackButton:YES];
    self.navigationItem.title = self.caption;
    
}

- (UITextField *)getTextNew {
    UITableViewCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UITextField * text = (UITextField *)[cell viewWithTag:102];
    return text;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (0 == section) return 1;
    else return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = nil;
    
    if (0 == indexPath.section) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cellAddNew"];
        UITextField * text = (UITextField *)[cell viewWithTag:102];
        text.placeholder = [NSString stringWithFormat:@"输入新增%@", self.caption];
    }
    
    if (1 == indexPath.section) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cellItem"];
        cell.textLabel.text = [self.items[indexPath.row] valueForKey:self.attributeName];
        if (self.selectedItem == self.items[indexPath.row]) {
            [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString * res = nil;
    if (0 == section) {
        res = [NSString stringWithFormat:@"添加一个新%@：", self.caption];
    } else {
        res = [NSString stringWithFormat:@"选择%@：", self.caption];
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

- (IBAction)addNew:(id)sender {
    UITextField * text = [self getTextNew];
    NSString * location = text.text;
    text.text = @"";
    
    NSManagedObjectContext * context = self.appDelegate.managedObjectContext;
    NSManagedObject * newItem = [NSEntityDescription insertNewObjectForEntityForName:self.entityName inManagedObjectContext:context];
    [newItem setValue:location forKey:self.attributeName];
    [self.appDelegate saveContext];
    [self getItems];
    
    //PK 表格重载时确保新加地点被选中
    self.selectedItem = newItem;
    
    [self.tableView reloadData];
}

- (IBAction)done:(id)sender {
    NSInteger row = [self.tableView indexPathForSelectedRow].row;
    //[self.delegate setLocationValue:self.items[row]];
    SEL callBack = NSSelectorFromString(self.callBackName);
    [self.delegate performSelector:callBack withObject:self.items[row]];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
