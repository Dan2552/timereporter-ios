//
//  DGJson.m
//  Sandbox
//
//  Created by Daniel Green on 06/12/2012.
//  Copyright (c) 2012 Daniel Green. All rights reserved.
//

#import "DGJson.h"
#import "DGObjectMapper.h"
#import "ObjectiveSugar.h"
#import "SBJson.h"
#import "DGNetwork.h"
@implementation DGJson

+ (NSString*)jsonFromObject:(NSObject*)object {
    DGObjectMapper *mapper = [DGObjectMapper new];
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    [[mapper propertiesForObject:[object class]] each:^(id key) {
        id value = [mapper propertyValue:key fromObject:object];
        [dictionary setValue:value forKey:key];
    }];
    
    NSMutableDictionary *parent = [NSMutableDictionary dictionary];
    NSString *parentKey = NSStringFromClass([object class]);
    parentKey = [parentKey camelToSnake];
    [parent setValue:dictionary forKey:parentKey];
    
    
    NSString *result = [parent JSONRepresentation];
    
    return result;
}

+ (id)parsedJson:(NSString*)json {
    NSString *jsonString = json;
    SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
    id parsedObject = [jsonParser objectWithString:jsonString];
    if (!parsedObject) {
        NSLog(@"JSON PARSE FAILED: %@", jsonString);
    }
    if ([parsedObject isKindOfClass:[NSArray class]]) {
        NSLog(@"DGJson: parsed as array");
        
    } else if ([parsedObject isKindOfClass:[NSDictionary class]]) {
        NSLog(@"DGJson: parsed as dictionary");
    }
    
    parsedObject = [self localizeParsedObject:parsedObject];
    
    return parsedObject;
}

+ (id)localizeParsedObject:(id)object {
    if ([object isKindOfClass:[NSArray class]]) {
        NSMutableArray *newArray = [NSMutableArray new];
        for (id child in object) {
            [newArray addObject:[self localizeParsedObject:child]];
        }
        return newArray;
    } else if ([object isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *newDictionary = [NSMutableDictionary new];
        
        [((NSDictionary*)object) each:^(id key, id value) {
            if ([key isEqualToString:@"id"]) {
                [newDictionary setValue:value forKey:@"remoteId"];
            } else {
                [newDictionary setValue:value forKey:[key snakeToCamel]];
            }
        }];
        
        return newDictionary;
    }
    return object;
}

@end
