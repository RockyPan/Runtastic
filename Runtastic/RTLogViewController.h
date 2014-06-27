//
//  RTLogViewController.h
//  Runtastic
//
//  Created by PanKyle on 14-6-27.
//  Copyright (c) 2014年 PanKyle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTLogViewController : UIViewController

@property (nonatomic, weak) id delegate;
@property (nonatomic, strong) NSString * log;

@property (weak, nonatomic) IBOutlet UITextView *textLog;

- (IBAction)done:(id)sender;

@end
