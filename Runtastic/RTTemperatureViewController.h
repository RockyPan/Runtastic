//
//  RTTemperatureViewController.h
//  Runtastic
//
//  Created by PanKyle on 14-7-21.
//  Copyright (c) 2014年 PanKyle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTTemperatureViewController : UITableViewController

@property (nonatomic, weak) id delegate;
@property (weak, nonatomic) IBOutlet UITextField *textTemp;

- (IBAction)done:(id)sender;

@end
