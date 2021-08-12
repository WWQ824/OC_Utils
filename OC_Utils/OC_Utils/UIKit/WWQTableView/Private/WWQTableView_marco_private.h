//
//  WWQTableView_marco_private.h
//  OC_Utils
//
//  Created by WWQ on 2021/8/12.
//

#ifndef WWQTableView_marco_private_h
#define WWQTableView_marco_private_h
#import <objc/runtime.h>

#define RETAIN_ASSOCIATION_METHOD(_set,_get,_type) \
- (void)_set:(_type)value { \
    objc_setAssociatedObject(self, @selector(_get), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC); \
} \
- (_type)_get { \
    return  objc_getAssociatedObject(self, _cmd); \
} \


#define COPY_ASSOCIATION_METHOD(_set,_get,_type,_defaultValue) \
- (void)_set:(_type)value { \
    objc_setAssociatedObject(self, @selector(_get), value, OBJC_ASSOCIATION_COPY_NONATOMIC); \
} \
- (_type)_get { \
    _type t =  objc_getAssociatedObject(self, _cmd); \
    if(t == nil){\
        t = _defaultValue; \
    } \
    return t;\
} \

#define WEAK_ASSOCIATION_METHOD(_set,_get,_type) \
- (void)_set:(_type)value { \
    __weak id weakObject = value; \
    objc_setAssociatedObject(self, @selector(_get),^{ \
        return weakObject; \
    }, OBJC_ASSOCIATION_COPY_NONATOMIC); \
} \
- (_type)_get { \
    id(^block)(void) =  objc_getAssociatedObject(self, _cmd);\
    if (block) {\
        return block();\
    }\
    return nil;\
} \


#define BOOL_ASSOCIATION_METHOD(_set,_get) \
- (void)_set:(BOOL)value { \
    objc_setAssociatedObject(self, @selector(_get), @(value), OBJC_ASSOCIATION_COPY_NONATOMIC); \
} \
- (BOOL)_get { \
    return  [objc_getAssociatedObject(self, _cmd) boolValue]; \
} \


#define INT_ASSOCIATION_METHOD(_set,_get,_type) \
- (void)_set:(_type)value { \
    objc_setAssociatedObject(self,@selector(_get), @(value), OBJC_ASSOCIATION_COPY_NONATOMIC); \
} \
- (_type)_get { \
    return  [objc_getAssociatedObject(self, _cmd) integerValue]; \
} \

#endif /* WWQTableView_marco_private_h */
