//
//  DGNetworkConnection.m
//  Sandbox
//
//  Created by Daniel Green on 05/12/2012.
//  Copyright (c) 2012 Daniel Green. All rights reserved.
//

#import "DGNetworkConnection.h"
#import "DGNetwork.h"
#import "DGJson.h"
@interface DGNetworkConnection () 
    @property (nonatomic, strong) NSString *json;
    @property (nonatomic, strong) NSString *error;
    @property (nonatomic, strong) id parsedJson;

    @property (nonatomic, strong) NSMutableData *receivedData;
    @property (nonatomic, copy) DGNetworkReponse responseBlock;
    @property (nonatomic, assign) NSInteger statusCode;

@end

@implementation DGNetworkConnection

@synthesize receivedData = _receivedData;

-(NSMutableData *)receivedData {
    if (!_receivedData) _receivedData = [NSMutableData data];
    return _receivedData;
}

- (void)requestType:(NSString*)type host:(NSString*)host path:(NSString*)path data:(NSData*)data onResponse:(DGNetworkReponse)response {
    self.responseBlock = response;
    
    DGNetwork *network = [DGNetwork instance];
    
    NSLog(@"data request %@: %@", type, [NSString stringWithFormat:@"%@%@", host, path]);
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", host, path]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60.0];
    [request setHTTPMethod:[type uppercaseString]];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    if (network.csrfToken)
        [request setValue:network.csrfToken forHTTPHeaderField:@"X-Csrf-Token"];
    
    if (data) {
        [request setValue:[NSString stringWithFormat:@"%d", [data length]] forHTTPHeaderField:@"Content-Length"];
        [request setHTTPBody:data];
    }
    [NSURLConnection connectionWithRequest:request delegate:self];
}


- (BOOL)responseWasJson {
    return [[self.receivedResponse MIMEType] isEqualToString:@"application/json"];
}

#pragma mark NSURLConnectionDataDelegate methods

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    self.receivedResponse = (NSHTTPURLResponse*)response;
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[self.receivedData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSString *receivedString = [[NSString alloc] initWithData:self.receivedData encoding:NSUTF8StringEncoding];
    NSLog(@"%@", [self.receivedResponse allHeaderFields]);
    
    NSString *csrfToken = [[self.receivedResponse allHeaderFields] valueForKey:@"X-Csrf-Token"];
    if (csrfToken)
        [DGNetwork instance].csrfToken = csrfToken;
    
    
    if ([self responseWasJson]) {
        self.json = receivedString;
        self.parsedJson = [DGJson parsedJson:self.json];
        
        NSLog(@"DGNetworkConnection RECIEVED json: %@", self.parsedJson);
    } else {
        self.error = receivedString;
        NSLog(@"DGNetworkConnection RECIEVED error: %@", self.error);
    }
    
    self.statusCode = [self.receivedResponse statusCode];
    
    if (self.statusCode == 401) {
        //Recieved the message:
        //"You need to sign in or sign up before continuing."
        //So we need to notify the application that sign in is required
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DGSignInRequired" object:nil];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DGSignDismiss" object:nil];
    }
    self.responseBlock(self);
}


@end
