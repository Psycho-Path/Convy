//
//  2GISCountHelper.h
//  Currency Converter
//
//  Created by Alexander Dupree on 24.02.15.
//  Copyright (c) 2015 Alexander Dupree - [~/psycho/path]>_. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 This helper to handle currency recounting features
 */
@interface _GISCountHelper : NSObject


/**
 Method returns target amount from source one
 */
+ (NSString *)countTargetMoneyUsingSourceMoney:(NSString *)sourceMoney;

@end
