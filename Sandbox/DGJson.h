//
//  DGJson.h
//  Sandbox
//
//  Created by Daniel Green on 06/12/2012.
//  Copyright (c) 2012 Daniel Green. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DGJson : NSObject

+ (NSString*)jsonFromObject:(NSObject*)object;
+ (id)parsedJson:(NSString*)json;

@end
