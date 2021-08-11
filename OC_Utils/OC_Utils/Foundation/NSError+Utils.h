//
//  NSError+Utils.h
//  OC_Utils
//
//  Created by WWQ on 2021/8/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


extern NSString * const UDisplayErrorDomain;

extern NSString * const UNetworkErrorDomain;
extern NSInteger const UNetworkErrorCodeUnknown;
extern NSInteger const UNetworkErrorCodeJSONParsingFailed;
extern NSInteger const UNetworkErrorCodeConvertingDataToStringFailed;
extern NSInteger const UNetworkErrorCodeDataFormatNotAsExpected;
extern NSInteger const UNetworkErrorCodeCannotConvertToCustomValue;

extern NSString * const UObjectParsingErrorDomain;
extern NSInteger const UObjectParsingErrorCodeNotSPTObjectSubclass;

extern NSString * const UServerBusinessErrorKeyDomain;

extern NSString * const UNetworkErrorKeyData;
extern NSString * const UNetworkErrorKeyErrorCodeString;


@interface NSError (Utils)


/**
 错误提示
 */
@property (nonatomic, nullable, copy, readonly) NSString *u_illegalWord;

/**
 错误Code
 */
@property (nonatomic, copy, readonly) NSString *u_errorCodeString;

/**
 生成Error

 @param code 编码
 @param localizedDescription 描述
 */
+ (NSError *)u_sportErrorWithCode:(NSInteger)code localizedDescription:(NSString *)localizedDescription;

/**
 生成一个新的 Error
 
 @param userInfo the infomation to append
 */
- (NSError *)u_errorByAddingUserInfo:(NSDictionary<NSErrorUserInfoKey, id> *)userInfo;

/**
 是否是网络不能访问的错误
 */
@property (nonatomic, readonly) BOOL u_isNetworkUnreachableError;

/**
 显示错误信息
 */
@property (nonatomic, readonly, copy) NSString *u_displayDescription;


@property (nonatomic, readonly) BOOL u_isErrorForDisplay;


@property (nonatomic, nullable, readonly, strong) NSError *u_underlyingErrorForDisplayError;


+ (NSError *)u_displayErrorWithUnderlyingError:(NSError *)underlyingError localizedDescription:(NSString *)localizedDescription;


@end

NS_ASSUME_NONNULL_END
