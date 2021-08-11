//
//  NSDictionary+Utils.m
//  OC_Utils
//
//  Created by WWQ on 2021/8/11.
//

#import "NSDictionary+Utils.h"
#import "NSString+Utils.h"
#import "NSNumber+Utils.h"
#import "NSArray+Utils.h"


@implementation NSDictionary (Utils)


- (NSString *)u_stringRepresentationByURLEncoding {
    NSMutableArray *pairs = [NSMutableArray array];
    for (NSString *key in [self allKeys]) {
        id object = [self objectForKey:key];
        if (![object isKindOfClass:[NSString class]]) {
            continue;
        }
        [pairs addObject:[NSString stringWithFormat:@"%@=%@", key, [object u_URLEncoded]]];
    }
    return [pairs componentsJoinedByString:@"&"];
}


- (NSString *)u_stringForKey:(id)key {
    id object = self[key];
    
    if (object == nil) {
        return @"";
    }
    
    if ([object isKindOfClass:NSNull.class]) {
        return @"";
    }
    
    if ([object isKindOfClass:NSNumber.class]) {
        NSNumber *number = (NSNumber *)object;
        return number.u_formattedString;
    }
    
    if (![object isKindOfClass:NSString.class]) {
        return [NSString stringWithFormat:@"%@", object];
    }
    
    return object;
}


- (NSInteger)u_integerForKey:(id)key {
    id object = self[key];
    if ([object respondsToSelector:@selector(integerValue)]) {
        return [object integerValue];
    }
    return 0;
}


- (double)u_doubleForKey:(id)key {
    id object = self[key];
    if ([object respondsToSelector:@selector(doubleValue)]) {
        return [object doubleValue];
    }
    return 0.0;
}


- (BOOL)u_boolForKey:(id)key {
    id value = self[key];
    if (value == nil || value == [NSNull null]) {
        return NO;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value boolValue];
    }
    if ([value isKindOfClass:[NSString class]]) {
        return [value boolValue];
    }
    return NO;
}


- (NSArray<id> *)u_arrayForKey:(id)key {
    id value = self[key];
    if (value == nil) {
        return [[NSArray alloc] init];
    }
    
    if ([value isKindOfClass:[NSArray class]]) {
        return (NSArray<id> *)value;
    }
    
    return [[NSArray alloc] init];
}


- (NSDictionary<id, id> *)u_dictionaryForKey:(id)key {
    id value = self[key];
    if (value == nil) {
        return [[NSDictionary alloc] init];
    }
    
    if ([value isKindOfClass:[NSDictionary class]]) {
        return (NSDictionary<id, id> *)value;
    }
    
    return [[NSDictionary alloc] init];
}


- (nullable NSString *)u_JSONString {
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self
                                                   options:0
                                                     error:&error];
    if (error) {
        NSLog(@"[SportsKit] > Dictionary > ERROR: cannot convert dictionary to JSON string: %@", self);
        return nil;
    }
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}


- (NSArray *)u_duplicateKeysWithDictionary:(NSDictionary *)otherDictionary {
    if (otherDictionary.count == 0) {
        return [[NSArray alloc] init];
    }
    
    return [self.allKeys u_duplicateObjectsWithArray:otherDictionary.allKeys];
}


- (BOOL)u_hasKey:(id)key {
    return [self.allKeys containsObject:key];
}


- (NSString *)descriptionWithLocale:(id)locale {
    return [self descriptionPrivate];
}


- (NSString *)debugDescription {
    return [self descriptionPrivate];
}


- (NSString *)descriptionPrivate {
    NSArray *allKeys = [self allKeys];
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"{\t\n "];
    for (NSString *key in allKeys) {
        id value= self[key];
        [str appendFormat:@"\t \"%@\" = %@,\n",key, value];
    }
    [str appendString:@"}"];
    return str;
}


@end
