//
//  YSFlipsideViewController.h
//  coin-calculator
//
//  Created by Yecol Hsu on 2/24/14.
//  Copyright (c) 2014 Yecol Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YSFlipsideViewController;

@protocol YSFlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(YSFlipsideViewController *)controller;
@end

@interface YSFlipsideViewController : UIViewController

@property (weak, nonatomic) id <YSFlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
