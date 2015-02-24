//
//  _GISViewController.h
//  Currency Converter
//
//  Created by Alexander Dupree on 21.02.15.
//  Copyright (c) 2015 Alexander Dupree - [~/psycho/path]>_. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "2GISMainScreenView.h"
#import "2GISKeyboardContainer.h"
#import "2GISSourceSum.h"
#import "2GISTargetSumLabel.h"
#import "2GISSeparator.h"
#import "2GISDataReceivingPreloader.h"
#import "2GISKeyBoardHelper.h"
#import "2GISCountHelper.h"
#import "2GISCurrenciesViewController.h"

/**
 Main View controller.
 */
@interface _GISViewController : UIViewController<_GISKeyboardDelegate, _GISSourceLabelDelegate, _GISTargetLabelDelegate>

/**
 Source label outlet
 */
@property (nonatomic, strong) IBOutlet _GISSourceSum *sourceLabel;

/**
 Separator between labels
 */
@property (nonatomic, strong) IBOutlet _GISSeparator *separator;

/**
 Target label outlet
 */
@property (nonatomic, strong) IBOutlet _GISTargetSumLabel *targetLabel;

/**
 Preloader view outlet
 */
@property (nonatomic, strong) IBOutlet _GISDataReceivingPreloader *preloaderView;

/**
 This property tells "CurrenciesVieController" about 
 what kind of currency user is looking for.
 */
@property (nonatomic) BOOL targetCurrencySeeMore;

@end
