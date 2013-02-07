//
//  DGNetwork.m
//  Sandbox
//
//  Created by Daniel Green on 05/12/2012.
//  Copyright (c) 2012 Daniel Green. All rights reserved.
//

#import "DGNetwork.h"
#import "DGNetworkConnection.h"

@implementation DGNetwork

static DGNetwork *singleton;

+ (DGNetwork*)instance {
    if (!singleton) {
        singleton = [[DGNetwork alloc] init];
        singleton.host = @"http://localhost:3000";
    }
    return singleton;
}

- (void)getPath:(NSString*)path onResponse:(DGNetworkReponse)response {
    DGNetworkConnection *connection = [DGNetworkConnection new];
    [connection requestType:@"GET" host:self.host path:path data:nil onResponse:response];
}

- (void)postPath:(NSString*)path withData:(NSString*)dataString onResponse:(DGNetworkReponse)response {
    DGNetworkConnection *connection = [DGNetworkConnection new];
    NSData *data = [self dataFromString:dataString];
    [connection requestType:@"POST" host:self.host path:path data:data onResponse:response];
}

- (void)deletePath:(NSString*)path onResponse:(DGNetworkReponse)response {
    DGNetworkConnection *connection = [DGNetworkConnection new];
    [connection requestType:@"DELETE" host:self.host path:path data:nil onResponse:response];
}

- (NSData*)dataFromString:(NSString*)string {
    NSData *data = [NSData dataWithBytes:[string UTF8String] length:[string length]];
    return data;
}


#warning TODO: keep track of amount of connections being held. Make NotificationCenter notify when first connection is made, and when last connection is lost so UI can be handled

@end
