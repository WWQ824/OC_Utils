//
//  NSData+Utils.m
//  OC_Utils
//
//  Created by suning on 2021/8/10.
//

#import <CommonCrypto/CommonDigest.h>
#import "NSString+Utils.h"
#import "NSData+Utils.h"

static char u_base64EncodingTable[64] = {
    'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P',
    'Q','R','S','T','U','V','W','X','Y','Z','a','b','c','d','e','f',
    'g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v',
    'w','x','y','z','0','1','2','3','4','5','6','7','8','9','+','/'
};


NSString *u_image_MIME_type_for_format(UImageFormat format) {
    switch (format) {
        case UImageFormatUndefined: {
            return nil;
        }
        case UImageFormatJPEG: {
            return @"image/jpeg";
        }
        case UImageFormatPNG: {
            return @"image/png";
        }
        case UImageFormatGIF: {
            return @"image/gif";
        }
        case UImageFormatTIFF: {
            return @"image/tiff";
        }
        case UImageFormatWebP: {
            return @"image/webp";
        }
        case UImageFormatHEIC: {
            return @"image/heic";
        }
        case UImageFormatHEIF: {
            return @"image/heif";
        }
        default:{
            return nil;
        }
    }
}

@implementation NSData (Utils)


- (NSString *)u_md5String {
    unsigned char result[16];
    CC_MD5(self.bytes, (CC_LONG)(self.length), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}


- (NSString *)u_base64EncodedString {
    return [self u_base64EncodedStringWithLineLength:0];
}


- (NSString *)u_base64EncodedStringWithLineLength:(NSUInteger)lineLength {
    const unsigned char *bytes = [self bytes];
    NSMutableString *result = [NSMutableString stringWithCapacity:self.length];
    unsigned long ixtext = 0;
    unsigned long lentext = self.length;
    long ctremaining = 0;
    unsigned char inbuf[3];
    unsigned char outbuf[4];
    unsigned short i = 0;
    unsigned short charsonline = 0;
    unsigned short ctcopy = 0;
    unsigned long ix = 0;
    
    while (YES) {
        ctremaining = lentext - ixtext;
        if (ctremaining <= 0) {
            break;
        }
        
        for (i = 0; i < 3; i++) {
            ix = ixtext + i;
            if (ix < lentext) {
                inbuf[i] = bytes[ix];
            }
            else inbuf[i] = 0;
        }
        
        outbuf[0] = (inbuf[0] & 0xFC) >> 2;
        outbuf[1] = ((inbuf[0] & 0x03) << 4) | ((inbuf[1] & 0xF0) >> 4);
        outbuf[2] = ((inbuf[1] & 0x0F) << 2) | ((inbuf[2] & 0xC0) >> 6);
        outbuf[3] = inbuf[2] & 0x3F;
        ctcopy = 4;
        
        switch (ctremaining) {
            case 1: {
                ctcopy = 2;
                break;
            }
            case 2: {
                ctcopy = 3;
                break;
            }
        }
        
        for (i = 0; i < ctcopy; i++) {
            [result appendFormat:@"%c", u_base64EncodingTable[outbuf[i]]];
        }
        
        for (i = ctcopy; i < 4; i++) {
            [result appendString:@"="];
        }
        
        ixtext += 3;
        charsonline += 4;
        
        if (lineLength > 0) {
            if (charsonline >= lineLength) {
                charsonline = 0;
                [result appendString:@"\n"];
            }
        }
    }
    
    return [NSString stringWithString:result];
}


- (NSData *)u_base64Decoded {
    const unsigned char *bytes = [self bytes];
    NSMutableData *result = [NSMutableData dataWithCapacity:[self length]];
    
    unsigned long ixtext = 0;
    unsigned long lentext = [self length];
    unsigned char ch = 0;
    unsigned char inbuf[4] = {0, 0, 0, 0};
    unsigned char outbuf[3] = {0, 0, 0};
    short i = 0;
    short ixinbuf = 0;
    BOOL flignore = NO;
    BOOL flendtext = NO;
    
    while (YES) {
        if (ixtext >= lentext) {
            break;
        }
        ch = bytes[ixtext++];
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
                    [result appendBytes:&outbuf[i] length:1];
                }
            }
            
            if (flbreak) {
                break;
            }
        }
    }
    
    return [NSData dataWithData:result];
}


- (BOOL)u_hasPrefixBytes:(const void *)prefix length:(NSUInteger) length {
    if (!prefix || !length || self.length < length) {
        return NO;
    }
    return (memcmp([self bytes], prefix, length) == 0);
}


- (BOOL)u_hasSuffixBytes:(const void *)suffix length:(NSUInteger) length {
    if (!suffix || !length || self.length < length) {
        return NO;
    }
    return (memcmp(((const char *)[self bytes] + (self.length - length)), suffix, length) == 0);
}


- (UImageFormat)imageFormat {
    // File signatures table: http://www.garykessler.net/library/file_sigs.html
    uint8_t c;
    [self getBytes:&c length:1];
    switch (c) {
        case 0xFF:
            return UImageFormatJPEG;
        case 0x89:
            return UImageFormatPNG;
        case 0x47:
            return UImageFormatGIF;
        case 0x49:
        case 0x4D:
            return UImageFormatTIFF;
        case 0x52: {
            if (self.length >= 12) {
                //RIFF....WEBP
                NSString *testString = [[NSString alloc] initWithData:[self subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
                if ([testString hasPrefix:@"RIFF"] && [testString hasSuffix:@"WEBP"]) {
                    return UImageFormatWebP;
                }
            }
            break;
        }
        case 0x00: {
            if (self.length >= 12) {
                //....ftypheic ....ftypheix ....ftyphevc ....ftyphevx
                NSString *testString = [[NSString alloc] initWithData:[self subdataWithRange:NSMakeRange(4, 8)] encoding:NSASCIIStringEncoding];
                if ([testString isEqualToString:@"ftypheic"]
                    || [testString isEqualToString:@"ftypheix"]
                    || [testString isEqualToString:@"ftyphevc"]
                    || [testString isEqualToString:@"ftyphevx"]) {
                    return UImageFormatHEIC;
                }
                if ([testString isEqualToString:@"ftypmif1"] || [testString isEqualToString:@"ftypmsf1"]) {
                    return UImageFormatHEIF;
                }
            }
            break;
        }
    }
    return UImageFormatUndefined;
}


- (NSString *)imageMIMEType {
    UImageFormat format = [self imageFormat];
    NSString *MIMEType = u_image_MIME_type_for_format(format);
    return MIMEType;
}

@end
