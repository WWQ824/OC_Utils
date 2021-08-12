//
//  NSError+Utils.m
//  OC_Utils
//
//  Created by WWQ on 2021/8/11.
//

#import "NSError+Utils.h"


NSString * const UDisplayErrorDomain = @"com.wwq.utilsgroup.error.domain.display";

NSString * const UNetworkErrorDomain = @"com.wwq.utilsgroup.error.domain.network";
NSInteger const UNetworkErrorCodeUnknown = 0;
NSInteger const UNetworkErrorCodeJSONParsingFailed = 1;
NSInteger const UNetworkErrorCodeConvertingDataToStringFailed = 2;
NSInteger const UNetworkErrorCodeDataFormatNotAsExpected = 3;
NSInteger const UNetworkErrorCodeCannotConvertToCustomValue = 4;

NSString * const UObjectParsingErrorDomain = @"com.wwq.utilsgroup.error.domain.objectparsing";
NSInteger const UObjectParsingErrorCodeNotUObjectSubclass = 1;

NSString * const UServerBusinessErrorKeyDomain = @"com.wwq.utilsgroup.error.domain.serverbussiness";

NSString * const UNetworkErrorKeyData = @"com.wwq.utilsgroup.error.key.data";
NSString * const UNetworkErrorKeyErrorCodeString = @"com.wwq.utilsgroup.network_errorcodestring";


@implementation NSError (Utils)


- (NSString *)u_illegalWord {
    if (self.code != 104) {
        return nil;
    }
    
    NSDictionary *data = self.userInfo[UNetworkErrorKeyData];
    if (data == nil) {
        return nil;
    }
    if (![data isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    NSArray *riskList = data[@"riskList"];
    if (riskList == nil) {
        return nil;
    }
    if (![riskList isKindOfClass:[NSArray class]]) {
        return nil;
    }
    
    NSDictionary *field = [riskList firstObject];
    if (field == nil) {
        return nil;
    }
    if (![field isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    NSArray *risk = field[@"risk"];
    if (risk == nil) {
        return nil;
    }
    if (![risk isKindOfClass:[NSArray class]]) {
        return nil;
    }
    
    NSString *word = [risk firstObject];
    if (word == nil) {
        return nil;
    }
    if (![word isKindOfClass:[NSString class]]) {
        return nil;
    }
    //    ycw
    return [NSString stringWithFormat:@"【%@】", word];
    //    return word;
}


- (NSString *)u_errorCodeString {
    NSString *stringInUserInfo = self.userInfo[UNetworkErrorKeyErrorCodeString];
    if ([stringInUserInfo isKindOfClass:[NSString class]]) {
        return stringInUserInfo;
    }
    
    return [NSString stringWithFormat:@"%ld", (long)self.code];
}


+ (NSError *)u_sportErrorWithCode:(NSInteger)code localizedDescription:(NSString *)localizedDescription {
    return [NSError errorWithDomain:UNetworkErrorDomain code:code userInfo:@{NSLocalizedDescriptionKey: localizedDescription}];
}


- (NSError *)u_errorByAddingUserInfo:(NSDictionary<NSErrorUserInfoKey, id> *)userInfo {
    NSMutableDictionary<NSErrorUserInfoKey, id> *originalUserInfo = [self.userInfo mutableCopy];
    [originalUserInfo addEntriesFromDictionary:userInfo];
    return [NSError errorWithDomain:self.domain code:self.code userInfo:originalUserInfo];
}


- (BOOL)u_isNetworkUnreachableError {
    if ([self.domain isEqualToString:NSURLErrorDomain]) {
        return YES;
    }
    if ([self.domain isEqualToString:(NSString *)kCFErrorDomainCFNetwork]) {
        return YES;
    }
    
    if ([self.domain isEqualToString:@"com.alamofire.error.serialization.response"]) {
        if ((self.code == NSURLErrorBadServerResponse) || (self.code == NSURLErrorCannotDecodeContentData)) {
            return YES;
        }
    }
    
    return NO;
}


- (NSString *)u_displayDescription {
    NSString *displayDescription = self.localizedDescription;
    
    if (self.u_isNetworkUnreachableError) {
        displayDescription = @"网络不给力，请稍后再试";
        if ([self.domain isEqualToString:NSURLErrorDomain]) {
            if (self.code == NSURLErrorNotConnectedToInternet) {
                displayDescription = @"网络连接已断开，请检查设置";
            }
        }
    } else if (self.code == 3840 || self.code == 4) {
        displayDescription = @"网络不给力，请稍后再试";
    }
    
    if (displayDescription.length == 0) {
        displayDescription = @"未知错误";
    }
    
    return displayDescription;
}


- (BOOL)u_isErrorForDisplay {
    return [self.domain isEqualToString:UDisplayErrorDomain];
}


- (NSError *)u_underlyingErrorForDisplayError {
    if (!self.u_isErrorForDisplay) {
        return self;
    }
    
    NSError *underlyingError = self.userInfo[NSUnderlyingErrorKey];
    if (underlyingError == nil) {
        return nil;
    }
    
    if (![underlyingError isKindOfClass:NSError.class]) {
        return nil;
    }
    
    return underlyingError;
}


+ (NSError *)u_displayErrorWithUnderlyingError:(NSError *)underlyingError localizedDescription:(NSString *)localizedDescription {
    NSParameterAssert(underlyingError);
    if (underlyingError == nil) {
        return [[NSError alloc] initWithDomain:UDisplayErrorDomain code:0 userInfo:nil];
    }
    
    if (![underlyingError isKindOfClass:NSError.class]) {
        return [[NSError alloc] initWithDomain:UDisplayErrorDomain code:0 userInfo:nil];
    }
    
    if (localizedDescription.length == 0) {
        localizedDescription = @"未知错误";
    }
    
    NSDictionary *userInfo = @{NSUnderlyingErrorKey: underlyingError, NSLocalizedDescriptionKey: localizedDescription};
    NSError *displayError = [[NSError alloc] initWithDomain:UDisplayErrorDomain code:0 userInfo:userInfo];
    
    return displayError;
}



@end
