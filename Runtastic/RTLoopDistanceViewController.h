//
//  RTLoopDistanceViewController.h
//  Runtastic
//
//  Created by PanKyle on 14-6-26.
//  Copyright (c) 2014年 PanKyle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTLoopDistanceViewController : UITableViewController

@property (nonatomic, weak) id delegate;
//@property (nonatomic, strong) NSNumber * distance;

@property (weak, nonatomic) IBOutlet UITextField *textKM;
@property (weak, nonatomic) IBOutlet UITextField *textMeter;

- (IBAction)done:(id)sender;
@end
