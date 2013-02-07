//
//  SyncModelChangeValue.h
//  Sandbox
//
//  Created by Daniel Green on 02/02/2013.
//  Copyright (c) 2013 Daniel Green. All rights reserved.
//

#import "SyncRecord.h"
#import "SyncModelChange.h"
@interface SyncModelChangeValue : SyncRecord

@property (nonatomic, strong) NSNumber *syncModelChangeId;
@property (nonatomic, strong) NSString *field;
@property (nonatomic, strong) NSString *value;

belongs_to_dec(SyncModelChange, syncModelChange, ARDependencyNullify)

@end
