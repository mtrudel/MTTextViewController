//
//  MTTextViewController.h
//
//  Created by Mat Trudel on 2/21/13.
//  Copyright (c) 2013 Mat Trudel. All rights reserved.
//

@import UIKit;

@class MTTextViewController;

@protocol MTTextViewControllerDelegate <NSObject>
- (void)textViewControllerDidFinish:(MTTextViewController *)controller;
- (void)textViewControllerDidCancel:(MTTextViewController *)controller;
@end

@interface MTTextViewController : UIViewController
@property(weak) id<MTTextViewControllerDelegate> delegate;
@property(readonly) NSString *text;
@property NSInteger characterLimit;

- (instancetype)initWithText:(NSString *)text;

@end