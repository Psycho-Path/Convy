//
//  2GISKeyBoardHelper.m
//  Currency Converter
//
//  Created by Alexander Dupree on 24.02.15.
//  Copyright (c) 2015 Alexander Dupree - [~/psycho/path]>_. All rights reserved.
//

#import "2GISKeyBoardHelper.h"

@implementation _GISKeyBoardHelper

+(BOOL)userCouldTypeMoreNumbersToLabelWithText:(NSString *)text
{
    NSArray *tempArray = [text componentsSeparatedByString:@"."];
    if(tempArray.count > 1)
    {
        if([[tempArray objectAtIndex:1] length]>1)
        {
            return NO;
        }
        else
        {
            return YES;
        }
    }
    else
    {
        return YES;
    }
    
    return NO;
}

+ (BOOL)userCouldTypeDotSymbolToLabelWithText:(NSString *)text
{
    NSArray *tempArray = [text componentsSeparatedByString:@"."];
    
    if(tempArray.count >= 1)
    {
        return NO;
    }
    else
    {
        return YES;
    }
    
    return NO;
}

@end
