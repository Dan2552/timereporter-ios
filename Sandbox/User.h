//
//  User.h
//  Sandbox
//
//  Created by Daniel Green on 14/12/2012.
//  Copyright (c) 2012 Daniel Green. All rights reserved.
//

#import "SyncRecord.h"

@interface User : SyncRecord

@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *password;

@end
