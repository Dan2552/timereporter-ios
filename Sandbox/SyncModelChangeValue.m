//
//  SyncModelChangeValue.m
//  Sandbox
//
//  Created by Daniel Green on 02/02/2013.
//  Copyright (c) 2013 Daniel Green. All rights reserved.
//

#import "SyncModelChangeValue.h"

@implementation SyncModelChangeValue

@dynamic syncModelChangeId;
@dynamic field;
@dynamic value;

belongs_to_imp(SyncModelChange, syncModelChange, ARDependencyNullify)

@end
