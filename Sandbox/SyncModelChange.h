//
//  SyncModelChange.h
//  Sandbox
//
//  Created by Daniel Green on 28/12/2012.
//  Copyright (c) 2012 Daniel Green. All rights reserved.
//

#import "SyncRecord.h"
#import "SyncModelChangeValue.h"

@interface SyncModelChange : SyncRecord

@property (nonatomic, strong) NSString *className;
@property (nonatomic, strong) NSDate *when; //To make sure the migrations are ran in order on remote
@property (nonatomic, strong) NSString *action; //new, updated, deleted

has_many_dec(SyncModelChangeValue, syncModelChangeValues, ARDependencyNullify)

@end
