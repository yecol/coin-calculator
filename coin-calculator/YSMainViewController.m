//
//  YSMainViewController.m
//  coin-calculator
//
//  Created by Yecol Hsu on 2/24/14.
//  Copyright (c) 2014 Yecol Studio. All rights reserved.
//

#import "YSMainViewController.h"
#import "YSResultViewController.h"
#import "UIGestureRecognizer+DraggingAdditions.h"

const CGRect kSmallFlip = {0, 0, 32.0, 42.0};
const float kOffsetX = 36.0;
const float kOffsetY = 46.0;
const float kCornor = 5.0;

@interface YSMainViewController () {
  NSArray *imagesArray;
  CGRect currentDraggingViewFrame;
}

@property(strong, nonatomic) NSArray *evaluateViews;
- (void)showWarningAlert:(NSString *)info;

@end

@implementation YSMainViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  LBorderView *upborderView =
      [[LBorderView alloc] initWithFrame:CGRectMake(0, 0, 280, 130)];
  upborderView.cornerRadius = kCornor;
  upborderView.borderType = BorderTypeDashed;
  upborderView.borderWidth = 2;
  upborderView.backgroundColor = [UIColor clearColor];
  upborderView.borderColor = [UIColor colorWithWhite:1.0 alpha:0.6];
  upborderView.dashPattern = 8;
  upborderView.spacePattern = 4;
  self.upboardBorderView = upborderView;
  [self.upboard addSubview:upborderView];

  LBorderView *downborderView =
      [[LBorderView alloc] initWithFrame:CGRectMake(0, 0, 160, 130)];
  downborderView.cornerRadius = kCornor;
  downborderView.borderType = BorderTypeDashed;
  downborderView.borderWidth = 2;
  downborderView.backgroundColor = [UIColor clearColor];
  downborderView.borderColor = [UIColor colorWithWhite:1.0 alpha:0.6];
  downborderView.dashPattern = 8;
  downborderView.spacePattern = 4;
  self.downboardBorderView = downborderView;
  [self.downboard addSubview:downborderView];

  // Set btn display
  [[self.btn layer] setCornerRadius:kCornor];
  [[self.btn layer] setBackgroundColor:[[UIColor clearColor] CGColor]];
  [[self.btn layer] setBorderColor:[[UIColor whiteColor] CGColor]];
  [[self.btn layer] setBorderWidth:1.0];

  // Do any additional setup after loading the view, typically from a nib.
  NSArray *viewsOfInterest = @[ self.upboard, self.downboard ];
  [self setEvaluateViews:viewsOfInterest];

  imagesArray = @[ @"soft", @"good", @"hard" ];

  NSLog(@"new view");

  self.countArray = [NSMutableArray array];
  self.downArray = [NSMutableArray array];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(YSFlipsideViewController *)controller {
  [self dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    if ([self.countArray count] == 0 || [self.downArray count] == 0) {
        [self showWarningAlert:@"请先拖动计分卡到相应位置"];
        return false;
    }
    else return true;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([[segue identifier] isEqualToString:@"showAlternate"]) {
    [[segue destinationViewController] setDelegate:self];
  }

  if ([[segue identifier] isEqualToString:@"showResult"]) {

    YSResultViewController *vc =
        (YSResultViewController *)[segue destinationViewController];

    // compute score;
    int bankerScore = 0;
    int i = 0;

    for (; i < self.countArray.count; i++) {
      NSLog(@"i=%d", i);
      int sig = 0;
      if ([[self.countArray objectAtIndex:i] isEqualToString:@"soft"]) {
        sig = 1;
      } else if ([[self.countArray objectAtIndex:i] isEqualToString:@"hard"]) {
        sig = 2;
      } else if ([[self.countArray objectAtIndex:i] isEqualToString:@"good"]) {
        sig = 4;
      }
      bankerScore += i * sig + (sig * 2);
    }

    int otherScore = 0;
    int sig = 0;
    if ([[self.downArray objectAtIndex:0] isEqualToString:@"soft"]) {
      sig = 1;
    } else if ([[self.downArray objectAtIndex:0] isEqualToString:@"hard"]) {
      sig = 2;
    } else if ([[self.downArray objectAtIndex:0] isEqualToString:@"good"]) {
      sig = 4;
    }
    otherScore = i * sig + (sig * 2);

    [vc setBankerCount:bankerScore];
    [vc setOtherCount:otherScore];
  }
}

- (IBAction)handlePanRecognizer:(id)sender {

  UIPanGestureRecognizer *recongizer = (UIPanGestureRecognizer *)sender;

  [[[sender view] superview] bringSubviewToFront:[sender view]];

  if ([recongizer state] == UIGestureRecognizerStateBegan) {
    currentDraggingViewFrame = [[sender view] frame];
  }

  NSArray *views = [self evaluateViews];

  // Block to execute when our dragged view is contained by one of our
  // evaluation views.
  static void (^overlappingBlock)(UIView * overlappingView);
  overlappingBlock = ^(UIView *overlappingView) {

    [views enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {

        UIView *aView = (UIView *)obj;

        // Style an overlapping view
        if (aView == overlappingView) {

          [[[aView subviews] objectAtIndex:0] setHidden:YES];

          [[sender view] tag];

          if ([aView isEqual:self.upboard] && ![[sender view] isHidden]) {

            if ([self.countArray count] > 9) {
              [self showWarningAlert:@"最多支持计算连庄十次"];
              [[sender view] setHidden:YES];
              return;
            }

            [[sender view] setHidden:YES];
            CGRect frameRect = kSmallFlip;
            frameRect.origin.x = ([self.countArray count] % 5) * kOffsetX + 50;
            frameRect.origin.y = ([self.countArray count] / 5) * kOffsetY + 20;
            UIView *newFlip = [[UIView alloc] initWithFrame:frameRect];

            NSString *imageName = [NSString
                stringWithFormat:@"card%@_s.png",
                                 [imagesArray
                                     objectAtIndex:[[sender view] tag]]];
            UIImageView *newImageView =
                [[UIImageView alloc] initWithFrame:kSmallFlip];
            [newImageView setImage:[UIImage imageNamed:imageName]];

            [newFlip addSubview:newImageView];
            [self.upboard addSubview:newFlip];

            [self.countArray
                addObject:[imagesArray objectAtIndex:[[sender view] tag]]];
          } else if ([aView isEqual:self.downboard] &&
                     ![[sender view] isHidden]) {

            [[sender view] setHidden:YES];
            CGRect frameRect = kSmallFlip;
            frameRect.origin.x =
                (self.downboard.frame.size.width - kSmallFlip.size.width) / 2;
            frameRect.origin.y =
                (self.downboard.frame.size.height - kSmallFlip.size.height) / 2;
            UIView *newFlip = [[UIView alloc] initWithFrame:frameRect];

            NSString *imageName = [NSString
                stringWithFormat:@"card%@_s.png",
                                 [imagesArray
                                     objectAtIndex:[[sender view] tag]]];
            UIImageView *newImageView =
                [[UIImageView alloc] initWithFrame:kSmallFlip];
            [newImageView setImage:[UIImage imageNamed:imageName]];

            [newFlip addSubview:newImageView];
            [self.downboard addSubview:newFlip];

            [self.downArray removeAllObjects];
            [self.downArray
                addObject:[imagesArray objectAtIndex:[[sender view] tag]]];
          }
        }
        // Remove styling on non-overlapping views
        else {
        }
    }];
  };

  // Block to execute when gesture ends.
  static void (^completionBlock)(UIView * overlappingView);
  completionBlock = ^(UIView *overlappingView) {

    if (overlappingView) {
      NSUInteger overlapIndex =
          [[self evaluateViews] indexOfObject:overlappingView];
      NSString *completionText =
          [NSString stringWithFormat:@"Released over view at index: %lu",
                                     (unsigned long)overlapIndex];
      //            [label setText:completionText];
      NSLog(@"%@", completionText);
    }

    // Remove styling from all views
    [views enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIView *aView = (UIView *)obj;
        aView.layer.borderWidth = 0.0f;
    }];

    [[sender view] setFrame:currentDraggingViewFrame];
    [[sender view] setHidden:NO];
  };

  [recongizer dragViewWithinView:[self view]
              evaluateViewsForOverlap:views
      containedByOverlappingViewBlock:overlappingBlock
                           completion:completionBlock];
}

- (void)reset:(id)sender {
  [self.countArray removeAllObjects];
  [self.downArray removeAllObjects];

  for (UIView *v in [self.upboard subviews]) {
    if (!([v isKindOfClass:[LBorderView class]] ||
          [v isKindOfClass:[UILabel class]])) {
      [v removeFromSuperview];
    } else if ([v isKindOfClass:[UILabel class]]) {
      [v setHidden:NO];
    }
  }

  for (UIView *v in [self.downboard subviews]) {
    NSLog(@"down %@", [v class]);
    if (!([v isKindOfClass:[LBorderView class]] ||
          [v isKindOfClass:[UILabel class]])) {
      [v removeFromSuperview];
    } else if ([v isKindOfClass:[UILabel class]]) {
      [v setHidden:NO];
    }
  }
}

- (void)showWarningAlert:(NSString *)info {
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息"
                                                  message:info
                                                 delegate:self
                                        cancelButtonTitle:@"我知道了"
                                        otherButtonTitles:nil];
  [alert show];
}

@end
