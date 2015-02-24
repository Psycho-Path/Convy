//
//  2GISDataReceivingPreloader.h
//  Currency Converter
//
//  Created by Alexander Dupree on 24.02.15.
//  Copyright (c) 2015 Alexander Dupree - [~/psycho/path]>_. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 Preloader view
 Fullscreen view preloader view.
 Makes User wait until Currency rates data updates.
 */
@interface _GISDataReceivingPreloader : UIView

/**
 Central rounded-rect view
 */
@property (nonatomic, strong) IBOutlet UIView *viewWithPreloader;

/**
 Activity indicator
 */
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;


/**
 This method triggers animations.
 Activity indicator stops.
 Tick view appears and goes down.
 Information label appears.
 Preloader view removes from super
 */
- (void)showSuccessStatus;

@end
