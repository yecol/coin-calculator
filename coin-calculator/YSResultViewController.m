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
	// Do any additional setup after loading the view.
    [self.bankerLabel setText:[NSString stringWithFormat:@"庄家收 %d 分",self.bankerCount]];
    [self.otherLabel setText:[NSString stringWithFormat:@"对家收 %d 分",self.otherCount]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)againBtnPressed{
    NSLog(@"againBtnPressed");
}

@end
