//
//  2GISKeyboardButton.m
//  Currency Converter
//
//  Created by Alexander Dupree on 23.02.15.
//  Copyright (c) 2015 Alexander Dupree - [~/psycho/path]>_. All rights reserved.
//

#import "2GISKeyboardButton.h"

#define BUTTON_TEXT_COLOR [UIColor colorWithRed:68.0f/255.0f green:67.0f/255.0f blue:73.0f/255.0f alpha:1.0f]

CGFloat const borderWidth = 1.0f;
CGFloat const cornerRadius = 6.0f;
CGFloat const shadowWidth = 1.0f;
CGFloat const shadowHeight = 1.0f;
CGFloat const shadowOpacity = 0.4f;
CGFloat const shadowRadius = 2.0f;
NSString * const fontName = @"Helvetica-Bold";
CGFloat const fontSize = 21.0f;
NSString * const buttonPatternImageName = @"keyboardButton_backgroundPattern";

@implementation _GISKeyboardButton

/**
 This method sets up the KeyboardButton view
 */
- (void)setup
{
    //setting up the background of button
    UIImage *patternImage = [UIImage imageNamed:buttonPatternImageName];
    UIColor * colorWithPatternImage = [UIColor colorWithPatternImage:patternImage];
    [self setBackgroundColor:colorWithPatternImage];
    
    //setting up the shape of button
    [self.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.layer setBorderWidth:borderWidth];
    [self.layer setCornerRadius:cornerRadius];
    
    //setting up the text settings of button
    [self setTitleColor:BUTTON_TEXT_COLOR forState:UIControlStateNormal];
    [self.titleLabel setFont:[UIFont fontWithName:fontName size:fontSize]];
    
    //setting up the shadow of button
    [self.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.layer setShadowOffset:CGSizeMake(shadowWidth, shadowHeight)];
    [self.layer setShadowOpacity:shadowOpacity];
    [self.layer setShadowRadius:shadowRadius];
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
