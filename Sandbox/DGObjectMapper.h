//
//  DGObjectMapper.h
//  Sandbox
//
//  Created by Daniel Green on 06/12/2012.
//  Copyright (c) 2012 Daniel Green. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DGObjectMapper : NSObject


- (void)updateObject:(NSObject*)object withAttributes:(NSDictionary*)dictionary;
- (NSArray*)propertiesForObject:(Class)cls;
- (id)propertyValue:(NSString*)property fromObject:(NSObject*)object;
@end
