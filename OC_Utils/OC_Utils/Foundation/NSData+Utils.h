//
//  NSData+Utils.h
//  OC_Utils
//
//  Created by suning on 2021/8/10.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, UImageFormat) {
    UImageFormatUndefined,
    UImageFormatJPEG,
    UImageFormatPNG,
    UImageFormatGIF,
    UImageFormatTIFF,
    UImageFormatWebP,
    UImageFormatHEIC,
    UImageFormatHEIF,
};


extern NSString * _Nullable u_image_MIME_type_for_format(UImageFormat format);


NS_ASSUME_NONNULL_BEGIN


@interface NSData (Utils)

- (NSString *)u_md5String;

- (NSString *)u_base64EncodedString;
- (NSString *)u_base64EncodedStringWithLineLength:(NSUInteger)lineLength;
- (NSData *)u_base64Decoded;

- (BOOL)u_hasPrefixBytes:(const void *)prefix length:(NSUInteger)length;
- (BOOL)u_hasSuffixBytes:(const void *)suffix length:(NSUInteger)length;

@property (nonatomic, readonly) UImageFormat imageFormat;
@property (nonatomic, readonly, nullable, copy) NSString *imageMIMEType;



@end

NS_ASSUME_NONNULL_END
