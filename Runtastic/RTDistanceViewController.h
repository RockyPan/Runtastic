//
//  RTDistanceViewController.h
//  Runtastic
//
//  Created by PanKyle on 14-6-18.
//  Copyright (c) 2014年 PanKyle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTAddActivityDelegate.h"

@interface RTDistanceViewController : UITableViewController

@property (nonatomic, weak) id<RTAddActivityDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *textDistance;

- (IBAction)done:(id)sender;

@end
