//
//  2GISKeyBoardHelper.h
//  Currency Converter
//
//  Created by Alexander Dupree on 24.02.15.
//  Copyright (c) 2015 Alexander Dupree - [~/psycho/path]>_. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 This helper to handle keyboard features and restrictions
 */
@interface _GISKeyBoardHelper : NSObject

/**
 Determines when user could or could not type more numbers to the keyboard
 */
+ (BOOL)userCouldTypeMoreNumbersToLabelWithText:(NSString *)text;

/**
 Determines when user could or could not type dot symbol
 */
+ (BOOL)userCouldTypeDotSymbolToLabelWithText:(NSString *)text;


@end
