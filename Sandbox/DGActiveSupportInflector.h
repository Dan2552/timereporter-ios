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

@interface DGActiveSupportInflector : NSObject {
  NSMutableSet* uncountableWords;
  NSMutableArray* pluralRules;
  NSMutableArray* singularRules;
}

- (void)addInflectionsFromFile:(NSString*)path;
- (void)addInflectionsFromDictionary:(NSDictionary*)dictionary;

- (void)addUncountableWord:(NSString*)string;
- (void)addIrregularRuleForSingular:(NSString*)singular plural:(NSString*)plural;
- (void)addPluralRuleFor:(NSString*)rule replacement:(NSString*)replacement;
- (void)addSingularRuleFor:(NSString*)rule replacement:(NSString*)replacement;

- (NSString*)pluralize:(NSString*)string;
- (NSString*)singularize:(NSString*)string;

@end
