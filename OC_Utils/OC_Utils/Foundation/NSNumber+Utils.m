//
//  NSNumber+Utils.m
//  OC_Utils
//
//  Created by WWQ on 2021/8/11.
//

#import "NSNumber+Utils.h"

@implementation NSNumber (Utils)


- (NSString *)u_formattedString {
    if ([NSStringFromClass(self.class) isEqualToString:@"__NSCFBoolean"]) {
        return [NSString stringWithFormat:@"%@", self];
    }
    
    CFNumberRef cfNumber = (__bridge CFNumberRef)self;
    if (cfNumber == NULL) {
        return [NSString stringWithFormat:@"%@", self];
    }
    
    if (CFNumberIsFloatType(cfNumber)) {
        return [NSString stringWithFormat:@"%g", self.doubleValue];
    }
    
    return [NSString stringWithFormat:@"%@", self];
}


@end
