//
//  NSMutableArray+Utils.h
//  OC_Utils
//
//  Created by WWQ on 2021/8/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray<ObjectType> (Utils)


/**
 生成一定容量的数组

 @param capacity 容量
 @return 数组
 */
+ (NSMutableArray<ObjectType> *)u_nullArrayWithCapacity:(NSUInteger)capacity;

/**
 根据正则删除符合的对象

 @param predicate 正则
 */
- (void)u_removeObjectsPassingTest:(BOOL (^)(id obj, NSUInteger idx, BOOL *stop))predicate;

/**
 超出最大容量删除老的数据

 @param maxCount 最大容量
 */
- (void)u_removeLatterObjectsToKeepObjectsNoMoreThan:(NSInteger)maxCount;

/**
 将 index 位置处的 object 替换成 anotherObject
 */
- (void)u_replaceObjectAtIndex:(NSUInteger)index withObject:(ObjectType)anotherObject;

/**
 将anObject替换成anotherObject
 */
- (void)u_replaceObject:(ObjectType)anObject withObject:(ObjectType)anotherObject;

/**
 插入对象

 @param anObject 对象
 */
- (void)u_insertUniqueObject:(ObjectType)anObject;

/**
 将对象插入某一位置

 @param anObject 对象
 @param index 位置
 */
- (void)u_insertUniqueObject:(ObjectType)anObject atIndex:(NSInteger)index;

/**
 从otherArray插入对象（去重）

 @param otherArray 另一个数据
 */
- (void)u_insertUniqueObjectsFromArray:(NSArray<ObjectType> *)otherArray;

/**
 insert a nullable object, if the object is nil, does nothing
 
 @param anObject an object to insert
 @param index the index where to insert
 */
- (void)u_insertNullableObject:(nullable ObjectType)anObject atIndex:(NSUInteger)index;

/**
 从otherArray追加对象

 @param otherArray 另一个数组
 */
- (void)u_appendUniqueObjectsFromArray:(NSArray<ObjectType> *)otherArray;

/**
 添加可空的对象

 @param anObject 可能为nil的对象
 */
- (void)u_appendNullableObject:(nullable ObjectType)anObject;


/**
 将对象移到另一个位置

 @param object 对象
 @param index 另外的位置
 */
- (void)u_moveObject:(ObjectType)object toIndex:(NSUInteger)index;

/**
 从otherArray中获取下一页数据并加入当前数组

 @param otherArray 另一个数组
 @param pageSize 一页数量
 */
- (BOOL)u_appendObjectsInLastPageFromArray:(NSArray<ObjectType> *)otherArray pageSize:(NSUInteger)pageSize;


@end

NS_ASSUME_NONNULL_END
