//
//  YSResultViewController.h
//  coin-calculator
//
//  Created by Yecol Hsu on 2/24/14.
//  Copyright (c) 2014 Yecol Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSResultViewController : UIViewController

@property(assign,nonatomic) int bankerCount;
@property(assign,nonatomic) int otherCount;

@property(assign,nonatomic)IBOutlet UILabel *bankerLabel;
@property(assign,nonatomic)IBOutlet UILabel *otherLabel;
@property(assign,nonatomic)IBOutlet UILabel *bankerCountLabel;
@property(assign,nonatomic)IBOutlet UILabel *otherCountLabel;
@property(assign,nonatomic)IBOutlet UILabel *titleLabel;

@property(assign,nonatomic) IBOutlet UIButton *againBtn;
@property(assign,nonatomic) IBOutlet UIView *containerView;

-(IBAction)againBtnPressed;

@end
