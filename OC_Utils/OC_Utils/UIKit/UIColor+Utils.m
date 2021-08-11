//
//  UIColor+Utils.m
//  OC_Utils
//
//  Created by WWQ on 2021/8/11.
//

#import "UIColor+Utils.h"

@implementation UIColor (Utils)


+ (UIColor *)u_salmon {
    return [UIColor u_colorWithIntegerRed:255 green:119 blue:119];
}


+ (UIColor *)u_bloodOrange {
    return [UIColor u_colorWithIntegerRed:245 green:1 blue:18];
}


+ (UIColor *)u_orangeYellow {
    return [UIColor u_colorWithIntegerRed:255 green:168 blue:0];
}


+ (UIColor *)u_greyish {
    return [UIColor u_colorWithIntegerRed:184 green:184 blue:184];
}


+ (UIColor *)u_warmGrey {
    return [UIColor colorWithWhite:118.0f/255.0f alpha:1];
}


+ (UIColor *)u_paleGrey {
    return [UIColor u_colorWithIntegerRed:237 green:239 blue:243];
}


+ (UIColor *)u_fadedBlue {
    return [UIColor u_colorWithIntegerRed:111 green:140 blue:206];
}


+ (UIColor *)u_pinkishGrey {
    return [UIColor u_colorWithIntegerRed:196 green:198 blue:198];
}


+ (UIColor *)u_purpleBrown {
    return [UIColor u_colorWithIntegerRed:50 green:40 blue:44];
}


+ (UIColor *)u_carolinaBlue {
    return [UIColor u_colorWithIntegerRed:145 green:176 blue:255];
}


+ (UIColor *)u_backgroundGrey {
    return [UIColor u_colorWithIntegerRed:237 green:240 blue:242];
}


+ (UIColor *)u_barTintColor {
    return [UIColor u_colorWithIntegerRed:50 green:39 blue:43];
}


+ (UIColor *)u_clayBrown {
    return [UIColor u_colorWithIntegerRed:177 green:102 blue:56];
}


+ (UIColor *)u_dirtBrown {
    return [UIColor u_colorWithIntegerRed:110 green:87 blue:46];
}


+ (UIColor *)u_shallowGrey {
    return [UIColor u_colorWithIntegerRed:242 green:242 blue:242];
}


+ (UIColor *)u_black_alpha_40 {
    return [UIColor u_colorWithIntegerRed:0 green:0 blue:0 alpha:0.4];
}


+ (UIColor *)u_selectedCellColor {
    return [UIColor u_colorWithIntegerRed:217 green:217 blue:217];
}


+ (UIColor *)u_mostlyWhite {
    return [UIColor u_colorWithIntegerRed:251 green:251 blue:251];
}


+ (UIColor *)u_silver {
    return [UIColor u_colorWithIntegerRed:204 green:204 blue:204];
}


+ (UIColor *)u_baseYellow {
    return [UIColor u_colorWithHexString:@"ffda44"];
}


+ (UIColor *)u_blackColor {
    return [UIColor u_colorWithHexString:@"#141318"];
}


+ (UIColor *)u_titleRagularColor {
    return [UIColor colorWithRed:0.66 green:0.66 blue:0.67 alpha:1];
}


- (NSString *)u_hexString {
    //TODO wjd
    CGFloat r = 0;
    CGFloat g = 0;
    CGFloat b = 0;
    CGFloat a = 0;
    [self getRed:&r green:&g blue:&b alpha:&a];
    return [NSString stringWithFormat:@"#%02X%02X%02X", (unsigned int)(r * 255.0),(unsigned int)(g * 255.0),(unsigned int)(b * 255.0)];
}


+ (UIColor *)u_colorWithIntegerRed:(NSInteger)r green:(NSInteger)g blue:(NSInteger)b {
    return [self u_colorWithIntegerRed:r green:g blue:b alpha:1.0f];
}


+ (UIColor *)u_colorWithIntegerRed:(NSInteger)r green:(NSInteger)g blue:(NSInteger)b alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((CGFloat)(r) / 255.0f) green:((CGFloat)(g) / 255.0f) blue:((CGFloat)(b) / 255.0f) alpha:alpha];
}


+ (nullable UIColor *)u_colorWithHexString:(NSString *)string {
    CGFloat r, g, b, a;
    if (u_convertHexStringToRGBAValue(string, &r, &g, &b, &a)) {
        return [UIColor colorWithRed:r green:g blue:b alpha:a];
    }
    return nil;
}


+ (nullable UIColor *)u_colorWithHexString:(NSString *)string alpha:(CGFloat)alpha {
    CGFloat r, g, b, a;
    if (u_convertHexStringToRGBAValue(string, &r, &g, &b, &a)) {
        return [UIColor colorWithRed:r green:g blue:b alpha:alpha];
    }
    return nil;
}


static BOOL u_convertHexStringToRGBAValue(NSString *str, CGFloat *r, CGFloat *g, CGFloat *b, CGFloat *a) {
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    str = [[str stringByTrimmingCharactersInSet:set] uppercaseString];
    if ([str hasPrefix:@"#"]) {
        str = [str substringFromIndex:1];
    } else if ([str hasPrefix:@"0X"]) {
        str = [str substringFromIndex:2];
    }
    
    NSUInteger length = [str length];
    //         RGB            RGBA          RRGGBB        RRGGBBAA
    if (length != 3 && length != 4 && length != 6 && length != 8) {
        return NO;
    }
    
    //RGB,RGBA,RRGGBB,RRGGBBAA
    if (length < 5) {
        *r = u_integerValueFromHexString([str substringWithRange:NSMakeRange(0, 1)]) / 255.0f;
        *g = u_integerValueFromHexString([str substringWithRange:NSMakeRange(1, 1)]) / 255.0f;
        *b = u_integerValueFromHexString([str substringWithRange:NSMakeRange(2, 1)]) / 255.0f;
        if (length == 4) {
            *a = u_integerValueFromHexString([str substringWithRange:NSMakeRange(3, 1)]) / 255.0f;
        } else {
            *a = 1;
        }
    } else {
        *r = u_integerValueFromHexString([str substringWithRange:NSMakeRange(0, 2)]) / 255.0f;
        *g = u_integerValueFromHexString([str substringWithRange:NSMakeRange(2, 2)]) / 255.0f;
        *b = u_integerValueFromHexString([str substringWithRange:NSMakeRange(4, 2)]) / 255.0f;
        if (length == 8) {
            *a = u_integerValueFromHexString([str substringWithRange:NSMakeRange(6, 2)]) / 255.0f;
        } else {
            *a = 1;
        }
    }
    return YES;
}


static inline NSUInteger u_integerValueFromHexString(NSString *str) {
    uint32_t result = 0;
    sscanf([str UTF8String], "%X", &result);
    return result;
}


@end
