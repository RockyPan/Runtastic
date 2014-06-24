//
//  RTAddLoopViewController.h
//  Runtastic
//
//  Created by PanKyle on 14-6-24.
//  Copyright (c) 2014年 PanKyle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTAddLoopViewController : UITableViewController

@property (nonatomic, weak) id delegate;

- (IBAction)done:(id)sender;

@end
