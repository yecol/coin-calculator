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

const CGRect kSmallFlip = { 0, 0, 32.0, 42.0 };
const float kOffsetX = 36.0;

@interface YSMainViewController (){
    NSArray *imagesArray;
    CGRect currentDraggingViewFrame;
}

@property (strong, nonatomic) NSArray *evaluateViews;

@end

@implementation YSMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSArray *viewsOfInterest = @[self.upboard, self.downboard];
    [self setEvaluateViews:viewsOfInterest];
    
    imagesArray = @[@"soft",@"good",@"hard"];
    
    NSLog(@"new view");
    
    self.countArray = [NSMutableArray array];
    self.downArray = [NSMutableArray array];
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
    
    if ([[segue identifier] isEqualToString:@"showResult"]) {
        YSResultViewController *vc = (YSResultViewController*)[segue destinationViewController];
        
        //compute score;
        int bankerScore = 0;
        int i = 0;
        
        for(;i<self.countArray.count;i++){
            NSLog(@"i=%d",i);
            int sig = 0;
            if ([[self.countArray objectAtIndex:i] isEqualToString:@"soft"]) {
                sig = 1;
            }
            else if ([[self.countArray objectAtIndex:i] isEqualToString:@"hard"]) {
                sig = 2;
            }
            else if ([[self.countArray objectAtIndex:i] isEqualToString:@"good"]) {
                sig = 4;
            }
            bankerScore += i*sig+(sig*2);
        }
        
        int otherScore = 0;
        int sig = 0;
        if ([[self.downArray objectAtIndex:0] isEqualToString:@"soft"]) {
            sig = 1;
        }
        else if ([[self.downArray objectAtIndex:0] isEqualToString:@"hard"]) {
            sig = 2;
        }
        else if ([[self.downArray objectAtIndex:0] isEqualToString:@"good"]) {
            sig = 4;
        }
        otherScore = i*sig+(sig*2);
        
        
        
        [vc setBankerCount:bankerScore];
        [vc setOtherCount:otherScore];
    }
}

- (IBAction)handlePanRecognizer:(id)sender
{
    
    UIPanGestureRecognizer *recongizer = (UIPanGestureRecognizer *)sender;
    
    if ([recongizer state] == UIGestureRecognizerStateBegan)
    {
        currentDraggingViewFrame = [[sender view] frame];
    }
    
    NSArray *views = [self evaluateViews];
    
    
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
                
                [[sender view] tag];
                
                if ([aView isEqual:self.upboard]&&![[sender view] isHidden]) {
                    
                    [[sender view] setHidden:YES];
                    CGRect frameRect = kSmallFlip;
                    frameRect.origin.x = [self.countArray count]*kOffsetX;
                    UIView *newFlip = [[UIView alloc] initWithFrame:frameRect];
                    
                    NSString *imageName = [NSString stringWithFormat:@"card%@_s.png",[imagesArray objectAtIndex:[[sender view] tag]]];
                    UIImageView *newImageView = [[UIImageView alloc] initWithFrame:kSmallFlip];
                    [newImageView setImage:[UIImage imageNamed:imageName]];
        
                    [newFlip addSubview:newImageView];
                    [self.upboard addSubview:newFlip];
                    
                    [self.countArray addObject:[imagesArray objectAtIndex:[[sender view] tag]]];
                }
                
                else if ([aView isEqual:self.downboard]&&![[sender view] isHidden]) {
                    
                    [[sender view] setHidden:YES];
                    CGRect frameRect = kSmallFlip;
                    frameRect.origin.x = (self.downboard.frame.size.width - kSmallFlip.size.width)/2;
                    frameRect.origin.y = (self.downboard.frame.size.height - kSmallFlip.size.height)/2;
                    UIView *newFlip = [[UIView alloc] initWithFrame:frameRect];
                    
                    NSString *imageName = [NSString stringWithFormat:@"card%@_s.png",[imagesArray objectAtIndex:[[sender view] tag]]];
                    UIImageView *newImageView = [[UIImageView alloc] initWithFrame:kSmallFlip];
                    [newImageView setImage:[UIImage imageNamed:imageName]];
                    
                    [newFlip addSubview:newImageView];
                    [self.downboard addSubview:newFlip];
                    
                    [self.downArray removeAllObjects];
                    [self.downArray addObject:[imagesArray objectAtIndex:[[sender view] tag]]];
                }
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
            NSString *completionText = [NSString stringWithFormat:@"Released over view at index: %lu", (unsigned long)overlapIndex];
//            [label setText:completionText];
            NSLog(@"%@",completionText);
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


@end
