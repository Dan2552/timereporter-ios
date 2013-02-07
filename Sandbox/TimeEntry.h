//
//  TimeEntry.h
//  Sandbox
//
//  Created by Daniel Green on 06/12/2012.
//  Copyright (c) 2012 Daniel Green. All rights reserved.
//

#import "SyncRecord.h"
@interface TimeEntry : SyncRecord

@property (nonatomic, strong) NSDate *entryDatetime;
@property (nonatomic, strong) NSNumber *duration;
@property (nonatomic, strong) NSNumber *projectId;
@property (nonatomic, strong) NSString *comment;
@property (nonatomic, strong) NSNumber *userId;

@end
