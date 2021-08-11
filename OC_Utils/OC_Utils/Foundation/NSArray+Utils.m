//
//  NSArray+Utils.m
//  OC_Utils
//
//  Created by WWQ on 2021/8/11.
//

#import "NSMutableArray+Utils.h"
#import "NSArray+Utils.h"

@implementation NSArray (Utils)


- (NSArray *)u_arrayWithObjectsPassingTest:(BOOL (^)(id obj, NSUInteger idx, BOOL *stop))predicate {
    NSIndexSet *indexes = [self indexesOfObjectsPassingTest:predicate];
    return [self objectsAtIndexes:indexes];
}


- (NSArray *)u_arrayByRemovingObjectsOfClass:(Class)aClass {
    NSMutableArray *array = [NSMutableArray arrayWithArray:self];
    [array u_removeObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:aClass]) {
            return YES;
        }
        else return NO;
    }];
    return [[NSArray alloc] initWithArray:array];
}


- (NSArray *)u_arrayByKeepingObjectsOfClass:(Class)aClass {
    NSMutableArray *array = [NSMutableArray arrayWithArray:self];
    [array u_removeObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:aClass]) {
            return NO;
        }
        else return YES;
    }];
    return [[NSArray alloc] initWithArray:array];
}


- (NSArray *)u_arrayByRemovingObjectsFromArray:(NSArray *)otherArray {
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        return ![otherArray containsObject:evaluatedObject];
    }];
    return [self filteredArrayUsingPredicate:predicate];
}


- (id)u_objectPassingTest:(BOOL (^)(id obj, NSUInteger idx, BOOL *stop))predicate {
    NSUInteger index = [self indexOfObjectPassingTest:predicate];
    if (index != NSNotFound) {
        return self[index];
    }
    return nil;
}


- (id)u_nullableObjectAtIndex:(NSInteger)index {
    if (index < 0) {
        return nil;
    }
    if (index >= self.count) {
        return nil;
    }
    return self[index];
}


- (NSArray *)u_duplicateObjectsWithArray:(NSArray *)otherArray {
    if (otherArray.count == 0) {
        return [[NSArray alloc] init];
    }
    
    NSMutableArray *duplicateObjects = [[NSMutableArray alloc] init];
    for (id object in otherArray) {
        if ([self containsObject:object]) {
            [duplicateObjects addObject:object];
        }
    }
    
    return [duplicateObjects copy];
}


- (NSArray *)u_mapUsing:(id (^)(id originalObject, NSUInteger index))handler {
    NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:[self count]];
    for (NSInteger i = 0; i < [self count]; i++) {
        id resultObject = handler(self[i], i);
        if (resultObject == nil) {
            continue;
        }
        [tempArray addObject:resultObject];
    }
    return [NSArray arrayWithArray:tempArray];
}


- (NSString *)u_JSONString {
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self
                                                   options:0
                                                     error:&error];
    if (error) {
        NSLog(@"[SportsKit] > Array > ERROR: cannot convert array to JSON string: %@", self);
        return nil;
    }
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}


- (NSString *)descriptionWithLocale:(id)locale {
    return [self descriptionPrivate];
}


- (NSString *)debugDescription {
    return [self descriptionPrivate];
}


- (NSString *)descriptionPrivate {
    NSMutableString *string = [NSMutableString stringWithFormat:@"%lu (\n", (unsigned long)self.count];
    
    for (id obj in self) {
        [string appendFormat:@"\t%@, \n", obj];
    }
    
    [string appendString:@")"];
    
    return string;
}


@end
