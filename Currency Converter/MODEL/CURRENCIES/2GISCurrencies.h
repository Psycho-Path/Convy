//
//  2GISCurrencies.h
//  Currency Converter
//
//  Created by Alexander Dupree on 23.02.15.
//  Copyright (c) 2015 Alexander Dupree - [~/psycho/path]>_. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 This class provides data about currencies.
 */
@interface _GISCurrencies : NSObject

/**
 Returns all of the known currencies
 */
+ (NSArray *)getCurrencies;

/**
 Returns three most popular currencies if locale is not US of European. Otherwise returns two currencies: USD & EURO
 */
+ (NSArray *)getTopThreeCurrencies;

/**
 Returns the singleton Currencies instance.
 */
+ (_GISCurrencies *)sharedCurrencies;

/**
 This property holds current selected source currency
 */
@property (nonatomic, strong) NSDictionary * selectedSourceCurrency;

/**
 This property holds current selected target currency
 */
@property (nonatomic, strong) NSDictionary * selectedTargetCurrency;

@end
