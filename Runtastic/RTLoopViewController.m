//
//  RTLoopViewController.m
//  Runtastic
//
//  Created by PanKyle on 14-6-24.
//  Copyright (c) 2014年 PanKyle. All rights reserved.
//

#import "RTLoopViewController.h"
#import "RTFormater.h"

@interface RTLoopViewController ()

@end

@implementation RTLoopViewController

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
    
    self.loops = [[NSMutableArray alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

- (NSString *)loopInfo:(NSManagedObject *) loop {
    NSString * info = nil;
    NSNumber * loopNo = [loop valueForKey:@"loopNo"];
    NSNumber * distance = [loop valueForKey:@"distance"];
    NSNumber * duration = [loop valueForKey:@"duration"];
    NSManagedObject * typeObj = [loop valueForKey:@"type"];
    NSString * type = [typeObj valueForKey:@"name"];
    info = [NSString stringWithFormat:@"分段%2d %@ 距离：%@ 用时：%@", [loopNo integerValue], type, [RTFormater stringWithDistance:distance], [RTFormater stringWithDuration:duration]];
    
    return info;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.loops count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellInfo" forIndexPath:indexPath];
    cell.textLabel.text = [self loopInfo:self.loops[indexPath.row]];
    return cell;
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


#pragma mark - Navigation

//PK add loop
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    id addLoopVC = segue.destinationViewController;
    [addLoopVC setValue:self forKey:@"delegate"];
    [addLoopVC setValue:[NSNumber numberWithInt:[self.loops count] + 1] forKeyPath:@"loopNo"];
    
    
    
}


@end
