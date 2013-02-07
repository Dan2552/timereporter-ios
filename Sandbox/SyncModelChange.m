//
//  SyncModelChange.m
//  Sandbox
//
//  Created by Daniel Green on 28/12/2012.
//  Copyright (c) 2012 Daniel Green. All rights reserved.
//

#import "SyncModelChange.h"

@implementation SyncModelChange

@dynamic className;
@dynamic when;
@dynamic action;

has_many_imp(SyncModelChangeValue, syncModelChangeValues, ARDependencyNullify)

@end
