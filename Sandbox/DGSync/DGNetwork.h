//
//  DGNetwork.h
//  Sandbox
//
//  Created by Daniel Green on 05/12/2012.
//  Copyright (c) 2012 Daniel Green. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DGNetwork : NSObject

@property (nonatomic, strong) NSString *host;

@property (nonatomic, strong) NSString *csrfToken;


- (void)getPath:(NSString*)path onResponse:(DGNetworkReponse)response;
- (void)postPath:(NSString*)path withData:(NSString*)dataString onResponse:(DGNetworkReponse)response;
- (void)deletePath:(NSString*)path onResponse:(DGNetworkReponse)response;
+ (DGNetwork*)instance;


@end
