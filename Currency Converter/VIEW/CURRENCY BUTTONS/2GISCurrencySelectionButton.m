//
//  2GISCurrencySelectionButton.m
//  Currency Converter
//
//  Created by Alexander Dupree on 24.02.15.
//  Copyright (c) 2015 Alexander Dupree - [~/psycho/path]>_. All rights reserved.
//

#import "2GISCurrencySelectionButton.h"

#define TARGET_PATTERN [UIColor colorWithPatternImage:[UIImage imageNamed:@"targetCurrencyButton_pattern"]].CGColor
#define BUTTON_TEXT_COLOR [UIColor colorWithRed:68.0f/255.0f green:67.0f/255.0f blue:73.0f/255.0f alpha:1.0f]

CGFloat const CSBShadowWidth = 1.0f;
CGFloat const CSBShadowHeight = 1.0f;
CGFloat const CSBShadowOpacity = 0.4f;
CGFloat const CSBShadowRadius = 2.0f;
NSString * const CSBSFontName = @"Helvetica-Light";
CGFloat const CSBSFontSize = 21.0f;

@implementation _GISCurrencySelectionButton

/**
 This method sets up the target button view
 */
- (void)setup
{
    //setting up background of target button
    [self setBackgroundColor:[UIColor clearColor]];
    [self.layer setBackgroundColor:TARGET_PATTERN];
    [self setTitleColor:BUTTON_TEXT_COLOR forState:UIControlStateNormal];
    [self.titleLabel setFont:[UIFont fontWithName:CSBSFontName size:CSBSFontSize]];
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
    [self.layer setShadowColor:[UIColor whiteColor].CGColor];
    [self.layer setShadowOffset:CGSizeMake(CSBShadowWidth, CSBShadowHeight)];
    [self.layer setShadowOpacity:CSBShadowOpacity];
    [self.layer setShadowRadius:CSBShadowRadius];

    if(self.currency)
    [self setTitle:[self.currency valueForKey:symbolKey] forState:UIControlStateNormal];
}
@end
