//
//  NSString+DGString.m
//  Sandbox
//
//  Created by Daniel Green on 05/12/2012.
//  Copyright (c) 2012 Daniel Green. All rights reserved.
//

#import "NSString+DGString.h"
#import "DGActiveSupportInflector.h"
@implementation NSString (DGString)

- (void)log {
    NSLog(@"%@", self);
}

- (void)logWithPrefix:(NSString*)prefix {
    NSLog(@"%@", prefix);
    [self log];
}

- (NSString *)camelToSnake {
    NSMutableString *output = [NSMutableString string];
    NSCharacterSet *uppercase = [NSCharacterSet uppercaseLetterCharacterSet];
    BOOL previousCharacterWasUppercase = FALSE;
    BOOL currentCharacterIsUppercase = FALSE;
    unichar currentChar = 0;
    unichar previousChar = 0;
    for (NSInteger idx = 0; idx < [self length]; idx += 1) {
        previousChar = currentChar;
        currentChar = [self characterAtIndex:idx];
        previousCharacterWasUppercase = currentCharacterIsUppercase;
        currentCharacterIsUppercase = [uppercase characterIsMember:currentChar];
        
        if (!previousCharacterWasUppercase && currentCharacterIsUppercase && idx > 0) {
            [output appendString:@"_"];
        } else if (previousCharacterWasUppercase && !currentCharacterIsUppercase) {
            if ([output length] > 1) {
                unichar charTwoBack = [output characterAtIndex:[output length]-2];
                if (charTwoBack != '_') {
                    [output insertString:@"_" atIndex:[output length]-1];
                }
            }
        }
        [output appendString:[[NSString stringWithCharacters:&currentChar length:1] lowercaseString]];
    }
    return output;
}

- (NSString*)snakeToCamel {
    //"remote_id" -> "remote id"
    NSString *s = [self stringByReplacingOccurrencesOfString:@"_" withString:@" "];
    
    //"remote id" -> "Remote Id"
    s = [s capitalizedString];
    
    //"Remote Id" -> "RemoteId"
    s = [s stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    //"RemoteId" -> "remoteId"
    return [s firstCharacterLowercase];
}

- (NSString*)firstCharacterLowercase {
    if ([self length] > 0) {
        return [self stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[self substringToIndex:1] lowercaseString]];
    } else {
        return self;
    }
}

- (NSString*)firstCharacterUppercase {
    if ([self length] > 0) {
        return [self stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[self substringToIndex:1] uppercaseString]];
    } else {
        return self;
    }
}

- (NSString *)pluralize {
    static DGActiveSupportInflector *inflector = nil;
    if (!inflector) {
        inflector = [[DGActiveSupportInflector alloc] init];
    }
	
    return [inflector pluralize:self];
}


- (NSString *)singularize {
    static DGActiveSupportInflector *inflector = nil;
    if (!inflector) {
        inflector = [[DGActiveSupportInflector alloc] init];
    }
	
    return [inflector singularize:self];
}

- (NSString*)addKey:(NSString*)key withValue:(NSString*)value {
    if ([self contains:@"?"]) {
        return [self stringByAppendingFormat:@"&%@=%@", key, value];
    } else {
        return [self stringByAppendingFormat:@"?%@=%@", key, value];
    }
}

- (BOOL)contains:(NSString*)substring {
    return ([self rangeOfString:substring].location != NSNotFound);
}

@end
