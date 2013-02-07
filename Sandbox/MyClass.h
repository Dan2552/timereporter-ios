//
//  MyClass.h
//  Sandbox
//
//  Created by Daniel Green on 15/11/2012.
//  Copyright (c) 2012 Daniel Green. All rights reserved.
//

#import "SyncRecord.h"

@interface MyClass : SyncRecord
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *dynamicOne;
@property (nonatomic, strong) NSString *dynamicTwo;
@property (nonatomic, strong) NSString *test;
@end
