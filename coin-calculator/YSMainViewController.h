//
//  YSMainViewController.h
//  coin-calculator
//
//  Created by Yecol Hsu on 2/24/14.
//  Copyright (c) 2014 Yecol Studio. All rights reserved.
//

#import "YSFlipsideViewController.h"

@interface YSMainViewController : UIViewController <YSFlipsideViewControllerDelegate>

@property(assign,nonatomic) IBOutlet UIView *cardsoft;
@property(assign,nonatomic) IBOutlet UIView *cardhard;
@property(assign,nonatomic) IBOutlet UIView *cardgood;

@property(assign,nonatomic) IBOutlet UIView *upboard;
@property(assign,nonatomic) IBOutlet UIView *downboard;

@property(strong,nonatomic) NSMutableArray *countArray;
@property(strong,nonatomic) NSMutableArray *downArray;


@property (nonatomic, strong) IBOutlet UIPanGestureRecognizer *panRecognizersoft;
@property (nonatomic, strong) IBOutlet UIPanGestureRecognizer *panRecognizerhard;
@property (nonatomic, strong) IBOutlet UIPanGestureRecognizer *panRecognizergood;

- (IBAction)handlePanRecognizer:(id)sender;

@end
