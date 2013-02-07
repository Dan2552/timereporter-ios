//
//  DGObjectMapper.m
//  Sandbox
//
//  Created by Daniel Green on 06/12/2012.
//  Copyright (c) 2012 Daniel Green. All rights reserved.
//

#import "DGObjectMapper.h"
#import <objc/runtime.h>
#import "SyncRecord.h"
#import "ObjectiveSugar.h"
@implementation DGObjectMapper

- (void)updateObject:(NSObject*)object withAttributes:(NSDictionary*)dictionary {
    NSLog(@"DGOBJECTMAPPER: UPDATE OBJECT CALLED");
    NSArray *propertyList = [self propertiesForObject:[object class]];
    propertyList = [propertyList arrayByAddingObjectsFromArray:[self propertiesForObject:[SyncRecord class]]];
    
    for (NSString *attribute in propertyList) {
        [self typeOfPropertyNamed:attribute forObject:[object class]];
#warning todo
    }
}

- (id)propertyValue:(NSString*)property fromObject:(NSObject*)object {
    NSString *getter = [NSString stringWithFormat:@"%@", property];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    id value = [object performSelector:NSSelectorFromString(getter)];
#pragma clang diagnostic pop
    return value;
}

- (NSArray*)propertiesForObject:(Class)cls {
    u_int count;
    objc_property_t* properties = class_copyPropertyList([cls class], &count);
    NSMutableArray* propertyArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count ; i++)
    {
        const char* propertyName = property_getName(properties[i]);
        [propertyArray addObject:[NSString  stringWithCString:propertyName encoding:NSUTF8StringEncoding]];
    }
    free(properties);
    return [NSArray arrayWithArray:propertyArray];
}

- (NSString*)typeOfPropertyNamed:(NSString*)name forObject:(Class)cls {
	objc_property_t property = class_getProperty(cls, [name UTF8String]);
	if (property == nil) return nil;
    const char * typeIdentifierCC = (const char *) property_getTypeString(property);
    NSString *typeIdentifier = [NSString stringWithUTF8String:typeIdentifierCC];
    
    
    for (int i = 0; i < typeIdentifier.length; i++) {
        NSLog(@"%d: %c", i, [typeIdentifier characterAtIndex:i]);
    }

    
	return typeIdentifier;
}

const char * property_getTypeString(objc_property_t property) {
	const char * attrs = property_getAttributes(property);
	if (attrs == NULL)
		return (NULL);
    
	static char buffer[256];
	const char * e = strchr(attrs, ',');
	if (e == NULL)
		return (NULL);
    
	int len = (int)(e - attrs);
	memcpy( buffer, attrs, len );
	buffer[len] = '\0';
    
	return (buffer);
}

@end
