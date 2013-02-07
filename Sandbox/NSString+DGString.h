//
//  NSString+DGString.h
//  Sandbox
//
//  Created by Daniel Green on 05/12/2012.
//  Copyright (c) 2012 Daniel Green. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DGString)

- (void)log;
- (void)logWithPrefix:(NSString*)prefix;

- (NSString*)camelToSnake;
- (NSString*)snakeToCamel;
- (NSString*)pluralize;
- (NSString*)singularize;
- (NSString*)firstCharacterUppercase;
- (NSString*)firstCharacterLowercase;

- (NSString*)addKey:(NSString*)key withValue:(NSString*)value;

- (BOOL)contains:(NSString*)substring;
@end
