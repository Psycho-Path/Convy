//
//  2GISKeyboardContainer.h
//  Currency Converter
//
//  Created by Alexander Dupree on 23.02.15.
//  Copyright (c) 2015 Alexander Dupree - [~/psycho/path]>_. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "2GISKeyboardButton.h"

/**
 This protocol defines methods you can implement to handle keyboard buttons tapping.
 */
@protocol _GISKeyboardDelegate <NSObject>

- (IBAction)tapNumeric:(_GISKeyboardButton *)button;
- (IBAction)tapClean:(_GISKeyboardButton *)button;

@end
/**
 Keyboard container. Thats pretty useful control.
 All of the customization is private. But I could do it public in 5 minutes. =)
 */
@interface _GISKeyboardContainer : UIView

@property (nonatomic, unsafe_unretained) id <_GISKeyboardDelegate> delegate;

@end
