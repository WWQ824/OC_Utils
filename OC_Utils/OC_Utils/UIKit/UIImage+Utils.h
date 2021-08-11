//
//  UIImage+Utils.h
//  OC_Utils
//
//  Created by WWQ on 2021/8/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN



typedef NS_ENUM(NSUInteger, UImageCropperAlignment) {
    UImageCropperAlignmentTop,
    UImageCropperAlignmentLeft,
    UImageCropperAlignmentBottom,
    UImageCropperAlignmentRight,
};


extern CGFloat u_screen_scale(void);
extern void u_draw_horizontal_gradient(CGContextRef context, CGSize size, NSArray<UIColor *> *colors);
extern void u_draw_vertical_gradient(CGContextRef context, CGSize size, NSArray<UIColor *> *colors);


@interface UIImage (Utils)


// if rect was smaller than image's size, crop the image content within rect; otherwise remove the image content out of the rect
/**
 图片裁剪

 @param rect 裁剪区域
 @return 图片
 */
- (UIImage *)u_imageInRect:(CGRect)rect;


/**
 根据sizeInPoint剪切图片

 @param sizeInPoint 尺寸
 @param alignment 对齐方向
 */
- (nullable UIImage *)u_croppedImageFitSize:(CGSize)sizeInPoint alignment:(UImageCropperAlignment)alignment;

/**
 裁剪成正方形
 */
- (UIImage *)u_centerSquareImage;

/**
 缩放到size

 @param size size
 */
- (UIImage *)u_imageScaledToSize:(CGSize)size;

- (UIImage *)u_orientationFixedImage;

/**
 图片处理圆角

 @param radius 圆角
 */
- (UIImage *)u_imageByRoundCornerRadius:(CGFloat)radius;

/**
图片处理圆角、边框

 @param radius 圆角
 @param borderWidth 边框宽度
 @param borderColor 边框颜色
 */
- (UIImage *)u_imageByRoundCornerRadius:(CGFloat)radius
                              borderWidth:(CGFloat)borderWidth
                              borderColor:(nullable UIColor *)borderColor;

/**
 图片处理圆角、边框

 @param radius 圆角
 @param corners 某一方向的角
 @param borderWidth 边框宽度
 @param borderColor 边框颜色
 @param borderLineJoin 终点处理
 */
- (UIImage *)u_imageByRoundCornerRadius:(CGFloat)radius
                                  corners:(UIRectCorner)corners
                              borderWidth:(CGFloat)borderWidth
                              borderColor:(nullable UIColor *)borderColor
                           borderLineJoin:(CGLineJoin)borderLineJoin;

/**
 根据颜色生成image

 @param color 颜色
 */
+ (UIImage *)u_patternImageWithColor:(UIColor *)color;

/**
 获取渐变image
 
 @param size size
 @param colors colors
 */
+ (nullable UIImage *)u_horizontalGradientImageWithSize:(CGSize)size colors:(NSArray <UIColor *> *)colors;
+ (nullable UIImage *)u_verticalGradientImageWithSize:(CGSize)size colors:(NSArray <UIColor *> *)colors;

/**
 按一定规则生成图片

 @param blurRadius 模糊
 @param tintColor 色调
 @param tintBlendMode 色调模式
 @param saturation 饱和度
 @param maskImage 蒙蔽图片
 */
- (nullable UIImage *)u_imageByBlurRadius:(CGFloat)blurRadius tintColor:(nullable UIColor *)tintColor tintMode:(CGBlendMode)tintBlendMode saturation:(CGFloat)saturation maskImage:(nullable UIImage *)maskImage;

/**
 图片处理成能上传的大小的image
 */
- (UIImage *)u_resizedImageToFitUploadSize;

/**
  图片压缩处理成能上传的大小的image

 @param compressionQuality 压缩质量
 */
- (UIImage *)u_resizedImageToFitUploadSizeWithCompressionQuality:(CGFloat)compressionQuality;

/**
 图片处理成能上传的大小的data
 */
- (NSData *)u_resizedImageDataToFitUploadSize;

/**
 图片压缩处理成能上传的大小的date

 @param compressionQuality 压缩质量
 */
- (NSData *)u_resizedImageDataToFitUploadSizeWithCompressionQuality:(CGFloat)compressionQuality;

/**
 增加色调

 @param tintColor 颜色
 */
- (UIImage *)u_imageWithTintColor:(UIColor *)tintColor;

/**
 增加色调
 
 @param tintColor 颜色
 */
- (UIImage *)u_imageWithGradientTintColor:(UIColor *)tintColor;

/**
 增加色调
 
 @param tintColor 颜色
 */
- (UIImage *)u_imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode;

/**
 生成图片(一般用于webview给native传递图片)
 
 @param base64String 图片生成的base64字符串
 */
+ (nullable UIImage *)u_imageFromBase64String:(nullable NSString *)base64String;


/**
 Generate an image contains the QR string.
 
 @param QRString The string to generate the image.
 @param length The width and height of the generated image, can not be zero.
 @param scale The scale of the generated image, if 0.0f, the scale of UIScreen will be used.
 @param centerImage If provided, the centerImage will be drawed in center of the image.
 
 @return Generated image.
 */
+ (UIImage *)u_QRCodeImageWithString:(NSString *)QRString
                                length:(CGFloat)length
                                 scale:(CGFloat)scale
                           centerImage:(nullable UIImage *)centerImage;


/**
 Generate an code-128 barcode image contains the string.
 
 @param code128BarcodeString The string to generate the barcode image.
 @param size The width and height of the generated image, can not be zero.
 @param scale The scale of the generated image, if 0.0f, the scale of UIScreen will be used.
 
 @return Generated image.
 */
+ (UIImage *)u_Code128BarcodeImageWithString:(NSString *)code128BarcodeString
                                          size:(CGSize)size
                                         scale:(CGFloat)scale;

/// Generate an image with attributed string, along with border.
/// @param attributedString the content of image.
/// @param backgroundColor background color, default is white color.
/// @param edgeInsets padding between string and border.
/// @param borderColor border color, null means no border.
/// @param borderWidth border width, 0.0f means no border.
/// @param cornerRadius corner radius of border.
+ (UIImage *)u_imageWithAttributedString:(NSAttributedString *)attributedString
                           backgroundColor:(nullable UIColor *)backgroundColor
                                edgeInsets:(UIEdgeInsets)edgeInsets
                               borderColor:(nullable UIColor *)borderColor
                               borderWidth:(CGFloat)borderWidth
                              cornerRadius:(CGFloat)cornerRadius;



@end

NS_ASSUME_NONNULL_END
