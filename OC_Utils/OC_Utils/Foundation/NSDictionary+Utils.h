//
//  NSDictionary+Utils.h
//  OC_Utils
//
//  Created by WWQ on 2021/8/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary<__covariant KeyType, __covariant ObjectType> (Utils)


/**
 字典转url字符串
 */
- (NSString *)u_stringRepresentationByURLEncoding;

/**
 根据key取字符串
 
 @param key key字符串
 */
- (NSString *)u_stringForKey:(KeyType)key;

/**
 根据key取integer
 
 @param key key字符串
 */
- (NSInteger)u_integerForKey:(KeyType)key;

/**
 根据key取double
 
 @param key key字符串
 */
- (double)u_doubleForKey:(KeyType)key;

/**
 根据key取bool
 
 @param key key字符串
 */
- (BOOL)u_boolForKey:(KeyType)key;

/**
 根据key取数组

 @param key key字符串
 */
- (NSArray<id> *)u_arrayForKey:(KeyType)key;

/**
 根据key取字典

 @param key key字符串
 */
- (NSDictionary<id, id> *)u_dictionaryForKey:(KeyType)key;

/**
 字典转json字符串
 */
- (nullable NSString *)u_JSONString;

/**
 字典转json字符串
 */
- (NSArray<KeyType> *)u_duplicateKeysWithDictionary:(NSDictionary<KeyType, id> *)otherDictionary;

/**
 是否包含某key

 @param key key名称
 */
- (BOOL)u_hasKey:(KeyType)key;



@end

NS_ASSUME_NONNULL_END
