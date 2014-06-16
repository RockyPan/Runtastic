//
//  RTPickDateViewController.h
//  Runtastic
//
//  Created by PanKyle on 14-6-16.
//  Copyright (c) 2014年 PanKyle. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RTPickDateDelegate <NSObject>

- (void)setDate:(NSDate *)date;

@end

@interface RTPickDateViewController : UIViewController

@property (nonatomic, weak) id<RTPickDateDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)done:(id)sender;

@end
