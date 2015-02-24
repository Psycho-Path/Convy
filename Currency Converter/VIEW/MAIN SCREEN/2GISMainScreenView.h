//
//  2GISMainScreenView.h
//  Currency Converter
//
//  Created by Alexander Dupree on 23.02.15.
//  Copyright (c) 2015 Alexander Dupree - [~/psycho/path]>_. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface _GISMainScreenView : UIView

@property (nonatomic, strong) IBOutlet UIView *darkness;

/**
 draws half-screen darkness view
 */
- (void)drawDarkness;

/**
 removes darknes from screen
 */
- (void)removeDarkness;

@end
