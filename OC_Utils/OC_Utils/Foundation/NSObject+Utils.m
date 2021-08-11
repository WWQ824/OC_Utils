//
//  NSObject+Utils.m
//  OC_Utils
//
//  Created by WWQ on 2021/8/11.
//

#import "NSObject+Utils.h"

@implementation NSObject (Utils)


- (BOOL)u_notNilOrEmpty {
    if ((NSNull *)self == [NSNull null]) {
        return NO;
    }
    
    if ([self respondsToSelector:@selector(count)]) {
        if ([(id)self count] == 0) {
            return NO;
        }
    }
    
    if ([self respondsToSelector:@selector(length)]) {
        if ([(id)self length] == 0) {
            return NO;
        }
    }
    
    return YES;
}

@end
