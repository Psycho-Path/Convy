//
//  2GISCurrencies.m
//  Currency Converter
//
//  Created by Alexander Dupree on 23.02.15.
//  Copyright (c) 2015 Alexander Dupree - [~/psycho/path]>_. All rights reserved.
//

#import "2GISCurrencies.h"

NSString * const usdCurrencySymbol = @"$";
NSString * const usdCurrencyCode = @"USD";
NSString * const euroCurrencySymbol = @"€";
NSString * const euroCurrencyCode = @"EUR";

@implementation _GISCurrencies

@synthesize selectedSourceCurrency, selectedTargetCurrency;

static _GISCurrencies *currencies = nil;

+ (_GISCurrencies *)sharedCurrencies
{
    @synchronized(self)
    {
        if(!currencies) currencies = [_GISCurrencies new];
    }
    
    return currencies;
}

+ (NSArray *)getCurrencies
{
    NSMutableArray *currencies = [[NSMutableArray alloc] init];
    
    NSString *locale = [[NSLocale preferredLanguages] objectAtIndex:0];
    NSLocale *currentLocale = [[NSLocale alloc] initWithLocaleIdentifier:locale];
    NSArray *codes = [NSLocale commonISOCurrencyCodes];
    
    for(NSString *code in codes)
    {
        NSMutableDictionary *currentCurrency = [[NSMutableDictionary alloc] init];
        
        NSString *currency = [NSString stringWithFormat:@"%@ | %@",
                              code,
                              [currentLocale displayNameForKey:NSLocaleCurrencyCode value:code]];
        [currentCurrency setValue:currency forKey:displayKey];
        [currentCurrency setValue:[currentLocale displayNameForKey:NSLocaleCurrencySymbol value:code] forKey:symbolKey];
        [currentCurrency setValue:code forKey:codeKey];
        
        [currencies addObject:currentCurrency];
    }
    
    return currencies;
}

+ (NSArray *)getTopThreeCurrencies
{
    NSMutableArray * topThree = [[NSMutableArray alloc] init];
    
    //setting up user native currency
    NSMutableDictionary *neativeCurrency = [[NSMutableDictionary alloc] init];
    NSLocale *theLocale = [NSLocale currentLocale];
    NSString *currencySymbol = [theLocale objectForKey:NSLocaleCurrencySymbol];
    NSString *currencyCode = [theLocale objectForKey:NSLocaleCurrencyCode];
    [neativeCurrency setValue:currencyCode forKey:codeKey];
    [neativeCurrency setValue:currencySymbol forKey:symbolKey];
    [neativeCurrency setValue:[theLocale displayNameForKey:NSLocaleCurrencyCode value:currencyCode] forKey:displayKey];
    
    if(![currencyCode isEqualToString:usdCurrencyCode] && ![currencyCode isEqualToString:euroCurrencyCode])
        [topThree addObject:neativeCurrency];
    
    //setting up USD currency
    NSMutableDictionary *usdCurrency = [[NSMutableDictionary alloc] init];
    [usdCurrency setValue:usdCurrencyCode forKey:codeKey];
    [usdCurrency setValue:usdCurrencySymbol forKey:symbolKey];
    [usdCurrency setValue:[theLocale displayNameForKey:NSLocaleCurrencyCode value:usdCurrencyCode] forKey:displayKey];
    [topThree addObject:usdCurrency];
    
    //setting up EURO
    NSMutableDictionary *euroCurrency = [[NSMutableDictionary alloc] init];
    [euroCurrency setValue:euroCurrencyCode forKey:codeKey];
    [euroCurrency setValue:euroCurrencySymbol forKey:symbolKey];
    [euroCurrency setValue:[theLocale displayNameForKey:NSLocaleCurrencyCode value:euroCurrencyCode] forKey:displayKey];
    [topThree addObject:euroCurrency];
    
    return topThree;
}

@end
