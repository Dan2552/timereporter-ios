//
//  ActiveRecord+NoPrivate.m
//  Sandbox
//
//  Created by Daniel Green on 13/01/2013.
//  Copyright (c) 2013 Daniel Green. All rights reserved.
//

#import "ActiveRecord+NoPrivate.h"
#import "ActiveRecord_Private.h"
@implementation ActiveRecord (NoPrivate)

-(BOOL)isNew {
    return isNew;
}

-(NSMutableSet*)changedColumns {
    return _changedColumns;
}

@end
