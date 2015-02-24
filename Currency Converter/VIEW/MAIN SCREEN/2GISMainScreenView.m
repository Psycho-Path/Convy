//
//  2GISMainScreenView.m
//  Currency Converter
//
//  Created by Alexander Dupree on 23.02.15.
//  Copyright (c) 2015 Alexander Dupree - [~/psycho/path]>_. All rights reserved.
//

#import "2GISMainScreenView.h"

#define BACKGROUND_COLOR [UIColor colorWithPatternImage:[UIImage imageNamed:@"mainBackgroundPattern"]]

@implementation _GISMainScreenView

@synthesize darkness;

/**
 This method sets up the Main view
 */
- (void)setup
{
    //setup the background color of main view
    [self setBackgroundColor:BACKGROUND_COLOR];
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

- (void)drawDarkness
{
    if(darkness) [darkness removeFromSuperview];
    
    darkness = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height/2)];
    [darkness setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.6f]];
    [self addSubview:darkness];
}

- (void)removeDarkness
{
    if(darkness) [darkness removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
