//
//  ActiveRecord+NoPrivate.h
//  Sandbox
//
//  Created by Daniel Green on 13/01/2013.
//  Copyright (c) 2013 Daniel Green. All rights reserved.
//

#import "ActiveRecord.h"

@interface ActiveRecord (NoPrivate)
-(BOOL)isNew;
-(NSMutableSet*)changedColumns;
@end
