//
//  2GISCurrencySelectionButton.h
//  Currency Converter
//
//  Created by Alexander Dupree on 24.02.15.
//  Copyright (c) 2015 Alexander Dupree - [~/psycho/path]>_. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface _GISCurrencySelectionButton : UIButton

/**
 Flag that tells view that it have been selected.
 */
@property (nonatomic) BOOL isSelected;

/**
 Sets currency symbol.
 */
@property (nonatomic, strong) NSDictionary *currency;

@end
