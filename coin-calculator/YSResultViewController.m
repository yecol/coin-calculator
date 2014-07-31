//
//  YSResultViewController.m
//  coin-calculator
//
//  Created by Yecol Hsu on 2/24/14.
//  Copyright (c) 2014 Yecol Studio. All rights reserved.
//

#import "YSResultViewController.h"



@interface YSResultViewController ()

@end

@implementation YSResultViewController
@synthesize againBtn;

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.

  [[self.containerView layer]
      setBorderColor:[[UIColor colorWithRed:222.0 / 256
                                      green:222.0 / 256
                                       blue:222.0 / 256
                                      alpha:1] CGColor]];

  [[self.containerView layer] setBorderWidth:1.0];

  // Set btn display
  [[self.againBtn layer] setCornerRadius:5.0];
  [[self.againBtn layer] setBorderColor:[[UIColor colorWithRed:31.0 / 256
                                                         green:174.0 / 256
                                                          blue:82.0 / 256
                                                         alpha:1] CGColor]];
  [[self.againBtn layer] setBorderWidth:1.0];

  [self.bankerLabel setFont:[UIFont fontWithName:@"FZQKBYSJW--GB1-0" size:24]];
  [self.otherLabel setFont:[UIFont fontWithName:@"FZQKBYSJW--GB1-0" size:24]];

  [self.titleLabel setFont:[UIFont fontWithName:@"FZQKBYSJW--GB1-0" size:34]];

  [self.bankerCountLabel
      setText:[NSString stringWithFormat:@"%d", self.bankerCount]];
  [self.otherCountLabel
      setText:[NSString stringWithFormat:@"%d", self.otherCount]];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (IBAction)againBtnPressed {
  NSLog(@"againBtnPressed");
}

@end
