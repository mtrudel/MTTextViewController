//
//  MTTextViewController.m
//
//  Created by Mat Trudel on 2/21/13.
//  Copyright (c) 2013 Mat Trudel. All rights reserved.
//

#import "MTTextViewController.h"

@interface MTTextViewController () <UITextViewDelegate>
@property UITextView *textView;
@end

@implementation MTTextViewController

- (instancetype)initWithText:(NSString *)text {
  if (self = [super initWithNibName:nil bundle:nil]) {
    self.textView = [[UITextView alloc] initWithFrame:CGRectZero];
    self.textView.text = text;
    self.textView.font = [UIFont systemFontOfSize:14.];
    self.textView.delegate = self;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
  }
  return self;
}

#pragma mark - Lifecycle methods

- (void)loadView {
  self.view = self.textView;
}

#pragma mark - View appearance methods and attendant keyboard handlers

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.textView becomeFirstResponder];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWasShown:)
                                               name:UIKeyboardDidShowNotification object:nil];

  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWillBeHidden:)
                                               name:UIKeyboardWillHideNotification object:nil];

}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)keyboardWasShown:(NSNotification*)aNotification {
  NSDictionary *info = [aNotification userInfo];
  CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;

  UIEdgeInsets contentInsets = self.textView.contentInset;
  contentInsets.bottom = kbSize.height + 10.;
  self.textView.contentInset = contentInsets;
  self.textView.scrollIndicatorInsets = contentInsets;
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification {
  UIEdgeInsets contentInsets = self.textView.contentInset;
  contentInsets.bottom = 0;
  self.textView.contentInset = contentInsets;
  self.textView.scrollIndicatorInsets = contentInsets;
}

#pragma mark - Action handlers

- (IBAction)cancel:(id)sender {
  [self.textView resignFirstResponder];
  [self.delegate textViewControllerDidCancel:self];
}

- (IBAction)done:(id)sender {
  [self.textView resignFirstResponder];
  [self.delegate textViewControllerDidFinish:self];
}

#pragma mark - Delegate methods

- (void)textViewDidChange:(UITextView *)textView
{
  if (self.characterLimit > 0 && textView.text.length > self.characterLimit) {
    NSMutableAttributedString *mas = [[NSMutableAttributedString alloc] initWithString:textView.text];
    [mas setAttributes:@{NSBackgroundColorAttributeName: [UIColor colorWithRed:0.969 green:0.922 blue:0.665 alpha:1.000]} range:NSMakeRange(self.characterLimit, mas.length - self.characterLimit)];
    textView.attributedText = mas;
  }
  self.navigationItem.rightBarButtonItem.enabled = textView.text.length > 0 && (self.characterLimit <= 0 || textView.text.length <= self.characterLimit);
}

#pragma mark - Public API

- (NSString *)text {
  return self.textView.text;
}

@end