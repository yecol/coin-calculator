//
//  YSMainViewController.m
//  coin-calculator
//
//  Created by Yecol Hsu on 2/24/14.
//  Copyright (c) 2014 Yecol Studio. All rights reserved.
//

#import "YSMainViewController.h"
#import "UIGestureRecognizer+DraggingAdditions.h"

@interface YSMainViewController ()

@property (strong, nonatomic) NSArray *evaluateViews;

@end

@implementation YSMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSArray *viewsOfInterest = @[self.upboard, self.downboard];
    [self setEvaluateViews:viewsOfInterest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(YSFlipsideViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
    }
}

- (IBAction)handlePanRecognizer:(id)sender
{
    UIPanGestureRecognizer *recongizer = (UIPanGestureRecognizer *)sender;
    
    if ([recongizer state] == UIGestureRecognizerStateBegan)
    {
        NSLog(@"yecol-begin");
    }
    
    NSArray *views = [self evaluateViews];
//    __block UILabel *label = [self completionLabel];
    
    // Block to execute when our dragged view is contained by one of our evaluation views.
    static void (^overlappingBlock)(UIView *overlappingView);
    overlappingBlock = ^(UIView *overlappingView) {
        
        [views enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            UIView *aView = (UIView *)obj;
            
            // Style an overlapping view
            if (aView == overlappingView)
            {
                aView.layer.borderWidth = 8.0f;
                aView.layer.borderColor = [[UIColor redColor] CGColor];
            }
            // Remove styling on non-overlapping views
            else
            {
                aView.layer.borderWidth = 0.0f;
            }
        }];
    };
    
    // Block to execute when gesture ends.
    static void (^completionBlock)(UIView *overlappingView);
    completionBlock = ^(UIView *overlappingView) {
        
        if (overlappingView)
        {
            NSUInteger overlapIndex = [[self evaluateViews] indexOfObject:overlappingView];
            NSString *completionText = [NSString stringWithFormat:@"Released over view at index: %d", overlapIndex];
//            [label setText:completionText];
            NSLog(@"%@",completionText);
        }
        
        // Remove styling from all views
        [views enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            UIView *aView = (UIView *)obj;
            aView.layer.borderWidth = 0.0f;
        }];
    };
    
    [recongizer dragViewWithinView:[self view]
           evaluateViewsForOverlap:views
   containedByOverlappingViewBlock:overlappingBlock
                        completion:completionBlock];
    
}


@end
