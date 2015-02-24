//
//  _GISAppDelegate.m
//  Currency Converter
//
//  Created by Alexander Dupree on 21.02.15.
//  Copyright (c) 2015 Alexander Dupree - [~/psycho/path]>_. All rights reserved.
//

#import "_GISAppDelegate.h"

NSString * const appId = @"1c15373a367c4083ad34d1ad764a0a8d";

@implementation _GISAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //setting up status bar color
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //setting up app id
    [[_GISRatesServer sharedRatesServer] setAppId:appId];
    
    //seting up source and target currency
    if([[_GISCurrencies getTopThreeCurrencies] count] > 1)
    {
        NSDictionary *sourceCurrency = [[_GISCurrencies getTopThreeCurrencies] objectAtIndex:0];
        NSDictionary *targetCurrency = [[_GISCurrencies getTopThreeCurrencies] objectAtIndex:1];
        
        [[_GISCurrencies sharedCurrencies] setSelectedSourceCurrency:sourceCurrency];
        [[_GISCurrencies sharedCurrencies] setSelectedTargetCurrency:targetCurrency];
    }
    
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [_GISRatesServer connect];
}

@end
