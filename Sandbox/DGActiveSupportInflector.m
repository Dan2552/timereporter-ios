//    Copyright (c) 2009-2011 Tom Ward
//
//    Permission is hereby granted, free of charge, to any person obtaining
//    a copy of this software and associated documentation files (the
//                                                                "Software"), to deal in the Software without restriction, including
//    without limitation the rights to use, copy, modify, merge, publish,
//    distribute, sublicense, and/or sell copies of the Software, and to
//    permit persons to whom the Software is furnished to do so, subject to
//    the following conditions:
//
//    The above copyright notice and this permission notice shall be
//    included in all copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//    EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
//    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//    NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
//    LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
//    OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
//    WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


#import "DGActiveSupportInflector.h"

@interface ActiveSupportInflectorRule : NSObject
{
  NSString* rule;
  NSString* replacement;
}

@property (retain) NSString* rule;
@property (retain) NSString* replacement;

+ (ActiveSupportInflectorRule*) rule:(NSString*)rule replacement:(NSString*)replacement;

@end

@implementation ActiveSupportInflectorRule
  @synthesize rule;
  @synthesize replacement;

+ (ActiveSupportInflectorRule*) rule:(NSString*)rule replacement:(NSString*)replacement {
  ActiveSupportInflectorRule* result;
  if ((result = [[self alloc] init])) {
    [result setRule:rule];
    [result setReplacement:replacement];
  }
  return result;
}

@end


@interface DGActiveSupportInflector(PrivateMethods)
- (NSString*)_applyInflectorRules:(NSArray*)rules toString:(NSString*)string;
@end

@implementation DGActiveSupportInflector

- (DGActiveSupportInflector*)init {
  if ((self = [super init])) {
    uncountableWords = [[NSMutableSet alloc] init];
    pluralRules = [[NSMutableArray alloc] init];
    singularRules = [[NSMutableArray alloc] init];
    [self addInflectionsFromFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"DGActiveSupportInflector" ofType:@"plist"]];
  } 
  return self; 
}

- (void)addInflectionsFromFile:(NSString*)path {
  [self addInflectionsFromDictionary:[NSDictionary dictionaryWithContentsOfFile:path]];
}

- (void)addInflectionsFromDictionary:(NSDictionary*)dictionary {
  for (NSArray* pluralRule in [dictionary objectForKey:@"pluralRules"]) {
    [self addPluralRuleFor:[pluralRule objectAtIndex:0] replacement:[pluralRule objectAtIndex:1]];
  }
  
  for (NSArray* singularRule in [dictionary objectForKey:@"singularRules"]) {
    [self addSingularRuleFor:[singularRule objectAtIndex:0] replacement:[singularRule objectAtIndex:1]];
  }
  
  for (NSArray* irregularRule in [dictionary objectForKey:@"irregularRules"]) {
    [self addIrregularRuleForSingular:[irregularRule objectAtIndex:0] plural:[irregularRule objectAtIndex:1]];
  }
  
  for (NSString* uncountableWord in [dictionary objectForKey:@"uncountableWords"]) {
    [self addUncountableWord:uncountableWord];
  }
}

- (void)addUncountableWord:(NSString*)string {
  [uncountableWords addObject:string];
}

- (void)addIrregularRuleForSingular:(NSString*)singular plural:(NSString*)plural {
  NSString* singularRule = [NSString stringWithFormat:@"%@$", plural];
  [self addSingularRuleFor:singularRule replacement:singular];
  
  NSString* pluralRule = [NSString stringWithFormat:@"%@$", singular];
  [self addPluralRuleFor:pluralRule replacement:plural];  
}

- (void)addPluralRuleFor:(NSString*)rule replacement:(NSString*)replacement {
  [pluralRules insertObject:[ActiveSupportInflectorRule rule:rule replacement: replacement] atIndex:0];
}

- (void)addSingularRuleFor:(NSString*)rule replacement:(NSString*)replacement {
  [singularRules insertObject:[ActiveSupportInflectorRule rule:rule replacement: replacement] atIndex:0];
}

- (NSString*)pluralize:(NSString*)singular {
  return [self _applyInflectorRules:pluralRules toString:singular];
}

- (NSString*)singularize:(NSString*)plural {
  return [self _applyInflectorRules:singularRules toString:plural];
}

- (NSString*)_applyInflectorRules:(NSArray*)rules toString:(NSString*)string {
  if ([uncountableWords containsObject:string]) {
    return string;
  }
  else {
    for (ActiveSupportInflectorRule* rule in rules) {
      NSRange range = NSMakeRange(0, [string length]);
      NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:[rule rule] options:0 error:nil];
      if ([regex firstMatchInString:string options:0 range:range]) {
        // NSLog(@"rule: %@, replacement: %@", [rule rule], [rule replacement]);
        return [regex stringByReplacingMatchesInString:string options:0 range:range withTemplate:[rule replacement]];
      }
    }
    return string;
  }  
}

@end
