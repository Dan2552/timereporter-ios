//
//  SyncRecord.h
//  Sandbox
//
//  Created by Daniel Green on 06/12/2012.
//  Copyright (c) 2012 Daniel Green. All rights reserved.
//

#import "ActiveRecord.h"

@protocol AuthentificationDelegate <NSObject>

- (void)authentificationNeeded;

@end

@interface SyncRecord : ActiveRecord

@property (nonatomic, strong) NSNumber *remoteId;

+ (void)getIndex;
+ (void)get:(NSString*)action;
+ (void)delete:(NSString*)action;
- (void)post:(NSString*)action;

+ (id)new;
+ (id)first;
- (BOOL)updateAttributes:(NSDictionary*)dictionary;

#pragma mark - iActiveRecord overrides
- (BOOL)save;
- (BOOL)update;
@end
