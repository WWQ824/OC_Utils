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


/**
 MD5加密
 */
- (NSString *)u_md5String;


/**
 base64编码
 */
- (NSString *)u_base64EncodedString;


/**
 base64编码
 */
- (NSString *)u_base64EncodedStringWithLineLength:(NSUInteger)lineLength;


/**
 base64解码
 */
- (NSData *)u_base64Decoded;


/**
 是否有这个前缀字节
 */
- (BOOL)u_hasPrefixBytes:(const void *)prefix length:(NSUInteger)length;


/**
 是否有这个后缀字节
 */
- (BOOL)u_hasSuffixBytes:(const void *)suffix length:(NSUInteger)length;


/**
 图片格式
 */
@property (nonatomic, readonly) UImageFormat imageFormat;


/**
 图片格式名称
 */
@property (nonatomic, readonly, nullable, copy) NSString *imageMIMEType;



@end

NS_ASSUME_NONNULL_END
