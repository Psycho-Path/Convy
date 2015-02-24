//
//  2GISRatesServer.h
//  Currency Converter
//
//  Created by Alexander Dupree on 21.02.15.
//  Copyright (c) 2015 Alexander Dupree - [~/psycho/path]>_. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Class that provides data from remote server.
 Service name: openexchangerates.org
 */
@interface _GISRatesServer : NSObject

/**
 Application Identifier. Provides ability to send requests to server.
 */
@property (nonatomic, strong) NSString *appId;

/**
 Currency rates (read-only)
 */
@property (nonatomic, strong, readwrite) NSDictionary *rates;

/**
 Method returns the singleton Rates Server instance.
 */
+ (_GISRatesServer *)sharedRatesServer;

/**
 Method establishes connection with remote server and sets "rates" property.
 */
+ (void)connect;

@end
