//
//  NSArray+Utils.h
//  OC_Utils
//
//  Created by WWQ on 2021/8/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray<ObjectType> (Utils)


/**
 获取符合正则的数据

 @param predicate 正则的block
 */
- (NSArray<ObjectType> *)u_arrayWithObjectsPassingTest:(BOOL (^)(id obj, NSUInteger idx, BOOL *stop))predicate;

/**
 移除class为aClass的对象
 */
- (NSArray<ObjectType> *)u_arrayByRemovingObjectsOfClass:(Class)aClass;

/**
 保留class为aClass的对象
 */
- (NSArray<ObjectType> *)u_arrayByKeepingObjectsOfClass:(Class)aClass;

/**
 将otherArray里面的对象从当前数组移除
 */
- (NSArray<ObjectType> *)u_arrayByRemovingObjectsFromArray:(NSArray<ObjectType> *)otherArray;

/**
 获取符合正则的对象
 */
- (nullable ObjectType)u_objectPassingTest:(BOOL (^)(id obj, NSUInteger idx, BOOL *stop))predicate;

/**
 取出某一位置的对象，有边界检查
 */
- (nullable ObjectType)u_nullableObjectAtIndex:(NSInteger)index;

/**
 duplicate objects with other array.
 */
- (NSArray<ObjectType> *)u_duplicateObjectsWithArray:(NSArray<ObjectType> *)otherArray;

/**
 用handler进行匹配
 */
- (NSArray *)u_mapUsing:(id (^)(ObjectType originalObject, NSUInteger index))handler;

/**
 数组转json字符串
 */
- (nullable NSString *)u_JSONString;

@end

NS_ASSUME_NONNULL_END
