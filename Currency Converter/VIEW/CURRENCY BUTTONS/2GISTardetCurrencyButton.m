//
//  2GISTardetCurrencyButton.m
//  Currency Converter
//
//  Created by Alexander Dupree on 23.02.15.
//  Copyright (c) 2015 Alexander Dupree - [~/psycho/path]>_. All rights reserved.
//

#import "2GISTardetCurrencyButton.h"

#define TARGET_PATTERN [UIColor colorWithPatternImage:[UIImage imageNamed:@"targetCurrencyButton_pattern"]].CGColor
#define BUTTON_TEXT_COLOR [UIColor colorWithRed:250.0f/255.0f green:85.0f/255.0f blue:132.0f/255.0f alpha:1.0f]

CGFloat const shadowWidth = 1.0f;
CGFloat const shadowHeight = 1.0f;
CGFloat const shadowOpacity = 0.4f;
CGFloat const shadowRadius = 2.0f;
NSString * const tFontName = @"Helvetica-Light";
CGFloat const tFontSize = 21.0f;

@implementation _GISTardetCurrencyButton

/**
 This method sets up the target button view
 */
- (void)setup
{
    //setting up background of target button
    [self setBackgroundColor:[UIColor clearColor]];
    [self.layer setBackgroundColor:TARGET_PATTERN];
    [self setTitleColor:BUTTON_TEXT_COLOR forState:UIControlStateNormal];
    [self.titleLabel setFont:[UIFont fontWithName:tFontName size:tFontSize]];
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
    //setting up shape and shadow of target button
    [self.layer setCornerRadius:self.bounds.size.width/2];
    [self.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.layer setShadowOffset:CGSizeMake(shadowWidth, shadowHeight)];
    [self.layer setShadowOpacity:shadowOpacity];
    [self.layer setShadowRadius:shadowRadius];
}

- (void)updateSelectedCurrency
{
    if([[_GISCurrencies sharedCurrencies] selectedTargetCurrency])
    {
        [self setTitle:[[[_GISCurrencies sharedCurrencies] selectedTargetCurrency] valueForKey:symbolKey] forState:UIControlStateNormal];
    }
}

@end
