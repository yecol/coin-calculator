//
//  YSResultViewController.m
//  coin-calculator
//
//  Created by Yecol Hsu on 2/24/14.
//  Copyright (c) 2014 Yecol Studio. All rights reserved.
//

#import "YSResultViewController.h"

@interface YSResultViewController ()
- (void)displayTextWithBanker:(int)bc other:(int)oc;

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
  [[self.againBtn layer] setBorderWidth:1.0];
  [[self.againBtn layer] setCornerRadius:5.0];
  [[self.againBtn layer] setBorderColor:[[UIColor colorWithRed:31.0 / 256
                                                         green:174.0 / 256
                                                          blue:82.0 / 256
                                                         alpha:1] CGColor]];
  [[self.shareBtn layer] setBorderWidth:1.0];

  [[self.shareBtn layer] setCornerRadius:5.0];
  [[self.shareBtn layer] setBorderColor:[[UIColor colorWithRed:31.0 / 256
                                                         green:174.0 / 256
                                                          blue:82.0 / 256
                                                         alpha:1] CGColor]];
  [[self.infoBtn layer] setBorderWidth:1.0];

  [[self.infoBtn layer] setCornerRadius:5.0];
  [[self.infoBtn layer] setBorderColor:[[UIColor colorWithRed:31.0 / 256
                                                        green:174.0 / 256
                                                         blue:82.0 / 256
                                                        alpha:1] CGColor]];

  [self.bankerLabel setFont:[UIFont fontWithName:@"FZQKBYSJW--GB1-0" size:24]];
  [self.otherLabel setFont:[UIFont fontWithName:@"FZQKBYSJW--GB1-0" size:24]];
  [self.titleLabel setFont:[UIFont fontWithName:@"FZQKBYSJW--GB1-0" size:34]];
  [self.same1Label setFont:[UIFont fontWithName:@"FZQKBYSJW--GB1-0" size:24]];
  [self.same2Label setFont:[UIFont fontWithName:@"FZQKBYSJW--GB1-0" size:24]];
  [self.same3Label setFont:[UIFont fontWithName:@"FZQKBYSJW--GB1-0" size:24]];
  [self.giveup1Label setFont:[UIFont fontWithName:@"FZQKBYSJW--GB1-0" size:24]];
  [self.giveup2Label setFont:[UIFont fontWithName:@"FZQKBYSJW--GB1-0" size:24]];
  [self.giveup3Label setFont:[UIFont fontWithName:@"FZQKBYSJW--GB1-0" size:24]];

  [self displayTextWithBanker:self.bankerCount other:self.otherCount];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)displayTextWithBanker:(int)bc other:(int)oc {

  if (bc == 2 && oc == 3) {
    [self.titleLabel setText:@"家家叁"];
    [self.sameView setHidden:NO];
    [self.sameCountLabel setText:@"3"];
  } else if (bc == 4 && oc == 6) {
    [self.titleLabel setText:@"家家陆"];
    [self.sameView setHidden:NO];
    [self.sameCountLabel setText:@"6"];
  } else if(bc==4 && oc==12){
      [self.titleLabel setText:@"刨光了头"];
      [self.giveupView setHidden:NO];
      [self.giveupCountLabel setText:@"6"];
  }
  else if(bc==2 && oc==6){
      [self.titleLabel setText:@"剃光头"];
      [self.giveupView setHidden:NO];
      [self.giveupCountLabel setText:@"3"];
  }
 else {
    [self.bankerCountLabel
        setText:[NSString stringWithFormat:@"%d", self.bankerCount]];
    [self.otherCountLabel
        setText:[NSString stringWithFormat:@"%d", self.otherCount - self.bankerCount]];
  }
}

- (IBAction)againBtnPressed {
  NSLog(@"againBtnPressed");
}

@end
