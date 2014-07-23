//
//  RTAddActivityViewController.m
//  Runtastic
//
//  Created by PanKyle on 14-6-16.
//  Copyright (c) 2014年 PanKyle. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "RTAddActivityViewController.h"
#import "RTAppDelegate.h"
#import "RTFormater.h"

@interface RTAddActivityViewController ()

@property (nonatomic, weak) RTAppDelegate * appDelegate;

@property (nonatomic, strong) NSDate * actDate;
@property (nonatomic, strong) NSNumber * distance;
@property (nonatomic, strong) NSDate * duration;
@property (nonatomic, retain) NSManagedObject * location;
@property (nonatomic, retain) NSManagedObject * type;
@property (nonatomic, retain) NSArray * loops;
@property (nonatomic, strong) NSString * log;
@property (nonatomic, strong) NSNumber * heartRate;
@property (nonatomic, strong) NSNumber * temperature;
@property (nonatomic, strong) NSNumber * origin;

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
    self.appDelegate = (RTAppDelegate *)[UIApplication sharedApplication].delegate;
    self.actDate = [[NSDate alloc] init];
    self.distance = [[NSNumber alloc] init];
    self.duration = [self startDate];
    self.loops = [[NSMutableArray alloc] init];
    self.log = [[NSString alloc] init];
    self.heartRate = [[NSNumber alloc] init];
    self.temperature = [[NSNumber alloc] init];
    self.origin = [NSNumber numberWithInt:1];
    
    [self prepareActivityType];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.labelDate.text = [self formatDate:self.actDate];
    self.labelDistance.text = [NSString stringWithFormat:@"%.2f公里", self.distance.integerValue / 1000.0f];
    self.labelDuration.text = [self formatDuration:self.duration];
    self.labelLoopInfo.text = [self loopInfo:self.loops];
    self.labelLog.text = self.log;
    self.labelHR.text = [NSString stringWithFormat:@"%ld", (long)[self.heartRate integerValue]];
    if (nil != self.location) {
        self.labelLocation.text = [self.location valueForKey:self.appDelegate.TLocation[@"ALocation"]];
    }
    if (nil != self.type) {
        self.labelType.text = [self.type valueForKey:self.appDelegate.TActivityType[@"AName"]];
    }
    if (nil != self.temperature && 0 != self.temperature) {
        self.labelTemp.text = [NSString stringWithFormat:@"%ld摄氏度", [self.temperature integerValue]];
    }
}

- (void) prepareActivityType {
    //PK
    NSDictionary * tb = self.appDelegate.TActivityType;
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    NSEntityDescription * entity = [NSEntityDescription entityForName:tb[@"name"] inManagedObjectContext:self.appDelegate.managedObjectContext];
    [request setEntity:entity];
    NSError * error = nil;
    NSArray * items = [[self.appDelegate.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    NSMutableArray * types = [@[@"LSD", @"普通", @"赛事", @"间歇", @"tempo", @"越野"] mutableCopy];
    for (NSManagedObject * value in items) {
        NSString * tn = [value valueForKey:tb[@"AName"]];
        [types removeObject:tn];
    }
    if (0 != [types count]) {
        for (NSString * value in types) {
            NSManagedObject * tObj = [NSEntityDescription insertNewObjectForEntityForName:tb[@"name"]  inManagedObjectContext:self.appDelegate.managedObjectContext];
            [tObj setValue:value forKey:tb[@"AName"]];
        }
        [self.appDelegate saveContext];
    }
    for (NSManagedObject * value in items) {
        NSString * tn = [value valueForKey:tb[@"AName"]];
        if ([tn isEqualToString:@"普通"]) self.type = value;
    }
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
    res = [NSString stringWithFormat:@"共%ld个分段，%@，%@", count, [RTFormater stringWithDistance:[NSNumber numberWithInteger:distance]], [RTFormater stringWithDuration:[NSNumber numberWithInteger:duration]]];
    return res;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    id vc = segue.destinationViewController;
    [vc setValue:self forKey:@"delegate"];

    if ([segue.identifier isEqualToString:@"segueLocation"]) {
        NSDictionary * td = self.appDelegate.TLocation;
        [vc setValue:td[@"name"] forKey:@"entityName"];
        [vc setValue:td[@"ALocation"] forKey:@"attributeName"];
        [vc setValue:@"地点" forKey:@"caption"];
        [vc setValue:@"location" forKey:@"setKey"];
    }
    if ([segue.identifier isEqualToString:@"segueType"]) {
        NSDictionary * td = self.appDelegate.TActivityType;
        [vc setValue:td[@"name"] forKey:@"entityName"];
        [vc setValue:td[@"AName"] forKey:@"attributeName"];
        [vc setValue:@"类型" forKey:@"caption"];
        [vc setValue:@"type" forKey:@"setKey"];
    }
    if ([segue.identifier isEqualToString:@"segueLoops"]) {
        [vc setValue:self.loops forKey:@"loops"];
    }
}

- (NSInteger) getDurationSec {
    NSDate * start = [self startDate];
    NSInteger durationSec = (NSInteger)[self.duration timeIntervalSinceDate:start];
    return durationSec;
}

- (IBAction)doneAddActivity:(id)sender
{
    RTAppDelegate * appD = (RTAppDelegate *)[UIApplication sharedApplication].delegate;
    
    //PK 判断数据合法性
    BOOL valid = TRUE;
    BOOL warn = FALSE;
    NSString * promptValid = [[NSString alloc] init];
    NSString * promptWarn = [[NSString alloc] init];
    // 日期
    // 类型
    // 距离
    if (0 == [self.distance integerValue]) {
        valid = FALSE;
        promptValid = [NSString stringWithFormat:@"%@距离不能为零。", promptValid];
    }
    // 持续时间

    if (0 == [self getDurationSec]) {
        valid = FALSE;
        promptValid = [NSString stringWithFormat:@"%@持续时间不能为零。", promptValid];
    }
    // 平均心率
    if (0 == [self.heartRate integerValue]) {
        warn = TRUE;
        promptWarn = [NSString stringWithFormat:@"平均心率，%@", promptWarn];
    }
    // 日志
    if (0 == [self.log length]) {
        warn = TRUE;
        promptWarn = [NSString stringWithFormat:@"日志，%@", promptWarn];
    }
    // 温度
    if (0 == [self.temperature integerValue]) {
        warn = TRUE;
        promptWarn = [NSString stringWithFormat:@"温度，%@", promptWarn];
    }
    // 地点
    if (nil == self.location) {
        warn = TRUE;
        promptWarn = [NSString stringWithFormat:@"地点，%@", promptWarn];
    }
    // 分段
    if (nil == self.loops || 0 == [self.loops count]) {
        warn = TRUE;
        promptWarn = [NSString stringWithFormat:@"分段，%@", promptWarn];
    } else {
        int duration = 0;
        int distance = 0;
        NSDictionary * tbLoop = appD.TLoop;
        for (NSManagedObject * value in self.loops) {
            NSString * temp = nil;
            temp = [value valueForKey:tbLoop[@"ADuration"]];
            duration += temp.intValue;
            temp = [value valueForKey:tbLoop[@"ADistance"]];
            distance += temp.intValue;
        }
        if (duration > [self getDurationSec]) {
            valid = FALSE;
            promptValid = [NSString stringWithFormat:@"%@所有分段的持续时间之和不能大于活动的总时长。", promptValid];
        }
        if (distance > self.distance.intValue) {
            valid = FALSE;
            promptValid = [NSString stringWithFormat:@"%@所有分段的距离之和不能大于活动的总距离。", promptValid];
        }
    }
    
    if (!valid) {
        NSString * msg = [NSString stringWithFormat:@"数据有误。%@请重新修改数据。", promptValid];
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"数据有误" message:msg delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    if (warn) {
        NSString * msg = [NSString stringWithFormat:@"下列数据：%@不完整。是否继续添加本次活动数据？或修改后再添加。", promptWarn];
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"数据不完整" message:msg delegate:self cancelButtonTitle:@"继续添加" otherButtonTitles:@"修改数据", nil];
        [alert show];
        return;
    }
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (0 == buttonIndex) {
        [self saveActivity];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void) saveActivity {
    RTAppDelegate * appD = (RTAppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary * tb = appD.TActivity;
    NSManagedObjectContext * context = appD.managedObjectContext;
    NSManagedObject * activity = [NSEntityDescription insertNewObjectForEntityForName:tb[@"name"] inManagedObjectContext:context];
    [activity setValue:self.actDate forKey:tb[@"ADateTime"]];
    [activity setValue:self.distance forKey:tb[@"ADistance"]];
    [activity setValue:[NSNumber numberWithInteger:[self getDurationSec]] forKey:tb[@"ADuration"]];
    [activity setValue:self.heartRate forKey:tb[@"AHeartRate"]];
    [activity setValue:self.log forKey:tb[@"ALog"]];
    [activity setValue:self.origin forKey:tb[@"AOrigin"]];
    [activity setValue:self.temperature forKey:tb[@"ATemperature"]];
    [activity setValue:self.location forKey:tb[@"RLocation"]];
    if (0 != [self.loops count]) [activity setValue:self.loops forKey:tb[@"RLoops"]];
    [activity setValue:self.type forKey:tb[@"RActivityType"]];
    [appD saveContext];
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
    int min = du / 60;
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

//- (void)setLocationValue:(NSManagedObject *) location {
//    self.location = location;
//    self.labelLocation.text = [location valueForKey:@"location"];
//}
//
//- (void)setTypeValue:(NSManagedObject *)type {
//    self.type = type;
//    self.labelType.text = [type valueForKey:@"typeName"];
//}

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
