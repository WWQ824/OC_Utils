//
//  NSURL+Utils.h
//  OC_Utils
//
//  Created by WWQ on 2021/8/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURL (Utils)


@property (nonatomic, copy, readonly, nullable) NSDictionary<NSString *, NSString *> *u_queryParameters;

- (nullable NSURL *)u_URLByAppendingQueryParameters:(nullable NSDictionary<NSString *, NSString *> *)parameters;


@end

NS_ASSUME_NONNULL_END
