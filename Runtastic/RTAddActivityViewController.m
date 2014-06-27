//
//  RTAddActivityViewController.m
//  Runtastic
//
//  Created by PanKyle on 14-6-16.
//  Copyright (c) 2014年 PanKyle. All rights reserved.
//

#import "RTAddActivityViewController.h"
#import "RTAppDelegate.h"
#import "RTFormater.h"

@interface RTAddActivityViewController ()

@property (nonatomic, weak) RTAppDelegate * appDelegate;

@property (nonatomic, strong) NSDate * actDate;
@property (nonatomic, assign) float distance;
@property (nonatomic, strong) NSDate * duration;
@property (nonatomic, retain) NSManagedObject * location;
@property (nonatomic, retain) NSManagedObject * type;
@property (nonatomic, retain) NSArray * loops;
@property (nonatomic, strong) NSString * log;

@end

@implementation RTAddActivityViewController

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
    
    self.actDate = [[NSDate alloc] init];
    self.distance = 0.0;
    self.duration = [self startDate];
    self.loops = [[NSMutableArray alloc] init];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.labelDate.text = [self formatDate:self.actDate];
    self.labelDistance.text = [NSString stringWithFormat:@"%.2f公里", self.distance];
    self.labelDuration.text = [self formatDuration:self.duration];
    if (nil != self.location) {
        self.labelLocation.text = [self.location valueForKey:@"location"];
    }
    self.labelLoopInfo.text = [self loopInfo:self.loops];
}

- (NSString *)loopInfo:(NSArray *)loops {
    NSString * res = nil;
    NSInteger count = [loops count];
    NSInteger distance = 0;
    NSInteger duration = 0;
    for (NSManagedObject * obj in loops) {
        distance += ((NSNumber *)[obj valueForKey:@"distance"]).integerValue;
        duration += ((NSNumber *)[obj valueForKey:@"duration"]).integerValue;
    }
    res = [NSString stringWithFormat:@"共%d个分段，%@，%@", count, [RTFormater stringWithDistance:[NSNumber numberWithInteger:distance]], [RTFormater stringWithDuration:[NSNumber numberWithInteger:duration]]];
    return res;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    id vc = segue.destinationViewController;
    [vc setValue:self forKey:@"delegate"];

    if ([segue.identifier isEqualToString:@"segueDate"]) {
        [vc setValue:self.actDate forKey:@"actDate"];
    }
    if ([segue.identifier isEqualToString:@"segueDistance"]) {
        [vc setValue:[NSNumber numberWithFloat:(self.distance)]
              forKey:@"distance"];
    }
    if ([segue.identifier isEqualToString:@"segueDuration"]) {
        [vc setValue:self.duration forKey:@"duration"];
    }
    if ([segue.identifier isEqualToString:@"segueLocation"]) {
        [vc setValue:self.location forKey:@"selectedItem"];
        [vc setValue:@"Location" forKey:@"entityName"];
        [vc setValue:@"location" forKey:@"attributeName"];
        [vc setValue:@"地点" forKey:@"caption"];
        [vc setValue:@"setLocationValue:" forKey:@"callBackName"];
    }
    if ([segue.identifier isEqualToString:@"segueType"]) {
        [vc setValue:self.type forKey:@"selectedItem"];
        [vc setValue:@"Type" forKey:@"entityName"];
        [vc setValue:@"typeName" forKey:@"attributeName"];
        [vc setValue:@"类型" forKey:@"caption"];
        [vc setValue:@"setTypeValue:" forKey:@"callBackName"];
    }
    if ([segue.identifier isEqualToString:@"segueLoops"]) {
        [vc setValue:self.loops forKey:@"loops"];
    }
    if ([segue.identifier isEqualToString:@"segueLog"]) {
        [vc setValue:self.log forKey:@"log"];
    }
}

- (IBAction)doneAddActivity:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSString *)formatDate:(NSDate *)date {
    NSString * res = nil;
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy年MM月dd日HH时mm分"];
    res = [df stringFromDate:date];
    return res;
}

- (NSString *)formatDuration:(NSDate *)duration {
    NSString * res = nil;
    
    NSTimeInterval du = [duration timeIntervalSinceDate:[self startDate]];
    NSInteger min = du / 60;
    //if (0 == min) return res;
    if (min < 60) {
        res = [[NSString alloc] initWithFormat:@"%d分钟", min];
    } else {
        res = [[NSString alloc] initWithFormat:@"%d小时%d分钟", min/60, min%60];
    }
    return res;
}

- (NSDate *)startDate {
    //PK 减去时差确保时间是0点
    return [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:-[[NSTimeZone systemTimeZone] secondsFromGMT]];
}

#pragma mark - Add Activity Delegate

- (void)setDateValue:(NSDate *)date {
    self.actDate = date;
}

- (void)setDistanceValue:(float)distance {
    self.distance = distance;
}

- (void)setDurationValue:(NSDate *)duration {
    self.duration = duration;
}

- (void)setLocationValue:(NSManagedObject *) location {
//    NSError * err = [[NSError alloc] init];
//    NSManagedObject * location = [self.appDelegate.managedObjectContext existingObjectWithID:objID error:&err];
    self.location = location;
    self.labelLocation.text = [location valueForKey:@"location"];
}

- (void)setTypeValue:(NSManagedObject *)type {
    self.type = type;
    self.labelType.text = [type valueForKey:@"typeName"];
}

#pragma mark - Table view data source
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}
*/
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
