//
//  2GISKeyboardContainer.m
//  Currency Converter
//
//  Created by Alexander Dupree on 23.02.15.
//  Copyright (c) 2015 Alexander Dupree - [~/psycho/path]>_. All rights reserved.
//

#import "2GISKeyboardContainer.h"

NSString * const KCPatternImageName = @"keyBoard_backgroundPattern";
CGFloat const KCButtonMargin = 3.0f;
CGFloat const KCBorderWidth = 1.0f;
CGFloat const KCCornerRadius = 6.0f;

CGFloat const KCButtonShadowWidth = 1.0f;
CGFloat const KCButtonShadowHeight = 1.0f;
CGFloat const KCButtonShadowOpacity = 0.4f;
CGFloat const KCButtonShadowRadius = 2.0f;

@implementation _GISKeyboardContainer

/**
 This method sets up the KeyboardContainer view
 */
- (void)setup
{
    //set up the background of keyboard container
    UIImage *patternImage = [UIImage imageNamed:KCPatternImageName];
    UIColor *colorWithPattern = [UIColor colorWithPatternImage:patternImage];
    [self setBackgroundColor:[UIColor clearColor]];
    [self.layer setBackgroundColor:colorWithPattern.CGColor];
    
    //setting up the shape of button
    [self.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.layer setBorderWidth:KCBorderWidth];
    [self.layer setCornerRadius:KCCornerRadius];
    
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
    // Drawing code
    [super drawRect:rect];
    [self drawButtons];
}

- (void)drawButtons
{
    CGFloat kx = 0;
    CGFloat ky = 0;
    
    for (NSUInteger i=1; i<13; i++){
        
        CGFloat buttonWidth = self.bounds.size.width/3-KCButtonMargin*2;
        CGFloat buttonHeight = self.bounds.size.height/4-KCButtonMargin*2;
        
        if((i-1)%3 == 0 && i != 1)
        {
            kx = 0;
            ky++;
        }
        
        _GISKeyboardButton *keyboardButton = [[_GISKeyboardButton alloc] init];
        [keyboardButton setFrame:CGRectMake(self.bounds.origin.x+KCButtonMargin+kx*(buttonWidth + 2*KCButtonMargin),
                                            self.bounds.origin.y+KCButtonMargin+ky*(buttonHeight + 2*KCButtonMargin),
                                            buttonWidth,
                                            buttonHeight)];
        
        //this is how I could set button labels
        //and set action for each button
        //pretty dirty, but it works.
        if(i == 10){
            [keyboardButton setTitle:@"." forState:UIControlStateNormal];
            [keyboardButton addTarget:self action:@selector(tapNumberButton:) forControlEvents:UIControlEventTouchUpInside];
        }
        else if (i == 11){
            [keyboardButton setTitle:@"0" forState:UIControlStateNormal];
            [keyboardButton addTarget:self action:@selector(tapNumberButton:) forControlEvents:UIControlEventTouchUpInside];
        }
        else if (i == 12){
            [keyboardButton setTitle:@"C" forState:UIControlStateNormal];
            [keyboardButton addTarget:self action:@selector(tapCleanButton:) forControlEvents:UIControlEventTouchUpInside];
        }
        else{
            [keyboardButton setTitle:[NSString stringWithFormat:@"%li", i] forState:UIControlStateNormal];
            [keyboardButton addTarget:self action:@selector(tapNumberButton:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        [keyboardButton addTarget:self action:@selector(cancelTouch:) forControlEvents:UIControlEventTouchCancel];
        [keyboardButton addTarget:self action:@selector(cancelTouch:) forControlEvents:UIControlEventTouchDragExit];
        [keyboardButton addTarget:self action:@selector(cancelTouch:) forControlEvents:UIControlEventTouchUpOutside];

        [keyboardButton addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDown];
        [keyboardButton addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDragInside];
        
        [self addSubview:keyboardButton];

        kx++;
    }
}

- (IBAction)tapNumberButton:(_GISKeyboardButton *)button
{
    AudioServicesPlaySystemSound(0x450);
    
    [self performSelector:@selector(cancelTouch:) withObject:button afterDelay:0.2f];
    
    if([self.delegate respondsToSelector:@selector(tapNumeric:)])
    {
        [self.delegate tapNumeric:button];
    }
}

- (IBAction)tapCleanButton:(_GISKeyboardButton *)button
{
    AudioServicesPlaySystemSound(0x450);
    
    [self performSelector:@selector(cancelTouch:) withObject:button afterDelay:0.2f];
    
    if([self.delegate respondsToSelector:@selector(tapClean:)])
    {
        [self.delegate tapClean:button];
    }
}

- (IBAction)cancelTouch:(_GISKeyboardButton *)button
{
    [button.layer setShadowRadius:KCButtonShadowRadius];
}

- (IBAction)touchDown:(_GISKeyboardButton *)button
{
    [button.layer setShadowRadius:0.0f];
}

@end
