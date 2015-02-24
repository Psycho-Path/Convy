//
//  2GISDataReceivingPreloader.m
//  Currency Converter
//
//  Created by Alexander Dupree on 24.02.15.
//  Copyright (c) 2015 Alexander Dupree - [~/psycho/path]>_. All rights reserved.
//

#import "2GISDataReceivingPreloader.h"

CGFloat const preloaderViewWidthHeight = 200.0f;
CGFloat const preloaderViewCornerRadius = 6.0f;
CGFloat const preloaderViewShadowWidth = 1.0f;
CGFloat const preloaderViewShadowHeight = 1.0f;
CGFloat const preloaderViewShadowRadius = 3.0f;
NSString * const tickImageName = @"tick_2";

@implementation _GISDataReceivingPreloader

@synthesize viewWithPreloader, activityIndicator;

- (void)setup
{
    [self setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.6f]];
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
    [self drawViewWithPreloader];
}

- (void)drawViewWithPreloader
{
    viewWithPreloader = [[UIView alloc] initWithFrame:CGRectMake((self.bounds.size.width-preloaderViewWidthHeight)/2,
                                                                (self.bounds.size.height-preloaderViewWidthHeight)/2,
                                                                preloaderViewWidthHeight,
                                                                 preloaderViewWidthHeight)];
    [viewWithPreloader setBackgroundColor:[UIColor clearColor]];
    [viewWithPreloader.layer setCornerRadius:preloaderViewCornerRadius];
    [self.layer setShadowColor:[UIColor whiteColor].CGColor];
    [self.layer setShadowOffset:CGSizeMake(preloaderViewShadowWidth, preloaderViewWidthHeight)];
    [self.layer setShadowOpacity:0.6f];
    [self.layer setShadowRadius:preloaderViewShadowRadius];
    [viewWithPreloader.layer setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.6f].CGColor];
    [self addSubview:viewWithPreloader];
    
    [self drawActivityIndicator];
    [activityIndicator startAnimating];
    
}

- (void)drawActivityIndicator
{
    activityIndicator  = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [activityIndicator setCenter:CGPointMake(viewWithPreloader.bounds.size.width/2,
                                             viewWithPreloader.bounds.size.height/2)];
    [viewWithPreloader addSubview:activityIndicator];
}

- (void)showSuccessStatus
{
    [activityIndicator stopAnimating];
    UIImage *tickImage = [UIImage imageNamed:tickImageName];
    UIImageView *tickImageView = [[UIImageView alloc] initWithImage:tickImage];
    [tickImageView setFrame:CGRectMake((viewWithPreloader.bounds.size.width-tickImage.size.width)/2,
                                      (viewWithPreloader.bounds.size.height-tickImage.size.height)/2,
                                      tickImage.size.width,
                                       tickImage.size.height)];
    [viewWithPreloader addSubview:tickImageView];
    
    [UIView animateWithDuration:0.5f
                          delay:0.5f
                        options:kNilOptions animations:^{
                            [tickImageView setCenter:CGPointMake(tickImageView.center.x, tickImageView.center.y+2*tickImageView.frame.size.height)];
                        }
                     completion:nil];
    
    [self drawInformationLabel];
    
    [self performSelector:@selector(removePreloader) withObject:nil afterDelay:2.0f];
}

- (void)drawInformationLabel
{
    UILabel *informationLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 20.0f, viewWithPreloader.bounds.size.width-40.0f, 50.0f)];
    [informationLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17.0f]];
    [informationLabel setTextAlignment:NSTextAlignmentCenter];
    [informationLabel setTextColor:[UIColor whiteColor]];
    [informationLabel setText:NSLocalizedString(@"Currency rates data have been updated.", nil)];
    [informationLabel setNumberOfLines:0];
    [informationLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [informationLabel setAlpha:0.0f];
    
    [viewWithPreloader addSubview:informationLabel];
    
    [UIView animateWithDuration:0.5f
                          delay:0.5f
                        options:kNilOptions
                     animations:^{
                         [informationLabel setAlpha:1.0f];
                     }
                     completion:nil];
}

- (void)removePreloader
{
    if([self superview] && self)
    {
        [self removeFromSuperview];
    }
}

@end
