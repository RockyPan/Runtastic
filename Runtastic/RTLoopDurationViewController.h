//
//  RTLoopDurationViewController.h
//  Runtastic
//
//  Created by PanKyle on 14-6-25.
//  Copyright (c) 2014年 PanKyle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTLoopDurationViewController : UITableViewController

@property (nonatomic, weak) id delegate;
//@property (nonatomic, strong) NSNumber * duration;

@property (weak, nonatomic) IBOutlet UITextField *textMinutes;
@property (weak, nonatomic) IBOutlet UITextField *textSeconds;

- (IBAction)done:(id)sender;

@end
