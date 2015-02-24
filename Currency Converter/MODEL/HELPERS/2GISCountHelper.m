//
//  2GISCountHelper.m
//  Currency Converter
//
//  Created by Alexander Dupree on 24.02.15.
//  Copyright (c) 2015 Alexander Dupree - [~/psycho/path]>_. All rights reserved.
//

#import "2GISCountHelper.h"

@implementation _GISCountHelper

+ (NSString *)countTargetMoneyUsingSourceMoney:(NSString *)sourceMoney
{
    double sourceNumber = [sourceMoney doubleValue];
    double equalsToBaseCurrency = [[[[_GISRatesServer sharedRatesServer] rates] valueForKey:[[[_GISCurrencies sharedCurrencies] selectedSourceCurrency] valueForKey:codeKey]] doubleValue];

    //converting source value to base
    double sourceToBase = sourceNumber / equalsToBaseCurrency;
    
    double targetEqualsToBase = [[[[_GISRatesServer sharedRatesServer] rates] valueForKey:[[[_GISCurrencies sharedCurrencies] selectedTargetCurrency] valueForKey:codeKey]] doubleValue];

    //counting target amount
    double targetAmount = sourceToBase * targetEqualsToBase;
    
    return [NSString stringWithFormat:@"%.2f", targetAmount];
}

@end
