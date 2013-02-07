//
//  ShadowRoundView.m
//  Sandbox
//
//  Created by Daniel Green on 13/12/2012.
//  Copyright (c) 2012 Daniel Green. All rights reserved.
//

#import "ShadowRoundView.h"
#import <QuartzCore/QuartzCore.h>

@implementation ShadowRoundView



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [self shadow];
}

- (void)shadow {
    UIView *v = self;
    //[v.layer setCornerRadius:30.0f];
    [v.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    //[v.layer setBorderWidth:1.5f];
    [v.layer setShadowColor:[UIColor blackColor].CGColor];
    [v.layer setShadowOpacity:0.8];
    [v.layer setShadowRadius:3.0];
    [v.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    //v.layer.masksToBounds = YES;
}


@end
