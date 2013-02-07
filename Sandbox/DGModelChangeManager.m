//
//  DGModelChangeManager.m
//  Sandbox
//
//  Created by Daniel Green on 12/01/2013.
//  Copyright (c) 2013 Daniel Green. All rights reserved.
//

#import "DGModelChangeManager.h"
#import "ActiveRecord+NoPrivate.h"
#import "SyncModelChange.h"
#import "NSArray+Accessors.h"
#import "DGObjectMapper.h"

@implementation DGModelChangeManager
- (void)objectWasCreated:(SyncRecord*)object {
    if ([object isKindOfClass:[SyncModelChange class]] ||
        [object isKindOfClass:[SyncModelChangeValue class]]) {
        return;
    }
    
    NSLog(@"object was created: %@", object);
    NSLog(@"changed: %@", object.changedColumns);

    DGObjectMapper *mapper = [DGObjectMapper new];
    NSArray *properties = [mapper propertiesForObject:[object class]];

    
    NSMutableArray *values = [NSMutableArray new];
    [properties each:^(NSString* property) {
        SyncModelChangeValue *value = [SyncModelChangeValue new];
        value.field = [NSString stringWithFormat:@"%@", property];
        value.value = [mapper propertyValue:property fromObject:object];
        //[value save];
        [values addObject:value];
    }];
    
    NSLog(@"___________");
    NSLog(@"%@", values);
    NSLog(@"___________");

    SyncModelChange *modelChange = [SyncModelChange new];
    modelChange.className = NSStringFromClass([object class]);
    modelChange.when = [NSDate new];
    modelChange.action = @"new";
    [modelChange save];
    [values each:^(id value) {
        [modelChange addSyncModelChangeValue:(ActiveRecord*)value];
    }];
    [modelChange save];
}

- (void)objectWasUpdated:(id)object {
    if ([object isKindOfClass:[SyncModelChange class]] ||
        [object isKindOfClass:[SyncModelChangeValue class]]) {
        return;
    }
    NSLog(@"object was updated: %@", [object changedColumns]);
    
}

- (void)objectWasDeleted:(id)object {
    if ([object isKindOfClass:[SyncModelChange class]] ||
        [object isKindOfClass:[SyncModelChangeValue class]]) {
        return;
    }
    NSLog(@"object was deleted: %@", object);
}
@end
