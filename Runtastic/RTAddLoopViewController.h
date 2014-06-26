//
//  RTAddLoopViewController.h
//  Runtastic
//
//  Created by PanKyle on 14-6-24.
//  Copyright (c) 2014年 PanKyle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface RTAddLoopViewController : UITableViewController

@property (nonatomic, weak) id delegate;
@property (nonatomic, strong) NSNumber * loopNo;
@property (nonatomic, strong) NSNumber * duration; //PK 秒
@property (nonatomic, strong) NSNumber * distance; //PK 米
@property (nonatomic, strong) NSManagedObject * type;

@property (weak, nonatomic) IBOutlet UILabel *lableType;
@property (weak, nonatomic) IBOutlet UILabel *lableDuration;
@property (weak, nonatomic) IBOutlet UILabel *labelDistance;
@property (weak, nonatomic) IBOutlet UILabel *lableNo;

- (IBAction)done:(id)sender;

@end
