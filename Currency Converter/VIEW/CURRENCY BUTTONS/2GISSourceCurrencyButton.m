//
//  2GISSourceCurrencyButton.m
//  Currency Converter
//
//  Created by Alexander Dupree on 23.02.15.
//  Copyright (c) 2015 Alexander Dupree - [~/psycho/path]>_. All rights reserved.
//

#import "2GISSourceCurrencyButton.h"

#define TARGET_PATTERN [UIColor colorWithPatternImage:[UIImage imageNamed:@"targetCurrencyButton_pattern"]].CGColor
#define BUTTON_TEXT_COLOR [UIColor colorWithRed:45.0f/255.0f green:214.0f/255.0f blue:124.0f/255.0f alpha:1.0f]

CGFloat const SCBShadowWidth = 1.0f;
CGFloat const SCBShadowHeight = 1.0f;
CGFloat const SCBShadowOpacity = 0.4f;
CGFloat const SCBShadowRadius = 2.0f;
NSString * const SCBFontName = @"Helvetica-Light";
CGFloat const SCBFontSize = 21.0f;

@implementation _GISSourceCurrencyButton

/**
 This method sets up the target button view
 */
- (void)setup
{
    //setting up background of target button
    [self setBackgroundColor:[UIColor clearColor]];
    [self.layer setBackgroundColor:TARGET_PATTERN];
    [self setTitleColor:BUTTON_TEXT_COLOR forState:UIControlStateNormal];
    [self.titleLabel setFont:[UIFont fontWithName:SCBFontName size:SCBFontSize]];
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
    [self.layer setShadowOffset:CGSizeMake(SCBShadowWidth, SCBShadowHeight)];
    [self.layer setShadowOpacity:SCBShadowOpacity];
    [self.layer setShadowRadius:SCBShadowRadius];
}

- (void)updateSelectedCurrency
{
    if([[_GISCurrencies sharedCurrencies] selectedSourceCurrency])
    {
        [self setTitle:[[[_GISCurrencies sharedCurrencies] selectedSourceCurrency] valueForKey:symbolKey] forState:UIControlStateNormal];
    }
}

@end
