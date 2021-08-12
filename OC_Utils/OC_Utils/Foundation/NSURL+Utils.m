//
//  NSURL+Utils.m
//  OC_Utils
//
//  Created by WWQ on 2021/8/11.
//

#import "NSURL+Utils.h"

@implementation NSURL (Utils)


- (NSDictionary<NSString *, NSString *> *)u_queryParameters {
    static NSString * const allowedStrings = @":/?&=";
    NSMutableCharacterSet *allowedCharacterSet = [NSMutableCharacterSet characterSetWithCharactersInString:allowedStrings];
    [allowedCharacterSet formUnionWithCharacterSet:[NSCharacterSet letterCharacterSet]];
    [allowedCharacterSet formUnionWithCharacterSet:[NSCharacterSet decimalDigitCharacterSet]];
    NSString *urlString = [self.absoluteString stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];
    NSURL *url = [NSURL URLWithString:urlString];
    NSString *query = url.query;
    NSArray *components = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    for (NSString *component in components) {
        NSArray *pair = [component componentsSeparatedByString:@"="];
        if (pair.count != 2) {
            continue;
        }
        NSString *key = pair[0];
        NSString *value = pair[1];
        key = key.stringByRemovingPercentEncoding;
        value = value.stringByRemovingPercentEncoding;
        parameters[key] = value;
    }
    return parameters;
}


- (nullable NSURL *)u_URLByAppendingQueryParameters:(NSDictionary *)parameters {
    if (parameters.count == 0) {
        return self;
    }
    
    NSMutableArray *componts = [NSMutableArray array];
    NSMutableDictionary *originQueryParameters = [[self u_queryParameters] mutableCopy];
    [originQueryParameters addEntriesFromDictionary:parameters];
    [originQueryParameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [componts addObject:[NSString stringWithFormat:@"%@=%@", key, obj]];
    }];
    NSString *newQueryString = [componts componentsJoinedByString:@"&"];
    
    NSString *originalURLString = self.absoluteString;
    NSString *originalQuery = self.query;
    NSString *newURLString = nil;
    if (originalQuery.length == 0) {
        newURLString = [originalURLString stringByAppendingString:[NSString stringWithFormat:@"?%@", newQueryString]];
    } else {
        newURLString = [originalURLString stringByReplacingOccurrencesOfString:originalQuery withString:newQueryString];
    }
    
    NSURL *newURL = [NSURL URLWithString:newURLString];
    
    return newURL;
}

@end
