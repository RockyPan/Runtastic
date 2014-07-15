//
//  RTLoopTypeViewController.m
//  Runtastic
//
//  Created by PanKyle on 14-6-26.
//  Copyright (c) 2014年 PanKyle. All rights reserved.
//

#import "RTLoopTypeViewController.h"
#import "RTAppDelegate.h"

@interface RTLoopTypeViewController ()

@property NSMutableArray * types;

@end

@implementation RTLoopTypeViewController

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
    
    RTAppDelegate * appD = (RTAppDelegate *)[UIApplication sharedApplication].delegate;
    
    //PK 加载类型数据
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"LoopType" inManagedObjectContext:appD.managedObjectContext];
    [request setEntity:entity];
    NSError * error = nil;
    self.types = [[appD.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    
    //PK 没有类型数据，则自动创建
    if (0 == [self.types count]) {
        NSArray * typeNames = [NSArray arrayWithObjects:@"热身", @"正常", @"冷却", nil];
        for (NSString * value in typeNames) {
            NSManagedObject * type =
            [NSEntityDescription insertNewObjectForEntityForName:@"LoopType"
                                          inManagedObjectContext:appD.managedObjectContext];
            [type setValue:value forKey:@"name"];
            [appD saveContext];
            [self.types addObject:type];
        }
    }
 }

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.types count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellType" forIndexPath:indexPath];
    cell.textLabel.text = [self.types[indexPath.row] valueForKey:@"name"];
    NSManagedObject * type = (NSManagedObject *)[self.delegate valueForKey:@"type"];
    if (type == self.types[indexPath.row]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    //self.type = self.types[indexPath.row];
    [self.delegate setValue:self.types[indexPath.row] forKey:@"type"];
    [self.navigationController popViewControllerAnimated:YES];
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

@end
