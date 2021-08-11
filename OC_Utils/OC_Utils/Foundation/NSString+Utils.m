//
//  NSString+Utils.m
//  OC_Utils
//
//  Created by WWQ on 2021/8/10.
//

#import <CommonCrypto/CommonDigest.h>
#import "NSString+Utils.h"
#import "NSData+Utils.h"


@implementation NSString (Utils)


- (BOOL)u_containsEmoji {
    __block BOOL containsEmoji = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         const unichar hs = [substring characterAtIndex:0];
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     containsEmoji = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 containsEmoji = YES;
             }
         } else {
             if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                 containsEmoji = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 containsEmoji = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 containsEmoji = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 containsEmoji = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a) {
                 containsEmoji = YES;
             }
         }
     }];
    return containsEmoji;
}


- (BOOL)u_isPureIntNumber {
    NSScanner *scanner = [NSScanner scannerWithString:self];
    int val;
    return [scanner scanInt:&val] && [scanner isAtEnd];
}


- (BOOL)u_isEmail {
    return [self u_matchesRegularExpressionPattern:@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"];
}


- (BOOL)u_isIDCard {
    if (self.length == 15) {
        for (NSUInteger i = 0; i < self.length; i++) {
            unichar character = [self characterAtIndex:i];
            if ('0' <= character && character <= '9') {
                continue;
            }
            return NO;
        }
        return YES;
    }
    
    if (self.length == 18) {
        NSInteger weights[17] = {7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2};
        NSInteger total = 0;
        for (NSUInteger i = 0; i < self.length - 1; i++) {
            unichar character = [self characterAtIndex:i];
            if ('0' <= character && character <= '9') {
                NSInteger integer = (NSInteger)(character - '0');
                total += integer * weights[i];
                continue;
            }
            return NO;
        }
        NSInteger result = (12 - total % 11) % 11;
        unichar character = [self characterAtIndex:17];
        if (result == 10) {
            if (character == 'x') {
                return YES;
            }
            if (character == 'X') {
                return YES;
            }
            return NO;
        }
        
        if (result == (NSInteger)(character - '0')) {
            return YES;
        }
    }
    
    return NO;
}


- (BOOL)u_isChineseCharacter {
    NSString *regex = @"^[\u4E00-\u9FA5]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}


- (BOOL)u_isNumberOrEnglishOrChineseCharacter {
    NSString *regex = @"[a-zA-Z0-9\u4e00-\u9fa5][a-zA-Z0-9\u4e00-\u9fa5]*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}


- (BOOL)u_isPureDecimalDigits {
    NSString *string = [self stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if (string.length > 0) {
        return NO;
    }
    return YES;
}


- (BOOL)u_containInvalidString {
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"@／：；（）¥「」＂、[]{}#%-*+=_\\|~＜＞$€^•'@#$%^&*()_+'\""];
    NSString *trimmedString = [self stringByTrimmingCharactersInSet:set];
    if ([self u_matchesRegularExpressionPattern:trimmedString]) {
        return NO;
    }
    return YES;
}


- (BOOL)u_isEmptyAfterTrimmingWhitespaceAndNewlineCharacters {
    return [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0;
}


- (NSString *)u_md5 {
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)(strlen(cStr)), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}


- (NSString *)u_sha1String {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}


- (NSData *)u_base64Data {
    NSMutableData *mutableData = nil;
    
    unsigned long ixtext = 0;
    unsigned long lentext = 0;
    unsigned char ch = 0;
    unsigned char inbuf[4] = {0};
    unsigned char outbuf[3] = {0};
    short i = 0;
    short ixinbuf = 0;
    BOOL flignore = NO;
    BOOL flendtext = NO;
    NSData *base64Data = nil;
    const unsigned char *base64Bytes = nil;
    
    // Convert the string to ASCII data.
    base64Data = [self dataUsingEncoding:NSASCIIStringEncoding];
    base64Bytes = [base64Data bytes];
    mutableData = [NSMutableData dataWithCapacity:base64Data.length];
    lentext = base64Data.length;
    
    while (YES) {
        if (ixtext >= lentext) {
            break;
        }
        
        ch = base64Bytes[ixtext++];
        flignore = NO;
        
        if ((ch >= 'A') && (ch <= 'Z')) {
            ch = ch - 'A';
        } else if ((ch >= 'a') && (ch <= 'z')) {
            ch = ch - 'a' + 26;
        } else if ((ch >= '0') && (ch <= '9')) {
            ch = ch - '0' + 52;
        } else if (ch == '+') {
            ch = 62;
        } else if (ch == '=') {
            flendtext = YES;
        } else if (ch == '/') {
            ch = 63;
        } else {
            flignore = YES;
        }
        
        if (!flignore) {
            short ctcharsinbuf = 3;
            BOOL flbreak = NO;
            
            if (flendtext) {
                if (!ixinbuf) {
                    break;
                }
                if ((ixinbuf == 1) || (ixinbuf == 2)) {
                    ctcharsinbuf = 1;
                } else {
                    ctcharsinbuf = 2;
                }
                ixinbuf = 3;
                flbreak = YES;
            }
            
            inbuf[ixinbuf++] = ch;
            
            if (ixinbuf == 4) {
                ixinbuf = 0;
                outbuf[0] = (inbuf[0] << 2) | ((inbuf[1] & 0x30) >> 4);
                outbuf[1] = ((inbuf[1] & 0x0F) << 4) | ((inbuf[2] & 0x3C) >> 2);
                outbuf[2] = ((inbuf[2] & 0x03) << 6) | (inbuf[3] & 0x3F);
                
                for (i = 0; i < ctcharsinbuf; i++) {
                    [mutableData appendBytes:&outbuf[i] length:1];
                }
            }
            
            if (flbreak) {
                break;
            }
        }
    }
    
    NSData *data = [[NSData alloc] initWithData:mutableData];
    return data;
}


- (NSString *)u_base64Encoded {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:(NSDataBase64EncodingOptions)0];
}

- (NSString *)u_base64EncodedSafe {
    NSMutableString *base64Str = [[NSMutableString alloc] initWithString:self.u_URLEncoded];
    base64Str = (NSMutableString * )[base64Str stringByReplacingOccurrencesOfString:@"+" withString:@"-"];
    base64Str = (NSMutableString * )[base64Str stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    base64Str = (NSMutableString * )[base64Str stringByReplacingOccurrencesOfString:@"=" withString:@""];
    return base64Str;
}

- (NSString *)u_base64DecodedSafe {
    NSMutableString *base64Str = [[NSMutableString alloc] initWithString:self];
    base64Str = (NSMutableString * )[base64Str stringByReplacingOccurrencesOfString:@"-" withString:@"+"];
    base64Str = (NSMutableString * )[base64Str stringByReplacingOccurrencesOfString:@"_" withString:@"/"];
    NSInteger mod4 = base64Str.length % 4;
    if (mod4) {
        [base64Str appendString:[@"====" substringToIndex:(4 - mod4)]];
    }
    NSString *string = base64Str.u_URLDecoded;
    return string;
}

- (NSString *)u_stringByTrimmingWhitespaceAndNewlineCharacters {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}


- (NSString *)u_URLEncoded {
    static NSString * const SPTCharactersGeneralDelimitersToEncode = @":#[]@"; // does not include "?" or "/" due to RFC 3986 - Section 3.4
    static NSString * const SPTCharactersSubDelimitersToEncode = @"!$&'()*+,;=";
    
    NSMutableCharacterSet *allowedCharacterSet = [[NSCharacterSet URLQueryAllowedCharacterSet] mutableCopy];
    [allowedCharacterSet removeCharactersInString:[SPTCharactersGeneralDelimitersToEncode stringByAppendingString:SPTCharactersSubDelimitersToEncode]];
    
    // FIXME: https://github.com/AFNetworking/AFNetworking/pull/3028
    // return [string stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];
    
    static NSUInteger const batchSize = 50;
    
    NSUInteger index = 0;
    NSMutableString *escaped = @"".mutableCopy;
    
    while (index < self.length) {
        NSUInteger length = MIN(self.length - index, batchSize);
        NSRange range = NSMakeRange(index, length);
        
        // To avoid breaking up character sequences such as 👴🏻👮🏽
        range = [self rangeOfComposedCharacterSequencesForRange:range];
        
        NSString *substring = [self substringWithRange:range];
        NSString *encoded = [substring stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];
        [escaped appendString:encoded];
        
        index += range.length;
    }
    
    return escaped;
}


- (NSString *)u_URLDecoded {
    return [self stringByRemovingPercentEncoding];
    //    return CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapes(NULL, (__bridge CFStringRef)self, CFSTR("￼=,!$&'()*+;@?\n\"<>#\t :/")));
}


+ (NSString *)u_StringWithDate:(NSDate *)date dateFormat:(nullable NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    NSString *dateFormat = nil;
    if (format == nil) {
        dateFormat = @"y.MM.dd HH: mm: ss";
    } else {
        dateFormat = format;
    }
    formatter.dateFormat = dateFormat;
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}


- (NSComparisonResult)u_versionNumberCompare:(NSString *)string {
    NSCharacterSet *numberAndDotCharacterSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
    NSString *trimmedSelf = [self stringByTrimmingCharactersInSet:numberAndDotCharacterSet];
    NSString *trimmedString = [string stringByTrimmingCharactersInSet:numberAndDotCharacterSet];
    NSArray *selfComponents = [trimmedSelf componentsSeparatedByString:@"."];
    NSArray *stringComponents = [trimmedString componentsSeparatedByString:@"."];
    NSUInteger selfComponentsCount = [selfComponents count];
    NSUInteger stringComponentsCount = [stringComponents count];
    NSUInteger comparableComponentsCount = MIN(selfComponentsCount, stringComponentsCount);
    
    for (NSUInteger i = 0; i < comparableComponentsCount; i++) {
        NSString *aSelfComponent = selfComponents[i];
        NSString *aStringComponent = stringComponents[i];
        NSComparisonResult result = [aSelfComponent compare:aStringComponent options:NSNumericSearch];
        if (result != NSOrderedSame) {
            return result;
        }
    }
    
    NSComparisonResult result = [@(selfComponentsCount) compare:@(stringComponentsCount)];
    return result;
}


// 长度是否在一个范围之内
- (BOOL)u_isLengthGreaterThanOrEqual:(NSInteger)minimum lessThanOrEqual:(NSInteger)maximum {
    return ([self length] >= minimum) && ([self length] <= maximum);
}


- (NSRange)u_firstRangeOfURLSubstring {
    static NSDataDetector *dataDetector = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataDetector = [NSDataDetector dataDetectorWithTypes:(NSTextCheckingTypeLink | NSTextCheckingTypeLink)
                                                       error:nil];
    });
    
    NSRange range = [dataDetector rangeOfFirstMatchInString:self
                                                    options:0
                                                      range:NSMakeRange(0, [self length])];
    return range;
}


- (nullable NSString *)u_firstURLSubstring {
    NSRange range = [self u_firstRangeOfURLSubstring];
    if (range.location == NSNotFound) {
        return nil;
    }
    
    return [self substringWithRange:range];
}


- (nullable NSString *)u_firstMatchUsingRegularExpression:(NSRegularExpression *)regularExpression {
    NSRange range = [regularExpression rangeOfFirstMatchInString:self
                                                         options:0
                                                           range:NSMakeRange(0, [self length])];
    if (range.location == NSNotFound) {
        return nil;
    }
    
    return [self substringWithRange:range];
}


- (nullable NSString *)u_firstMatchUsingRegularExpressionPattern:(NSString *)regularExpressionPattern {
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:regularExpressionPattern
                                                                                       options:NSRegularExpressionCaseInsensitive
                                                                                         error:nil];
    return [self u_firstMatchUsingRegularExpression:regularExpression];
}


- (BOOL)u_matchesRegularExpressionPattern:(NSString *)regularExpressionPattern {
    NSRange fullRange = NSMakeRange(0, [self length]);
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:regularExpressionPattern
                                                                                       options:NSRegularExpressionCaseInsensitive
                                                                                         error:nil];
    NSRange range = [regularExpression rangeOfFirstMatchInString:self
                                                         options:0
                                                           range:fullRange];
    if (NSEqualRanges(fullRange, range)) {
        return YES;
    }
    return NO;
}


- (NSRange)u_rangeOfFirstMatchUsingRegularExpressionPattern:(NSString *)regularExpressionPattern {
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:regularExpressionPattern
                                                                                       options:NSRegularExpressionCaseInsensitive
                                                                                         error:nil];
    NSRange range = [regularExpression rangeOfFirstMatchInString:self
                                                         options:0
                                                           range:NSMakeRange(0, [self length])];
    return range;
}


- (NSString *)u_stringByReplacingMatchesUsingRegularExpressionPattern:(NSString *)regularExpressionPattern withTemplate:(NSString *)templ {
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:regularExpressionPattern
                                                                                       options:NSRegularExpressionCaseInsensitive
                                                                                         error:nil];
    NSString *string = [regularExpression stringByReplacingMatchesInString:self
                                                                   options:0
                                                                     range:NSMakeRange(0, [self length])
                                                              withTemplate:templ];
    return string;
}


- (CGSize)u_sizeWithSingleLineFont:(UIFont *)font {
    NSParameterAssert(font);
    if (font == nil) {
        return CGSizeZero;
    }
    
    NSStringDrawingOptions options = 0;
    NSDictionary *attributes = @{NSFontAttributeName: font};
    CGSize size = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)
                                     options:options
                                  attributes:attributes
                                     context:nil].size;
    return CGSizeMake(ceilf(size.width), ceilf(size.height));
}


- (nullable id)u_JSONObject {
    NSError *error = nil;
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    if (data.length == 0) {
        return nil;
    }
    id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if (error != nil) {
        NSLog(@"[SportsKit] > String > ERROR: cannot convert string to JSON object: %@", self);
        return nil;
    }
    
    return object;
    
}


- (NSURL *)u_toURL {
    NSString *utf8Str = [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:utf8Str];
    return url;
}


- (CGSize)u_sizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)maxWidth lineCount:(NSUInteger)maxLineCount {
    BOOL anyBoolValue;
    return [self u_sizeWithFont:font constrainedToWidth:maxWidth lineCount:maxLineCount constrained:&anyBoolValue];
}


- (CGSize)u_sizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)maxWidth lineCount:(NSUInteger)maxLineCount constrained:(BOOL *)constrained {
    CGFloat width = 0.0f;
    CGFloat height = 0.0f;
    
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin;
    NSDictionary *attributes = @{NSFontAttributeName: font};
    if (maxLineCount == 0) {
        CGSize size = [self boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX)
                                         options:options
                                      attributes:attributes
                                         context:nil].size;
        width = size.width;
        height = size.height;
        if (constrained != nil) {
            *constrained = NO;
        }
    } else {
        NSMutableString *testString = [NSMutableString stringWithString:@"X"];
        for (NSInteger i = 0; i < maxLineCount - 1; i++) {
            [testString appendString:@"\nX"];
        }
        
        CGSize maxSize = [testString boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX)
                                                  options:options
                                               attributes:attributes
                                                  context:nil].size;
        CGSize textSize = [self boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX)
                                             options:options
                                          attributes:attributes
                                             context:nil].size;
        width = textSize.width;
        if (maxSize.height < textSize.height) {
            if (constrained != nil) {
                *constrained = YES;
            }
            height = maxSize.height;
        }
        else {
            if (constrained != nil) {
                *constrained = NO;
            }
            height = textSize.height;
        }
    }
    width = ceilf(width);
    height = ceilf(height);
    return CGSizeMake(width, height);
}


- (CGFloat)u_heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)maxWidth lineCount:(NSUInteger)maxLineCount {
    return [self u_sizeWithFont:font constrainedToWidth:maxWidth lineCount:maxLineCount].height;
}


- (CGFloat)u_heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)maxWidth lineCount:(NSUInteger)maxLineCount constrained:(BOOL *)constrained {
    return [self u_sizeWithFont:font constrainedToWidth:maxWidth lineCount:maxLineCount constrained:constrained].height;
}


- (CGSize)u_sizeWithFont:(UIFont *)font constrainedToHeight:(CGFloat)maxHeight lineCount:(NSUInteger)maxLineCount {
    BOOL anyBoolValue;
    return [self u_sizeWithFont:font constrainedToHeight:maxHeight lineCount:maxLineCount constrained:&anyBoolValue];
}


- (CGSize)u_sizeWithFont:(UIFont *)font constrainedToHeight:(CGFloat)maxheight lineCount:(NSUInteger)maxLineCount constrained:(BOOL *)constrained {
    CGFloat width = 0.0f;
    CGFloat height = 0.0f;
    
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin;
    NSDictionary *attributes = @{NSFontAttributeName: font};
    if (maxLineCount == 0) {
        CGSize size = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, maxheight)
                                         options:options
                                      attributes:attributes
                                         context:nil].size;
        width = size.width;
        height = size.height;
        if (constrained != nil) {
            *constrained = NO;
        }
    } else {
        NSMutableString *testString = [NSMutableString stringWithString:@"X"];
        for (NSInteger i = 0; i < maxLineCount - 1; i++) {
            [testString appendString:@"\nX"];
        }
        
        CGSize maxSize = [testString boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, maxheight)
                                                  options:options
                                               attributes:attributes
                                                  context:nil].size;
        CGSize textSize = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, maxheight)
                                             options:options
                                          attributes:attributes
                                             context:nil].size;
        width = textSize.width;
        if (maxSize.height < textSize.height) {
            if (constrained != nil) {
                *constrained = YES;
            }
            height = maxSize.height;
        } else {
            if (constrained != nil) {
                *constrained = NO;
            }
            height = textSize.height;
        }
    }
    width = ceilf(width);
    height = ceilf(height);
    return CGSizeMake(width, height);
}


- (CGFloat)u_widthWithFont:(UIFont *)font constrainedToHeight:(CGFloat)maxHeight lineCount:(NSUInteger)maxLineCount {
    return [self u_sizeWithFont:font constrainedToHeight:maxHeight lineCount:maxLineCount].width;
}


/**
 计算AttributedString的高度
 
 @param font 字体
 @param lineSpacing 行间距
 @param maxWidth 最大宽
 @param maxLineCount 最大行数
 @return 返回AttributedString的高度
 */
- (CGFloat)u_heightWithFont:(UIFont *)font lineSpacing:(CGFloat)lineSpacing constrainedToWidth:(CGFloat)maxWidth lineCount:(NSUInteger)maxLineCount {
    return [self u_heightWithFont:font lineSpacing:lineSpacing firstLineHeadIndent:0.0f constrainedToWidth:maxWidth lineCount:maxLineCount];
}


- (CGFloat)u_heightWithFont:(UIFont *)font lineSpacing:(CGFloat)lineSpacing firstLineHeadIndent:(CGFloat)firstLineHeadIndent constrainedToWidth:(CGFloat)maxWidth lineCount:(NSUInteger)maxLineCount {
    if (self.length == 0) {
        return 0.0f;
    }
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
    attributes[NSFontAttributeName] = font;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing;
    paragraphStyle.firstLineHeadIndent = firstLineHeadIndent;
    attributes[NSParagraphStyleAttributeName] = paragraphStyle;
    
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:self
                                                                           attributes:attributes];
    
    CGFloat maxHeight = font.lineHeight * maxLineCount + lineSpacing * (maxLineCount - 1);
    if (maxLineCount == 0) {
        maxHeight = CGFLOAT_MAX;
    }
    return [NSString u_heightWithAttributedString:attributedString constrainedToWidth:maxWidth constrainedToHeight:maxHeight];
}


+ (CGFloat)u_heightWithAttributedString:(NSAttributedString *)attributedString constrainedToWidth:(CGFloat)maxWidth constrainedToHeight:(CGFloat)maxHeight {
    CGSize labelSize = [attributedString boundingRectWithSize:CGSizeMake(maxWidth,maxHeight) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil].size;
    return labelSize.height;
}


- (NSString *)u_numberAbbrev {
    NSString *regex = @"^[0-9]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL result = [pred evaluateWithObject:self];
    if (!result) {
        return self;
    }
    if (self.length <= 4) {
        return self;
    }
    if (self.length < 6) {
        CGFloat value = [self floatValue];
        return [NSString stringWithFormat:@"%.1f万",value / 10000 ];
    } else {
        return @"10万+";
    }
}


- (NSString *)u_numberAbbrevInEnglish {
    NSString *regex = @"^[0-9]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL result = [pred evaluateWithObject:self];
    if (!result) {
        return self;
    }
    if (self.length <= 4) {
        return self;
    }
    if (self.length < 6) {
        CGFloat value = [self floatValue];
        return [NSString stringWithFormat:@"%.1fW",value / 10000 ];
    } else {
        return @"10W+";
    }
}


@end
