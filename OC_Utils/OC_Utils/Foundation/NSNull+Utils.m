//
//  NSNull+Utils.m
//  OC_Utils
//
//  Created by WWQ on 2021/8/11.
//

#import "NSNull+Utils.h"
#import <objc/message.h>

#define UNullObjectsArray @[@"", @0, @{}, @[]]

@implementation NSNull (Utils)


- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    if (!signature) {
        for (NSObject *obj in UNullObjectsArray) {
            signature = [obj methodSignatureForSelector:aSelector];
            if (signature) {
                //判断是否返回对象 主要是处理 空数组根据索引取对象
                if (strcmp(signature.methodReturnType, "@") == 0) {
                    signature = [[NSNull null] methodSignatureForSelector:@selector(__u_safe_nil)];
                }
                break;
            }
        }
    }
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    //判断是否返回对象 主要是处理 空数组根据索引取对象
    if (strcmp(anInvocation.methodSignature.methodReturnType, "@") == 0) {
           anInvocation.selector = @selector(__u_safe_nil);
           [anInvocation invokeWithTarget:self];
           return;
    }
    
    for (NSObject *objc in UNullObjectsArray) {
        if ([objc respondsToSelector:anInvocation.selector]) {
            [anInvocation invokeWithTarget:objc];
            return;
        }
    }
    [self doesNotRecognizeSelector:anInvocation.selector];
}

- (id)__u_safe_nil {
    return nil;
}


@end
