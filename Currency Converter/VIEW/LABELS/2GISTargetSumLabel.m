//
//  2GISTargetSumLabel.m
//  Currency Converter
//
//  Created by Alexander Dupree on 23.02.15.
//  Copyright (c) 2015 Alexander Dupree - [~/psycho/path]>_. All rights reserved.
//

#import "2GISTargetSumLabel.h"

#define FONT_COLOR [UIColor colorWithRed:250.0f/255.0f green:85.0f/255.0f blue:132.0f/255.0f alpha:1.0f]

NSString * const TLFontName = @"Helvetica-Bold";
CGFloat const TLFontSize = 48.0f;
CGFloat const TLCurrencyButtonOffset = 5.0f;

CGFloat const TLShadowWidth = 1.0f;
CGFloat const TLShadowHeight = 1.0f;
CGFloat const TLShadowOpacity = 0.4f;
CGFloat const TLShadowRadius = 2.0f;

@interface _GISTargetSumLabel ()

@property (nonatomic) CGPoint firstPointCenter;
@property (nonatomic) CGPoint secondPointCenter;
@property (nonatomic) CGPoint thirdPointCenter;
@property (nonatomic) CGPoint fourthPointCenter;

@end

@implementation _GISTargetSumLabel

@synthesize currencyButton, firstSelectionButton, secondSelectionButton, thirdSelectionButton,othersSelectionButton;
@synthesize firstPointCenter, secondPointCenter, thirdPointCenter, fourthPointCenter;

/**
 This method sets up the target sum label view
 */
- (void)setup
{
    [self setUserInteractionEnabled:YES];
    
    [self setBackgroundColor:[UIColor clearColor]];
    [self setTextColor:FONT_COLOR];
    [self setTextAlignment:NSTextAlignmentCenter];
    [self setFont:[UIFont fontWithName:TLFontName size:TLFontSize]];
    [self setText:@"0"];
    
    [self.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.layer setShadowOffset:CGSizeMake(TLShadowWidth, TLShadowHeight)];
    [self.layer setShadowOpacity:TLShadowOpacity];
    [self.layer setShadowRadius:TLShadowRadius];
    
    [self setBaselineAdjustment:UIBaselineAdjustmentAlignBaselines];
    [self setLineBreakMode:NSLineBreakByClipping];
    [self setMinimumScaleFactor:7.0f/self.font.pointSize];
    [self setAdjustsFontSizeToFitWidth:YES];
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
    [self drawTargetCurrencyButton];
}


- (void)drawTargetCurrencyButton
{
    if(currencyButton) [currencyButton removeFromSuperview];
    
    CGFloat currencyButtonWidthHeight = self.bounds.size.height/2 - 2*TLCurrencyButtonOffset;
    currencyButton = [[_GISTardetCurrencyButton alloc] initWithFrame:
                                                CGRectMake(TLCurrencyButtonOffset,
                                                           self.bounds.size.height-TLCurrencyButtonOffset-currencyButtonWidthHeight,
                                                           currencyButtonWidthHeight,
                                                           currencyButtonWidthHeight)];
    [currencyButton updateSelectedCurrency];
    [currencyButton addTarget:self action:@selector(showTopCurrencies:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:currencyButton];
}

- (IBAction)showTopCurrencies:(_GISTardetCurrencyButton *)button
{
    if([self.delegate respondsToSelector:@selector(targetCurrencyButtonDidTap)])
    {
        [self.delegate targetCurrencyButtonDidTap];
    }
    
    if(firstSelectionButton || secondSelectionButton || thirdSelectionButton || othersSelectionButton)
    {
        [self hideAdditionalButtons];
    }
    else
    {
        [self drawAdditionlButtons];
        [self bringSubviewToFront:currencyButton];
        [self animateAdditionalButtons];
    }
}


- (void)drawAdditionlButtons
{
    CGFloat currencyButtonWidthHeight = self.bounds.size.height/2 - 2*TLCurrencyButtonOffset;
    
    CGRect startFrame = CGRectMake(TLCurrencyButtonOffset,
                                   self.bounds.size.height-TLCurrencyButtonOffset-currencyButtonWidthHeight,
                                   currencyButtonWidthHeight,
                                   currencyButtonWidthHeight);
    
    NSDictionary *secondCurrency = [[_GISCurrencies getTopThreeCurrencies] objectAtIndex:1];
    if([[[[_GISCurrencies sharedCurrencies] selectedTargetCurrency] valueForKey:symbolKey] isEqualToString:[secondCurrency valueForKey:symbolKey]])
    {
        secondCurrency = [[_GISCurrencies getTopThreeCurrencies] objectAtIndex:0];
    }
    
    NSDictionary *thirdCurrency = nil;
    if([[_GISCurrencies getTopThreeCurrencies] count] > 2)
    {
        thirdCurrency = [[_GISCurrencies getTopThreeCurrencies] objectAtIndex:2];
        if([[[[_GISCurrencies sharedCurrencies] selectedTargetCurrency] valueForKey:symbolKey] isEqualToString:[thirdCurrency valueForKey:symbolKey]])
        {
            thirdCurrency = [[_GISCurrencies getTopThreeCurrencies] objectAtIndex:0];
        }
    }
    
    firstSelectionButton = [[_GISCurrencySelectionButton alloc] initWithFrame:startFrame];
    [firstSelectionButton setCurrency:[[_GISCurrencies sharedCurrencies] selectedTargetCurrency]];
    [firstSelectionButton addTarget:self action:@selector(selectCurrency:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:firstSelectionButton];
    
    
    secondSelectionButton = [[_GISCurrencySelectionButton alloc] initWithFrame:startFrame];
    [secondSelectionButton setCurrency:secondCurrency];
    [secondSelectionButton addTarget:self action:@selector(selectCurrency:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:secondSelectionButton];
    
    if(thirdCurrency)
    {
        thirdSelectionButton = [[_GISCurrencySelectionButton alloc] initWithFrame:startFrame];
        [thirdSelectionButton setCurrency:thirdCurrency];
        [thirdSelectionButton addTarget:self action:@selector(selectCurrency:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:thirdSelectionButton];
        
        othersSelectionButton = [[_GISCurrencySelectionButton alloc] initWithFrame:startFrame];
        [othersSelectionButton setTitle:@"..." forState:UIControlStateNormal];
        [othersSelectionButton addTarget:self action:@selector(showMoreCurrencies:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:othersSelectionButton];
    }
    else
    {
        thirdSelectionButton = [[_GISCurrencySelectionButton alloc] initWithFrame:startFrame];
        [thirdSelectionButton setTitle:@"..." forState:UIControlStateNormal];
        [thirdSelectionButton addTarget:self action:@selector(showMoreCurrencies:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:thirdSelectionButton];
    }
}

- (void)animateAdditionalButtons
{
    firstPointCenter = firstSelectionButton.center;
    secondPointCenter = secondSelectionButton.center;
    thirdPointCenter = thirdSelectionButton.center;
    fourthPointCenter = othersSelectionButton.center;
    
    [UIView animateWithDuration:0.5f animations:^
     {
         [firstSelectionButton setCenter:CGPointMake(firstPointCenter.x+1.1f*firstSelectionButton.bounds.size.width,
                                                     firstPointCenter.y)];
         
         [secondSelectionButton setCenter:CGPointMake(secondPointCenter.x+2.2f*secondSelectionButton.bounds.size.width,
                                                      secondPointCenter.y)];
         
         [thirdSelectionButton setCenter:CGPointMake(thirdPointCenter.x+3.3f*thirdSelectionButton.bounds.size.width,
                                                     thirdPointCenter.y)];
         
         [othersSelectionButton setCenter:CGPointMake(fourthPointCenter.x+4.4f*othersSelectionButton.bounds.size.width,
                                                      fourthPointCenter.y)];
     }];
}

- (void)hideAdditionalButtons
{
    if([self.delegate respondsToSelector:@selector(targetAdditionalButtonsDidHide)])
    {
        [self.delegate targetAdditionalButtonsDidHide];
    }
    
    [self animateAdditionalButtonsBack];
    [self performSelector:@selector(removeAdditionalButtonsFromSuperView) withObject:nil afterDelay:0.6f];
}

- (void)animateAdditionalButtonsBack
{
    [UIView animateWithDuration:0.5f animations:^{
        [firstSelectionButton setCenter:firstPointCenter];
        [secondSelectionButton setCenter:secondPointCenter];
        [thirdSelectionButton setCenter:thirdPointCenter];
        [othersSelectionButton setCenter:fourthPointCenter];
    }];
}

- (void)removeAdditionalButtonsFromSuperView
{
    [firstSelectionButton removeFromSuperview];
    firstSelectionButton = nil;
    [secondSelectionButton removeFromSuperview];
    secondSelectionButton = nil;
    [thirdSelectionButton removeFromSuperview];
    thirdSelectionButton = nil;
    [othersSelectionButton removeFromSuperview];
    othersSelectionButton = nil;
}


- (IBAction)selectCurrency:(_GISCurrencySelectionButton *)button
{
    if(button.currency)
    {
        [[_GISCurrencies sharedCurrencies] setSelectedTargetCurrency:button.currency];
        [currencyButton updateSelectedCurrency];
        [self hideAdditionalButtons];
    }
}

- (IBAction)showMoreCurrencies:(_GISCurrencySelectionButton *)button
{
    if([self.delegate respondsToSelector:@selector(showMoreTargetCurrenciesButtonDidTap)])
    {
        [self.delegate showMoreTargetCurrenciesButtonDidTap];
    }
}

@end
