//
//  2GISSeparator.m
//  Currency Converter
//
//  Created by Alexander Dupree on 23.02.15.
//  Copyright (c) 2015 Alexander Dupree - [~/psycho/path]>_. All rights reserved.
//

#import "2GISSeparator.h"

CGFloat const shadowWidth = 1.0f;
CGFloat const shadowHeight = 1.0f;
CGFloat const shadowOpacity = 0.4f;
CGFloat const shadowRadius = 2.0f;

@implementation _GISSeparator

/**
 This method sets up the target separator view
 */
- (void)setup
{
    [self setBackgroundColor:[UIColor clearColor]];
    [self.layer setBackgroundColor:[UIColor lightGrayColor].CGColor];
}

- (void)awakeFromNib
{
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setup];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    [self.layer setCornerRadius:self.bounds.size.height/2];
    [self.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.layer setShadowOffset:CGSizeMake(shadowWidth, shadowHeight)];
    [self.layer setShadowOpacity:shadowOpacity];
    [self.layer setShadowRadius:shadowRadius];
    
}

@end
