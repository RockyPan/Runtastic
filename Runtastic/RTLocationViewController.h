//
//  RTLocationViewController.h
//  Runtastic
//
//  Created by PanKyle on 14-6-19.
//  Copyright (c) 2014年 PanKyle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTAddActivityDelegate.h"


@interface RTLocationViewController : UITableViewController

@property (nonatomic, weak) id<RTAddActivityDelegate> delegate;
@property (nonatomic, retain) NSManagedObject * location;

- (IBAction)addNewLocation:(id)sender;
- (IBAction)done:(id)sender;

@end
