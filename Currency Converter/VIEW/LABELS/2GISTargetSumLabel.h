//
//  2GISTargetSumLabel.h
//  Currency Converter
//
//  Created by Alexander Dupree on 23.02.15.
//  Copyright (c) 2015 Alexander Dupree - [~/psycho/path]>_. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "2GISTardetCurrencyButton.h"
#import "2GISCurrencySelectionButton.h"

@protocol _GISTargetLabelDelegate <NSObject>

/**
 Let reciever know when user tapped currency button
 */
- (void)targetCurrencyButtonDidTap;
/**
 Let resiver know when additional buttons have been hidden
 */
- (void)targetAdditionalButtonsDidHide;
/**
 Let reciever know when "more" button've been tapped
 */
- (void)showMoreTargetCurrenciesButtonDidTap;

@end

/**
 Target label view
 */
@interface _GISTargetSumLabel : UILabel

/**
 Currency button control
 */
@property (nonatomic, strong) _GISTardetCurrencyButton *currencyButton;

/**
 First currency selection button
 */
@property (nonatomic,  strong) _GISCurrencySelectionButton *firstSelectionButton;
/**
 Second currency selection button
 */
@property (nonatomic,  strong) _GISCurrencySelectionButton *secondSelectionButton;
/**
 Third currency selection button
 */
@property (nonatomic,  strong) _GISCurrencySelectionButton *thirdSelectionButton;
/**
 "More currencies" selection button
 */
@property (nonatomic,  strong) _GISCurrencySelectionButton *othersSelectionButton;

@property (nonatomic, unsafe_unretained) id <_GISTargetLabelDelegate> delegate;

@end
