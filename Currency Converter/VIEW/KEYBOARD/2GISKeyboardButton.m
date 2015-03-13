//
//  2GISKeyboardButton.m
//  Currency Converter
//
//  Created by Alexander Dupree on 23.02.15.
//  Copyright (c) 2015 Alexander Dupree - [~/psycho/path]>_. All rights reserved.
//

#import "2GISKeyboardButton.h"

#define BUTTON_TEXT_COLOR [UIColor colorWithRed:68.0f/255.0f green:67.0f/255.0f blue:73.0f/255.0f alpha:1.0f]

CGFloat const KBBorderWidth = 1.0f;
CGFloat const KBCornerRadius = 6.0f;
CGFloat const KBShadowWidth = 1.0f;
CGFloat const KBShadowHeight = 1.0f;
CGFloat const KBShadowOpacity = 0.4f;
CGFloat const KBShadowRadius = 2.0f;
NSString * const KBFontName = @"Helvetica-Bold";
CGFloat const KBFontSize = 21.0f;
NSString * const KBPatternImageName = @"keyboardButton_backgroundPattern";

@implementation _GISKeyboardButton

/**
 This method sets up the KeyboardButton view
 */
- (void)setup
{
    //setting up the background of button
    UIImage *patternImage = [UIImage imageNamed:KBPatternImageName];
    UIColor * colorWithPatternImage = [UIColor colorWithPatternImage:patternImage];
    [self setBackgroundColor:colorWithPatternImage];
    
    //setting up the shape of button
    [self.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.layer setBorderWidth:KBBorderWidth];
    [self.layer setCornerRadius:KBCornerRadius];
    
    //setting up the text settings of button
    [self setTitleColor:BUTTON_TEXT_COLOR forState:UIControlStateNormal];
    [self.titleLabel setFont:[UIFont fontWithName:KBFontName size:KBFontSize]];
    
    //setting up the shadow of button
    [self.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.layer setShadowOffset:CGSizeMake(KBShadowWidth, KBShadowHeight)];
    [self.layer setShadowOpacity:KBShadowOpacity];
    [self.layer setShadowRadius:KBShadowRadius];
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

@end
