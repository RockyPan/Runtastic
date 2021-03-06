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
        NSManagedObject * selectedItem = [self.delegate valueForKey:self.setKey];
        if ((nil == selectedItem && 0 == indexPath.row) ||
            (selectedItem == self.items[indexPath.row])) {
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

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) return nil;
    
    NSIndexPath * selected = [self.tableView indexPathForSelectedRow];
    if (indexPath.row != selected.row) {
        UITableViewCell * preCell = [tableView cellForRowAtIndexPath:selected];
        preCell.accessoryType = UITableViewCellAccessoryNone;
    }
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.view endEditing:YES];
    
    UITableViewCell * curCell = [tableView cellForRowAtIndexPath:indexPath];
    curCell.accessoryType = UITableViewCellAccessoryCheckmark;
}

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
    [self.delegate setValue:newItem forKey:self.setKey];
    //PK 这个调用确保之前的选中被取消，因为在DataSource的cellForRow方法中选中行不会触发dataDelegate中的方法。
    NSIndexPath * index = [NSIndexPath indexPathForRow:100 inSection:1];
    [self tableView:self.tableView willSelectRowAtIndexPath:index];
    
    [self.tableView reloadData];
}

- (IBAction)done:(id)sender {
    if (0 == [self.items count]) {
        NSString * msg = [NSString stringWithFormat:@"请先创建一个有效的%@。", self.caption];
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    NSInteger row = [self.tableView indexPathForSelectedRow].row;
    [self.delegate setValue:self.items[row] forKey:self.setKey];

    [self.navigationController popViewControllerAnimated:YES];
}
@end
