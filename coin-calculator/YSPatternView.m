//
//  YSPatternView.m
//  coin-calculator
//
//  Created by Yecol Hsu on 7/31/14.
//  Copyright (c) 2014 Yecol Studio. All rights reserved.
//

#import "YSPatternView.h"

@implementation YSPatternView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    UIImage *bgImg = [UIImage imageNamed:@"settings-bg.jpg"];
    NSLog(@"hello");
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextSetBlendMode(c, kCGBlendModeCopy);
    CGContextDrawTiledImage(c, CGRectMake(0, 0, bgImg.size.width, bgImg.size.height), bgImg.CGImage);
}


@end
