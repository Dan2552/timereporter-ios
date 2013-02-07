//
//  SyncRecord.m
//  Sandbox
//
//  Created by Daniel Green on 06/12/2012.
//  Copyright (c) 2012 Daniel Green. All rights reserved.
//

#import "SyncRecord.h"
#import "ActiveRecord+NoPrivate.h"
#import "DGNetwork.h"
#import "DGNetworkConnection.h"
#import "DGJson.h"
#import "DGObjectMapper.h"
#import "DGModelChangeManager.h"

@implementation SyncRecord

@dynamic remoteId;

+ (id)new {
    return [self newRecord];
}

+ (id)first {
    if ([self count] > 0) {
        return [[self allRecords] objectAtIndex:0];
    } else {
        return nil;
    }
}

+ (NSString*)remotePath {
    NSString *className = NSStringFromClass([self class]);
    return [NSString stringWithFormat:@"/%@", [[className pluralize] camelToSnake]];
}

+ (void)getIndex {
    [[DGNetwork instance] getPath:[self remotePath] onResponse:^(DGNetworkConnection *connection) {
        NSLog(@"SyncRecord: fetch result, status code %d", connection.receivedResponse.statusCode);

        if ([connection responseWasJson]) {

        } else {
            [connection.error log];
        }
    }];
}

+ (void)get:(NSString*)action {
    [[DGNetwork instance] getPath:[self pathWithAction:action] onResponse:^(DGNetworkConnection *connection) {
        
    }];
}

+ (void)delete:(NSString*)action {
    [[DGNetwork instance] deletePath:[self pathWithAction:action] onResponse:^(DGNetworkConnection *connection) {
        
    }];
}

+ (NSString*)pathWithAction:(NSString*)action {
    return [NSString stringWithFormat:@"%@/%@", [self remotePath], action];
}

- (void)post:(NSString*)action {
    NSString *path = [NSString stringWithFormat:@"%@/%@", [[self class] remotePath], action];
    [[DGNetwork instance] postPath:path withData:[self toJson] onResponse:^(DGNetworkConnection *connection) {
        NSLog(@"SyncRecord: post result, status code %d", connection.receivedResponse.statusCode);
#warning TODO: probably want to update the posted object with the recieved values
    }];
}

- (NSString*)toJson {
    return [DGJson jsonFromObject:self];
}

- (BOOL)updateAttributes:(NSDictionary*)dictionary {
    DGObjectMapper *mapper = [DGObjectMapper new];
    [mapper updateObject:self withAttributes:dictionary];
    return [self save];
}


#pragma mark - iActiveRecord overrides
- (BOOL)save {
    BOOL new = [self isNew];
    BOOL saved = [super save];
    if (new && saved) [[DGModelChangeManager new] objectWasCreated: self];
    return saved;
}

- (BOOL)update {
#warning TODO: make sure it saves before calling objectWasUpdated
    if (![self isNew]) [[DGModelChangeManager new] objectWasUpdated: self];
    return [super update];
}
@end
