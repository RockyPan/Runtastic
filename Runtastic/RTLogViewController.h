//
//  RTLogViewController.h
//  Runtastic
//
//  Created by PanKyle on 14-6-27.
//  Copyright (c) 2014年 PanKyle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTLogViewController : UIViewController <UITextViewDelegate>

@property (nonatomic, weak) id delegate;
@property (nonatomic, strong) NSMutableString * log;

@property (weak, nonatomic) IBOutlet UITextView *textLog;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewBottomLayoutGuideConstraint;

- (IBAction)done:(id)sender;

@end
