//
//  YSMainViewController.h
//  coin-calculator
//
//  Created by Yecol Hsu on 2/24/14.
//  Copyright (c) 2014 Yecol Studio. All rights reserved.
//

#import "YSFlipsideViewController.h"

@interface YSMainViewController : UIViewController <YSFlipsideViewControllerDelegate>

@property(assign,nonatomic) IBOutlet UIImageView *cardsoft;
@property(assign,nonatomic) IBOutlet UIImageView *cardhard;
@property(assign,nonatomic) IBOutlet UIImageView *cardgood;

@property (nonatomic, strong) IBOutlet UIPanGestureRecognizer *panRecognizer;

- (IBAction)handlePanRecognizer:(id)sender;

@end
