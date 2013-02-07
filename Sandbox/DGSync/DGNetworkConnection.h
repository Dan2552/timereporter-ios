//
//  DGNetworkConnection.h
//  Sandbox
//
//  Created by Daniel Green on 05/12/2012.
//  Copyright (c) 2012 Daniel Green. All rights reserved.
//

#import <Foundation/Foundation.h>


@class DGNetworkConnection;

@interface DGNetworkConnection: NSObject<NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSHTTPURLResponse *receivedResponse;
@property (readonly, nonatomic, strong) NSString *json;
@property (readonly, nonatomic, strong) id parsedJson;
@property (readonly, nonatomic, strong) NSString *error;
@property (readonly, nonatomic, assign) NSInteger statusCode;

- (void)requestType:(NSString*)type host:(NSString*)host path:(NSString*)path data:(NSData*)data onResponse:(DGNetworkReponse)response;

- (BOOL)responseWasJson;
@end
