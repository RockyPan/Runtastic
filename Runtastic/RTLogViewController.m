//
//  RTLogViewController.m
//  Runtastic
//
//  Created by PanKyle on 14-6-27.
//  Copyright (c) 2014年 PanKyle. All rights reserved.
//

#import "RTLogViewController.h"

@interface RTLogViewController ()

@end

@implementation RTLogViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationItem setHidesBackButton:YES];
    self.textLog.text = self.log;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardNotification:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)handleKeyboardNotification:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    UIViewAnimationCurve animationCurve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue];
    
    // Transform the UIViewAnimationCurve to a UIViewAnimationOptions mask.
    UIViewAnimationOptions animationOptions = UIViewAnimationOptionBeginFromCurrentState;
    if (animationCurve == UIViewAnimationCurveEaseIn) {
        animationOptions |= UIViewAnimationOptionCurveEaseIn;
    }
    else if (animationCurve == UIViewAnimationCurveEaseInOut) {
        animationOptions |= UIViewAnimationOptionCurveEaseInOut;
    }
    else if (animationCurve == UIViewAnimationCurveEaseOut) {
        animationOptions |= UIViewAnimationOptionCurveEaseOut;
    }
    else if (animationCurve == UIViewAnimationCurveLinear) {
        animationOptions |= UIViewAnimationOptionCurveLinear;
    }
    
    NSTimeInterval animationDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // Convert the keyboard frame from screen to view coordinates.
    CGRect keyboardScreenEndFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect keyboardScreenBeginFrame = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    
    CGRect keyboardViewEndFrame = [self.view convertRect:keyboardScreenEndFrame fromView:self.view.window];
    CGRect keyboardViewBeginFrame = [self.view convertRect:keyboardScreenBeginFrame fromView:self.view.window];
    CGFloat originDelta = keyboardViewEndFrame.origin.y - keyboardViewBeginFrame.origin.y;
    
    // The text view should be adjusted, update the constant for this constraint.
    self.textViewBottomLayoutGuideConstraint.constant -= originDelta;
    
    [self.view setNeedsUpdateConstraints];
    
    [UIView animateWithDuration:animationDuration delay:0 options:animationOptions animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
    
    // Scroll to the selected text once the keyboard frame changes.
    NSRange selectedRange = self.textLog.selectedRange;
    [self.textLog scrollRangeToVisible:selectedRange];
}

- (IBAction)done:(id)sender {
    [self.log setString:self.textLog.text];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITextViewDelegate

- (void)adjustTextViewSelection:(UITextView *)textView {
    // Ensure that the text view is visible by making the text view frame smaller as text can be slightly cropped at the bottom.
    // Note that this is a workwaround to a bug in iOS.
    [textView layoutIfNeeded];
    
    CGRect caretRect = [textView caretRectForPosition:textView.selectedTextRange.end];
    caretRect.size.height += textView.textContainerInset.bottom;
    [textView scrollRectToVisible:caretRect animated:NO];
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    [self adjustTextViewSelection:textView];
}

- (void)textViewDidChangeSelection:(UITextView *)textView {
    [self adjustTextViewSelection:textView];
}


@end
