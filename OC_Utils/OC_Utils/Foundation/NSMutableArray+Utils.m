//
//  NSMutableArray+Utils.m
//  OC_Utils
//
//  Created by WWQ on 2021/8/11.
//

#import "NSMutableArray+Utils.h"
#import "NSArray+Utils.h"

@implementation NSMutableArray (Utils)


+ (NSMutableArray *)u_nullArrayWithCapacity:(NSUInteger)capacity {
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:capacity];
    for (NSInteger i = 0; i < capacity; i++) {
        [array addObject:[NSNull null]];
    }
    return array;
}


- (void)u_removeObjectsPassingTest:(BOOL (^)(id obj, NSUInteger idx, BOOL *stop))predicate {
    NSIndexSet *indexes = [self indexesOfObjectsPassingTest:predicate];
    [self removeObjectsAtIndexes:indexes];
}


- (void)u_removeLatterObjectsToKeepObjectsNoMoreThan:(NSInteger)maxCount {
    if ([self count] > maxCount) {
        [self removeObjectsInRange:NSMakeRange(maxCount, [self count] - maxCount)];
    }
}


- (void)u_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anotherObject {
    if (anotherObject == nil) {
        return;
    }
    
    if (index >= self.count) {
        return;
    }
    
    [self replaceObjectAtIndex:index withObject:anotherObject];
}


- (void)u_replaceObject:(id)anObject withObject:(id)anotherObject {
    NSInteger index = [self indexOfObject:anObject];
    if (index != NSNotFound) {
        [self replaceObjectAtIndex:index withObject:anotherObject];
    }
}


- (void)u_insertUniqueObject:(id)anObject {
    [self u_insertUniqueObject:anObject atIndex:[self count]];
}


- (void)u_insertUniqueObject:(id)anObject atIndex:(NSInteger)index {
    if (index < 0 || index > [self count]) {
        return;
    }
    
    if (anObject == nil) {
        return;
    }
    
    for (id object in self) {
        if ([object isEqual:anObject]) {
            return;
        }
    }
    
    [self insertObject:anObject atIndex:index];
}


- (void)u_insertUniqueObjectsFromArray:(NSArray *)otherArray {
    NSArray *objectsToInsert = [otherArray u_arrayByRemovingObjectsFromArray:self];
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [objectsToInsert count])];
    [self insertObjects:objectsToInsert atIndexes:indexSet];
}


- (void)u_insertNullableObject:(nullable id)anObject atIndex:(NSUInteger)index {
    if (anObject == nil) {
        return;
    }
    
    if (index > self.count) {
        return;
    }
    
    [self insertObject:anObject atIndex:index];
}


- (void)u_appendUniqueObjectsFromArray:(NSArray *)otherArray {
    NSArray *objectsToAppend = [otherArray u_arrayByRemovingObjectsFromArray:self];
    [self addObjectsFromArray:objectsToAppend];
}


- (void)u_appendNullableObject:(nullable id)anObject {
    if (anObject == nil) {
        return;
    }
    
    [self addObject:anObject];
}


- (void)u_moveObject:(id)object toIndex:(NSUInteger)index {
    if (index >= [self count]) {
        return;
    }
    
    NSInteger originIndex = [self indexOfObject:object];
    if (originIndex == NSNotFound) {
        return;
    }
    
    if (originIndex == index) {
        return;
    }
    
    [self removeObject:object];
    [self insertObject:object atIndex:index];
}


- (BOOL)u_appendObjectsInLastPageFromArray:(NSArray *)otherArray pageSize:(NSUInteger)pageSize {
    NSInteger location = (NSInteger)(self.count % pageSize);
    NSInteger length = otherArray.count - location;
    
    if (location < 0 || location > otherArray.count - 1 || length < 0) {
        return NO;
    }
    
    NSArray *objectsToAppend = [otherArray subarrayWithRange:NSMakeRange(location, length)];
    [self addObjectsFromArray:objectsToAppend];
    
    return YES;
}



@end
