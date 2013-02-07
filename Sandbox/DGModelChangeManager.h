//
//  DGModelChangeManager.h
//  Sandbox
//
//  Created by Daniel Green on 12/01/2013.
//  Copyright (c) 2013 Daniel Green. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SyncRecord;
@interface DGModelChangeManager : NSObject

- (void)objectWasCreated:(SyncRecord*)object;
- (void)objectWasUpdated:(SyncRecord*)object;
- (void)objectWasDeleted:(SyncRecord*)object;

@end
