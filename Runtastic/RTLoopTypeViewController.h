//
//  RTLoopTypeViewController.h
//  Runtastic
//
//  Created by PanKyle on 14-6-26.
//  Copyright (c) 2014年 PanKyle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface RTLoopTypeViewController : UITableViewController

@property (nonatomic, weak) id delegate;
@property (nonatomic, retain) NSManagedObject * type;   //PK 已选择的类型

@end
