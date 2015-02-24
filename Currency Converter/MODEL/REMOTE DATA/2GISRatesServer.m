//
//  2GISRatesServer.m
//  Currency Converter
//
//  Created by Alexander Dupree on 21.02.15.
//  Copyright (c) 2015 Alexander Dupree - [~/psycho/path]>_. All rights reserved.
//

#import "2GISRatesServer.h"

/**
 Base url to the remote API service.
 HTTP is for free (trial) version.
 */
NSString * const baseUrl = @"http://openexchangerates.org/api/";

/**
 The second (middle) part of the request to remote server
 It specifies what exactly do we need from server.
 */
NSString * const ratesQuerySlug = @"latest.json?app_id=";

/**
 "rates" key in server responsed data.
 */
NSString * const ratesKey = @"rates";


@implementation _GISRatesServer

@synthesize appId, rates;

static _GISRatesServer *ratesServer = nil;

+ (_GISRatesServer *)sharedRatesServer
{
    @synchronized(self)
    {
        if(!ratesServer) ratesServer = [_GISRatesServer new];
        
    }

    return ratesServer;
}

+ (void)connect
{
    if([[self sharedRatesServer] appId])
    {
        NSString *stringUrl = [NSString stringWithFormat:@"%@%@%@", baseUrl, ratesQuerySlug, [[self sharedRatesServer] appId]];
        NSURL *url = [NSURL URLWithString:stringUrl];
        
        dispatch_queue_t backgroundQueue = dispatch_queue_create("2gis.proofjob.anotherthread", 0);
        dispatch_async(backgroundQueue, ^
        {
            NSData *urlData = [NSData dataWithContentsOfURL:url];
            
            dispatch_async(dispatch_get_main_queue(), ^
            {
                NSError *error;
                if(urlData)
                {
                    NSArray *serverResponce = [NSJSONSerialization JSONObjectWithData:urlData options:kNilOptions error:&error];
            
                    //All we need is rates array.
                    //So we should get it contents if it's not empty and put it to the dictionary.
                    if([[serverResponce valueForKey:ratesKey] count] > 0)
                    {
                        [[self sharedRatesServer] setRates:[serverResponce valueForKey:ratesKey]];
                        //we should notify our coltroller about incoming data
                        [self serverResponded];
                    }
                }
            });
        });
    }
    else
    {
        [NSException raise:@"There is an error with connection to remote server!"
                    format:@"AppId have not been set up!"];
    }
}

/**
 Method sends notification about server response
 */
+ (void)serverResponded
{
    [[NSNotificationCenter defaultCenter] postNotificationName:dataArrivedNotification object:self];
}

@end
