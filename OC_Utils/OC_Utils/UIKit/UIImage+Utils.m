//
//  UIImage+Utils.m
//  OC_Utils
//
//  Created by WWQ on 2021/8/11.
//

#import <Accelerate/Accelerate.h>
#import <ImageIO/ImageIO.h>
#import "UIImage+Utils.h"
#import "NSArray+Utils.h"


CGFloat u_screen_scale(void) {
    CGFloat scale = ([UIScreen instancesRespondToSelector:@selector(scale)] ? [UIScreen.mainScreen scale] : (1.0f));
    return scale;
}


void spt_draw_horizontal_gradient(CGContextRef context, CGSize size, NSArray<UIColor *> *colors) {
    if (colors.count <= 1) {
        return;
    }
    
    if (context == NULL) {
        return;
    }
    
    if ((size.width == 0) || (size.height == 0)) {
        return;
    }
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGRect rect = CGRectMake(0.0, 0.0, size.width, size.height);
    CGPathMoveToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGPathAddLineToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMaxY(rect));
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(rect), CGRectGetMaxY(rect));
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(rect), CGRectGetMinY(rect));
    CGPathCloseSubpath(path);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    NSMutableArray *cgcolors = [[NSMutableArray alloc] initWithCapacity:colors.count];
    CGFloat *locations = (CGFloat *)malloc(sizeof(CGFloat) * (size_t)(colors.count));
    for (NSInteger i = 0; i < colors.count; i++) {
        UIColor *color = [colors u_nullableObjectAtIndex:i];
        if (color == nil) {
            break;
        }
        
        [cgcolors addObject:(__bridge id)color.CGColor];
        if (i != colors.count - 1) {
            locations[i] = 0.0f + (1.0f / (colors.count - 1) * (CGFloat)(i));
        } else {
            locations[i] = 1.0f;
        }
    }
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)cgcolors, locations);
    CGRect pathRect = CGPathGetBoundingBox(path);
    CGPoint startPoint = CGPointMake(CGRectGetMinX(pathRect), CGRectGetMidY(pathRect));
    CGPoint endPoint = CGPointMake(CGRectGetMaxX(pathRect), CGRectGetMidY(pathRect));
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGRect boxRect = CGRectMake(0.0, 0.0, pathRect.size.width, pathRect.size.height);
    CGContextClipToRect(context, boxRect);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    gradient = NULL;
    CGColorSpaceRelease(colorSpace);
    free(locations);
    CGPathRelease(path);
}


void spt_draw_vertical_gradient(CGContextRef context, CGSize size, NSArray<UIColor *> *colors) {
    if (colors.count <= 1) {
        return;
    }
    
    if (context == NULL) {
        return;
    }
    
    if ((size.width == 0) || (size.height == 0)) {
        return;
    }
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGRect rect = CGRectMake(0.0, 0.0, size.width, size.height);
    CGPathMoveToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGPathAddLineToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMaxY(rect));
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(rect), CGRectGetMaxY(rect));
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(rect), CGRectGetMinY(rect));
    CGPathCloseSubpath(path);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    NSMutableArray *cgcolors = [[NSMutableArray alloc] initWithCapacity:colors.count];
    CGFloat *locations = (CGFloat *)malloc(sizeof(CGFloat) * (size_t)(colors.count));
    for (NSInteger i = 0; i < colors.count; i++) {
        UIColor *color = [colors u_nullableObjectAtIndex:i];
        if (color == nil) {
            break;
        }
        
        [cgcolors addObject:(__bridge id)color.CGColor];
        if (i != colors.count - 1) {
            locations[i] = 0.0f + (1.0f / (colors.count - 1) * (CGFloat)(i));
        } else {
            locations[i] = 1.0f;
        }
    }
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)cgcolors, locations);
    CGRect pathRect = CGPathGetBoundingBox(path);
    CGPoint startPoint = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMinY(pathRect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMaxY(pathRect));
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGRect boxRect = CGRectMake(0.0, 0.0, pathRect.size.width, pathRect.size.height);
    CGContextClipToRect(context, boxRect);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    free(locations);
    CGPathRelease(path);
}


@implementation UIImage (Utils)


- (UIImage *)u_imageInRect:(CGRect)aRect {
    CGImageRef cg = self.CGImage;
    CGFloat scale = u_screen_scale();
    CGRect rectInCGImage = CGRectMake(aRect.origin.x * scale, aRect.origin.y * scale, aRect.size.width * scale, aRect.size.height * scale);
    CGImageRef newCG = CGImageCreateWithImageInRect(cg, rectInCGImage);
    UIImage *image = [UIImage imageWithCGImage:newCG scale:scale orientation:self.imageOrientation];
    CGImageRelease(newCG);
    return image;
}


- (nullable UIImage *)u_croppedImageFitSize:(CGSize)sizeInPoint alignment:(UImageCropperAlignment)alignment {
    if (sizeInPoint.width == 0.0f) {
        return nil;
    }
    if (sizeInPoint.height == 0.0f) {
        return nil;
    }
    if (self.size.width == 0.0f) {
        return nil;
    }
    if (self.size.height == 0.0f) {
        return nil;
    }
    
    CGImageRef cgImage = self.CGImage;
    
    CGSize imageSize = CGSizeMake((CGFloat)CGImageGetWidth(cgImage), (CGFloat)CGImageGetHeight(cgImage));
    CGFloat widthFactor = sizeInPoint.width / imageSize.width;
    CGFloat heightFactor = sizeInPoint.height / imageSize.height;
    
    CGSize scaledImageSize = (widthFactor > heightFactor) ? CGSizeMake(sizeInPoint.width, imageSize.height * widthFactor) : CGSizeMake(imageSize.width * heightFactor, sizeInPoint.height);
    CGRect rect = CGRectMake(0.0f, 0.0f, scaledImageSize.width, scaledImageSize.height);
    switch (alignment) {
        case UImageCropperAlignmentTop: {
            rect.origin.x = MIN(0.0f, (sizeInPoint.width - scaledImageSize.width) * 0.5f);
            rect.origin.y = 0.0f;
            break;
        }
        case UImageCropperAlignmentLeft: {
            rect.origin.x = 0.0f;
            rect.origin.y = MIN(0.0f, (sizeInPoint.height - scaledImageSize.height) * 0.5f);
            break;
        }
        case UImageCropperAlignmentBottom: {
            rect.origin.x = MIN(0.0f, (sizeInPoint.width - scaledImageSize.width) * 0.5f);
            rect.origin.y = MIN(0.0f, sizeInPoint.height - scaledImageSize.height);
            break;
        }
        case UImageCropperAlignmentRight: {
            rect.origin.x = MIN(0.0f, sizeInPoint.width - scaledImageSize.width);
            rect.origin.y = MIN(0.0f, (sizeInPoint.height - scaledImageSize.height) * 0.5f);
            break;
        }
        default:
            break;
    }
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(floorf(sizeInPoint.width), floorf(sizeInPoint.height)), YES, 0.0f);
    [self drawInRect:rect];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}


- (UIImage *)u_centerSquareImage {
    CGImageRef cg = self.CGImage;
    size_t width = CGImageGetWidth(cg);
    size_t height = CGImageGetHeight(cg);
    size_t length = MIN(width, height);
    CGRect rect = CGRectMake(((width / 2.0f) - (length / 2.0f)), ((height / 2.0f) - (length / 2.0f)), length, length);
    CGImageRef newCG = CGImageCreateWithImageInRect(cg, rect);
    UIImage *image = [UIImage imageWithCGImage:newCG scale:u_screen_scale() orientation:self.imageOrientation];
    CGImageRelease(newCG);
    return image;
}


- (UIImage *)u_imageScaledToSize:(CGSize)size {
    //We prepare a bitmap with the new size
    UIGraphicsBeginImageContextWithOptions(size, YES, 0.0f);
    //Draws a rect for the image
    [self drawInRect:CGRectMake(0.0f, 0.0f, size.width, size.height)];
    //We set the scaled image from the context
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}


- (UIImage *)u_orientationFixedImage {
    // No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp)
        return self;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0.0f);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0.0f, self.size.height);
            transform = CGAffineTransformRotate(transform, - M_PI_2);
            break;
        default:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0.0f);
            transform = CGAffineTransformScale(transform, -1.0f, 1.0f);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0.0f);
            transform = CGAffineTransformScale(transform, -1.0f, 1.0f);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0.0f,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0.0f, 0.0f, self.size.height, self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0.0f, 0.0f, self.size.width, self.size.height), self.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}


- (UIImage *)u_imageByRoundCornerRadius:(CGFloat)radius {
    return [self u_imageByRoundCornerRadius:radius borderWidth:0 borderColor:nil];
}


- (UIImage *)u_imageByRoundCornerRadius:(CGFloat)radius
                              borderWidth:(CGFloat)borderWidth
                              borderColor:(nullable UIColor *)borderColor {
    return [self u_imageByRoundCornerRadius:radius
                                      corners:UIRectCornerAllCorners
                                  borderWidth:borderWidth
                                  borderColor:borderColor
                               borderLineJoin:kCGLineJoinMiter];
}


- (UIImage *)u_imageByRoundCornerRadius:(CGFloat)radius
                                  corners:(UIRectCorner)corners
                              borderWidth:(CGFloat)borderWidth
                              borderColor:(nullable UIColor *)borderColor
                           borderLineJoin:(CGLineJoin)borderLineJoin {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, 0, -rect.size.height);
    
    CGFloat minSize = MIN(self.size.width, self.size.height);
    if (borderWidth < minSize / 2) {
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, borderWidth, borderWidth) byRoundingCorners:corners cornerRadii:CGSizeMake(radius, borderWidth)];
        [path closePath];
        
        CGContextSaveGState(context);
        [path addClip];
        CGContextDrawImage(context, rect, self.CGImage);
        CGContextRestoreGState(context);
    }
    
    if (borderColor && borderWidth < minSize / 2 && borderWidth > 0) {
        CGFloat strokeInset = (floor(borderWidth * self.scale) + 0.5) / self.scale;
        CGRect strokeRect = CGRectInset(rect, strokeInset, strokeInset);
        CGFloat strokeRadius = radius > self.scale / 2 ? radius - self.scale / 2 : 0;
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:strokeRect byRoundingCorners:corners cornerRadii:CGSizeMake(strokeRadius, borderWidth)];
        [path closePath];
        
        path.lineWidth = borderWidth;
        path.lineJoinStyle = borderLineJoin;
        [borderColor setStroke];
        [path stroke];
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


+ (UIImage *)u_patternImageWithColor:(UIColor *)color {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(1.0f, 1.0f), NO, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [color set];
    CGContextFillRect(context, CGRectMake(0.0f, 0.0f, 1.0f, 1.0f));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


+ (UIImage *)u_horizontalGradientImageWithSize:(CGSize)size colors:(NSArray <UIColor *> *)colors {
    if (colors.count <= 1) {
        NSAssert(NO, @"colors should has at least 2 members");
        return nil;
    }
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (context == NULL) {
        return nil;
    }
    
    u_draw_horizontal_gradient(context, size, colors);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


+ (UIImage *)u_verticalGradientImageWithSize:(CGSize)size colors:(NSArray <UIColor *> *)colors {
    if (colors.count <= 1) {
        NSAssert(NO, @"colors should has at least 2 members");
        return nil;
    }
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (context == NULL) {
        return nil;
    }
    
    u_draw_vertical_gradient(context, size, colors);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


- (nullable UIImage *)u_imageByBlurRadius:(CGFloat)blurRadius
                                  tintColor:(nullable UIColor *)tintColor
                                   tintMode:(CGBlendMode)tintBlendMode
                                 saturation:(CGFloat)saturation
                                  maskImage:(nullable UIImage *)maskImage {
    if (self.size.width < 1 || self.size.height < 1) {
        NSLog(@"[SportsKit] > Image > UIImage+YYAdd error: invalid size: (%.2f x %.2f). Both dimensions must be >= 1: %@", self.size.width, self.size.height, self);
        return nil;
    }
    if (!self.CGImage) {
        NSLog(@"[SportsKit] > Image > UIImage+YYAdd error: inputImage must be backed by a CGImage: %@", self);
        return nil;
    }
    if (maskImage && !maskImage.CGImage) {
        NSLog(@"[SportsKit] > Image > UIImage+YYAdd error: effectMaskImage must be backed by a CGImage: %@", maskImage);
        return nil;
    }
    
    // iOS7 and above can use new func.
    BOOL hasNewFunc = (long)vImageBuffer_InitWithCGImage != 0 && (long)vImageCreateCGImageFromBuffer != 0;
    BOOL hasBlur = blurRadius > __FLT_EPSILON__;
    BOOL hasSaturation = fabs(saturation - 1.0) > __FLT_EPSILON__;
    
    CGSize size = self.size;
    CGRect rect = { CGPointZero, size };
    CGFloat scale = self.scale;
    CGImageRef imageRef = self.CGImage;
    BOOL opaque = NO;
    
    if (!hasBlur && !hasSaturation) {
        return [self _u_mergeImageRef:imageRef tintColor:tintColor tintBlendMode:tintBlendMode maskImage:maskImage opaque:opaque];
    }
    
    vImage_Buffer effect = { 0 }, scratch = { 0 };
    vImage_Buffer *input = NULL, *output = NULL;
    
    vImage_CGImageFormat format = {
        .bitsPerComponent = 8,
        .bitsPerPixel = 32,
        .colorSpace = NULL,
        .bitmapInfo = kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrder32Little, //requests a BGRA buffer.
        .version = 0,
        .decode = NULL,
        .renderingIntent = kCGRenderingIntentDefault
    };
    
    if (hasNewFunc) {
        vImage_Error err;
        err = vImageBuffer_InitWithCGImage(&effect, &format, NULL, imageRef, kvImagePrintDiagnosticsToConsole);
        if (err != kvImageNoError) {
            NSLog(@"[SportsKit] > Image > UIImage+YYAdd error: vImageBuffer_InitWithCGImage returned error code %zi for inputImage: %@", err, self);
            return nil;
        }
        err = vImageBuffer_Init(&scratch, effect.height, effect.width, format.bitsPerPixel, kvImageNoFlags);
        if (err != kvImageNoError) {
            NSLog(@"[SportsKit] > Image > UIImage+YYAdd error: vImageBuffer_Init returned error code %zi for inputImage: %@", err, self);
            return nil;
        }
    } else {
        UIGraphicsBeginImageContextWithOptions(size, opaque, scale);
        CGContextRef effectCtx = UIGraphicsGetCurrentContext();
        CGContextScaleCTM(effectCtx, 1.0, -1.0);
        CGContextTranslateCTM(effectCtx, 0, -size.height);
        CGContextDrawImage(effectCtx, rect, imageRef);
        effect.data     = CGBitmapContextGetData(effectCtx);
        effect.width    = CGBitmapContextGetWidth(effectCtx);
        effect.height   = CGBitmapContextGetHeight(effectCtx);
        effect.rowBytes = CGBitmapContextGetBytesPerRow(effectCtx);
        
        UIGraphicsBeginImageContextWithOptions(size, opaque, scale);
        CGContextRef scratchCtx = UIGraphicsGetCurrentContext();
        scratch.data     = CGBitmapContextGetData(scratchCtx);
        scratch.width    = CGBitmapContextGetWidth(scratchCtx);
        scratch.height   = CGBitmapContextGetHeight(scratchCtx);
        scratch.rowBytes = CGBitmapContextGetBytesPerRow(scratchCtx);
    }
    
    input = &effect;
    output = &scratch;
    
    if (hasBlur) {
        // A description of how to compute the box kernel width from the Gaussian
        // radius (aka standard deviation) appears in the SVG spec:
        // http://www.w3.org/TR/SVG/filters.html#feGaussianBlurElement
        //
        // For larger values of 's' (s >= 2.0), an approximation can be used: Three
        // successive box-blurs build a piece-wise quadratic convolution kernel, which
        // approximates the Gaussian kernel to within roughly 3%.
        //
        // let d = floor(s * 3*sqrt(2*pi)/4 + 0.5)
        //
        // ... if d is odd, use three box-blurs of size 'd', centered on the output pixel.
        //
        CGFloat inputRadius = blurRadius * scale;
        if (inputRadius - 2.0 < __FLT_EPSILON__) inputRadius = 2.0;
        uint32_t radius = floor((inputRadius * 3.0 * sqrt(2 * M_PI) / 4 + 0.5) / 2);
        radius |= 1; // force radius to be odd so that the three box-blur methodology works.
        int iterations;
        if (blurRadius * scale < 0.5) iterations = 1;
        else if (blurRadius * scale < 1.5) iterations = 2;
        else iterations = 3;
        NSInteger tempSize = vImageBoxConvolve_ARGB8888(input, output, NULL, 0, 0, radius, radius, NULL, kvImageGetTempBufferSize | kvImageEdgeExtend);
        void *temp = malloc(tempSize);
        for (int i = 0; i < iterations; i++) {
            vImageBoxConvolve_ARGB8888(input, output, temp, 0, 0, radius, radius, NULL, kvImageEdgeExtend);
            vImage_Buffer *temp = input;
            input = output;
            output = temp;
        }
        free(temp);
    }
    
    
    if (hasSaturation) {
        // These values appear in the W3C Filter Effects spec:
        // https://dvcs.w3.org/hg/FXTF/raw-file/default/filters/Publish.html#grayscaleEquivalent
        CGFloat s = saturation;
        CGFloat matrixFloat[] = {
            0.0722 + 0.9278 * s,  0.0722 - 0.0722 * s,  0.0722 - 0.0722 * s,  0,
            0.7152 - 0.7152 * s,  0.7152 + 0.2848 * s,  0.7152 - 0.7152 * s,  0,
            0.2126 - 0.2126 * s,  0.2126 - 0.2126 * s,  0.2126 + 0.7873 * s,  0,
            0,                    0,                    0,                    1,
        };
        const int32_t divisor = 256;
        NSUInteger matrixSize = sizeof(matrixFloat) / sizeof(matrixFloat[0]);
        int16_t matrix[matrixSize];
        for (NSUInteger i = 0; i < matrixSize; ++i) {
            matrix[i] = (int16_t)roundf(matrixFloat[i] * divisor);
        }
        vImageMatrixMultiply_ARGB8888(input, output, matrix, divisor, NULL, NULL, kvImageNoFlags);
        vImage_Buffer *temp = input;
        input = output;
        output = temp;
    }
    
    UIImage *outputImage = nil;
    if (hasNewFunc) {
        CGImageRef effectCGImage = NULL;
        effectCGImage = vImageCreateCGImageFromBuffer(input, &format, &_u_cleanupBuffer, NULL, kvImageNoAllocate, NULL);
        if (effectCGImage == NULL) {
            effectCGImage = vImageCreateCGImageFromBuffer(input, &format, NULL, NULL, kvImageNoFlags, NULL);
            free(input->data);
        }
        free(output->data);
        outputImage = [self _u_mergeImageRef:effectCGImage tintColor:tintColor tintBlendMode:tintBlendMode maskImage:maskImage opaque:opaque];
        CGImageRelease(effectCGImage);
    } else {
        CGImageRef effectCGImage;
        UIImage *effectImage;
        if (input != &effect) effectImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        if (input == &effect) effectImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        effectCGImage = effectImage.CGImage;
        outputImage = [self _u_mergeImageRef:effectCGImage tintColor:tintColor tintBlendMode:tintBlendMode maskImage:maskImage opaque:opaque];
    }
    return outputImage;
}


static void _u_cleanupBuffer(void *userData, void *buf_data) {
    free(buf_data);
}


- (UIImage *)_u_mergeImageRef:(CGImageRef)effectCGImage
                      tintColor:(UIColor *)tintColor
                  tintBlendMode:(CGBlendMode)tintBlendMode
                      maskImage:(UIImage *)maskImage
                         opaque:(BOOL)opaque {
    BOOL hasTint = tintColor != nil && CGColorGetAlpha(tintColor.CGColor) > __FLT_EPSILON__;
    BOOL hasMask = maskImage != nil;
    CGSize size = self.size;
    CGRect rect = { CGPointZero, size };
    CGFloat scale = self.scale;
    
    if (!hasTint && !hasMask) {
        return [UIImage imageWithCGImage:effectCGImage];
    }
    
    UIGraphicsBeginImageContextWithOptions(size, opaque, scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextTranslateCTM(context, 0, -size.height);
    if (hasMask) {
        CGContextDrawImage(context, rect, self.CGImage);
        CGContextSaveGState(context);
        CGContextClipToMask(context, rect, maskImage.CGImage);
    }
    CGContextDrawImage(context, rect, effectCGImage);
    if (hasTint) {
        CGContextSaveGState(context);
        CGContextSetBlendMode(context, tintBlendMode);
        CGContextSetFillColorWithColor(context, tintColor.CGColor);
        CGContextFillRect(context, rect);
        CGContextRestoreGState(context);
    }
    if (hasMask) {
        CGContextRestoreGState(context);
    }
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return outputImage;
}


- (UIImage *)u_resizedImageToFitUploadSize {
    return  [self u_resizedImageToFitUploadSizeWithCompressionQuality:0.7f];
}


- (UIImage *)u_resizedImageToFitUploadSizeWithCompressionQuality:(CGFloat)compressionQuality {
    NSData *data = [self u_resizedImageDataToFitUploadSizeWithCompressionQuality:compressionQuality];
    return [UIImage imageWithData:data];
}


- (NSData *)u_resizedImageDataToFitUploadSize {
    return  [self u_resizedImageDataToFitUploadSizeWithCompressionQuality:0.7f];
}


- (NSData *)u_resizedImageDataToFitUploadSizeWithCompressionQuality:(CGFloat)compressionQuality {
    UIImage *originalImage = self;
    CGFloat width = originalImage.size.width;
    CGFloat height = originalImage.size.height;
    
    if (width < height) {
        [self resizeSmallSide:&width bigSide:&height];
    }
    else {
        [self resizeSmallSide:&height bigSide:&width];
    }
    
    CGSize newSize = CGSizeMake(width, height);
    
    //    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, height), NO, u_screen_scale());
    [originalImage drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *resizedImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *imageData = UIImageJPEGRepresentation(originalImage, compressionQuality);
    NSData *resizedImgData = UIImageJPEGRepresentation(resizedImg, compressionQuality);
    if (resizedImgData.length < imageData.length) {
        return resizedImgData;
    }
    else {
        return imageData;
    }
}


- (void)resizeSmallSide:(CGFloat *)smallSide bigSide:(CGFloat *)bigSide {
    CGFloat small = *smallSide;
    CGFloat big = *bigSide;
    
    if (small < 700) {
        return;
    }
    
    CGFloat scale = small / big;
    *smallSide = 700;
    *bigSide = floorf(700 / scale);
    return;
}


- (UIImage *)u_imageWithTintColor:(UIColor *)tintColor {
    return [self u_imageWithTintColor:tintColor blendMode:kCGBlendModeDestinationIn];
}


- (UIImage *)u_imageWithGradientTintColor:(UIColor *)tintColor {
    return [self u_imageWithTintColor:tintColor blendMode:kCGBlendModeOverlay];
}


- (UIImage *)u_imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode {
    //We want to keep alpha, set opaque to NO; Use 0.0f for scale to use the scale factor of the device’s main screen.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    //Draw the tinted image in context
    [self drawInRect:bounds blendMode:blendMode alpha:1.0f];
    if (blendMode != kCGBlendModeDestinationIn) {
        [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    }
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tintedImage;
}


#pragma mark - base64字符串转图片

/**
 base64字符串转图片

 @param base64String base64字符串
 @return 图片
 */
+ (nullable UIImage *)u_imageFromBase64String:(nullable NSString *)base64String {
    UIImage *img = nil;
    NSString *resultString = [self u_trimImageBase64Header:base64String];
    if (resultString.length > 0) {
        NSData *imageData = [[NSData alloc] initWithBase64EncodedString:resultString options:NSDataBase64DecodingIgnoreUnknownCharacters];
        NSAssert(img == nil, @"要引入<SDWebImage/UIImage+MultiFormat.h>");
#warning 要引入<SDWebImage/UIImage+MultiFormat.h>
//        img = [UIImage sd_imageWithData:imageData];
    }
    return img;
}

/**
 截掉base64字符串前面的base64头
 有的库将图片转成base64字符串时会加上一些前缀，生成图片
 时只需要后面的data

 @param base64String base64字符串
 @return 截掉头的字符串
 */
+ (nullable NSString *)u_trimImageBase64Header:(nullable NSString *)base64String {
    if (base64String.length > 0) {
        __block NSString *resultString = base64String;
        NSArray<NSString *> *prefixes = [self base64ImagePrefixes];
        [prefixes enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([base64String hasPrefix:obj]) {
                resultString = [base64String substringFromIndex:obj.length];
                *stop = YES;
            }
        }];
        if (resultString.length > 0) {
            return resultString;
        }
    }
    return nil;
}


/**
 图片生成base64字符串的常用头

 @return 常用头数组
 */
+ (NSArray<NSString *> *)base64ImagePrefixes {
    static NSArray<NSString *> *prefixes = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray<NSString *> *imgTypes = @[@"png", @"jpeg", @"webp", @"gif"];
        NSMutableArray<NSString *> *temp = [NSMutableArray arrayWithCapacity:imgTypes.count];
        [imgTypes enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *base64Type = [NSString stringWithFormat:@"data:image/%@;base64,",obj];
            [temp addObject:base64Type];
        }];
        prefixes = [temp copy];
    });
    return prefixes;
}


+ (UIImage *)u_QRCodeImageWithString:(NSString *)QRString length:(CGFloat)length scale:(CGFloat)scale centerImage:(UIImage *)centerImage {
    if (QRString.length == 0) {
        NSAssert(NO, @"Can not create a QR image with empty string");
        return nil;
    }
    
    if (scale == 0.0f) {
        scale = u_screen_scale();
    }
    
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    
    NSData *data = [QRString dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    
    CIImage *outputImage = [filter outputImage];
    
    CGRect extent = CGRectIntegral(outputImage.extent);
    
    outputImage = [outputImage imageByApplyingTransform:CGAffineTransformMakeScale(length * scale / CGRectGetWidth(extent), length * scale / CGRectGetHeight(extent))];
    UIImage *image = [UIImage imageWithCIImage:outputImage scale:scale orientation:UIImageOrientationUp];
    
    if (centerImage == nil) {
        return image;
    }
    
    CGFloat centerImageLength = MAX(centerImage.size.width, centerImage.size.height);
    if (centerImageLength == 0.0f) {
        return image;
    }
    
    if (centerImage.scale != scale) {
        centerImage = [UIImage imageWithCGImage:centerImage.CGImage scale:scale orientation:centerImage.imageOrientation];
    }
    
    CGFloat centerImageLengthToDraw = length * 0.2f;
    CGFloat centerImageScaleToDraw = centerImageLengthToDraw / centerImageLength;
    
    CGFloat centerImageWidthToDraw = floorf(centerImage.size.width * centerImageScaleToDraw);
    CGFloat centerImageHeightToDraw = floorf(centerImage.size.height * centerImageScaleToDraw);
    CGFloat centerImageXToDraw = floorf((length - centerImageWidthToDraw) * 0.5f);
    CGFloat centerImageYToDraw = floorf((length - centerImageHeightToDraw) * 0.5f);
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(length, length), YES, scale);
    [image drawInRect:CGRectMake(0.0f, 0.0f, length, length)];
    
    if (CGRectGetWidth(extent) != 0.0f) {
        CGFloat centerImageBorderWidth = floorf(length / CGRectGetWidth(extent) * 0.5f);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, UIColor.whiteColor.CGColor);
        CGRect centerImageWithBorderRect = CGRectMake(centerImageXToDraw - centerImageBorderWidth, centerImageYToDraw - centerImageBorderWidth, centerImageWidthToDraw + centerImageBorderWidth + centerImageBorderWidth, centerImageHeightToDraw + centerImageBorderWidth + centerImageBorderWidth);
        CGContextFillRect(context, centerImageWithBorderRect);
    }
    
    [centerImage drawInRect:CGRectMake(centerImageXToDraw, centerImageYToDraw, centerImageWidthToDraw, centerImageHeightToDraw)];
    
    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return finalImage;
}


+ (UIImage *)u_Code128BarcodeImageWithString:(NSString *)code128BarcodeString
                                          size:(CGSize)size
                                         scale:(CGFloat)scale {
    if (code128BarcodeString.length == 0) {
        NSAssert(NO, @"Can not create a barcode image with empty string");
        return nil;
    }
    
    if (scale == 0.0f) {
        scale = u_screen_scale();
    }
    
    NSData *data = [code128BarcodeString dataUsingEncoding:NSASCIIStringEncoding];
    CIFilter *filter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];
    [filter setValue:data forKey:@"inputMessage"];
    CIImage *outputImage = [filter outputImage];
    
    CGRect extent = CGRectIntegral(outputImage.extent);
    
    outputImage = [outputImage imageByApplyingTransform:CGAffineTransformMakeScale(size.width * scale / CGRectGetWidth(extent), size.height * scale / CGRectGetHeight(extent))];
    UIImage *image = [UIImage imageWithCIImage:outputImage scale:scale orientation:UIImageOrientationUp];
    
    return image;
}


+ (UIImage *)u_imageWithAttributedString:(NSAttributedString *)attributedString
                           backgroundColor:(UIColor *)backgroundColor
                                edgeInsets:(UIEdgeInsets)edgeInsets
                               borderColor:(UIColor *)borderColor
                               borderWidth:(CGFloat)borderWidth
                              cornerRadius:(CGFloat)cornerRadius {
    NSParameterAssert(attributedString);
    CGRect textRect = [attributedString boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)
                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                     context:nil];
    CGSize contextSize = CGSizeMake(ceilf(textRect.size.width + edgeInsets.left + edgeInsets.right), ceilf(textRect.size.height + edgeInsets.top + edgeInsets.bottom));
    UIGraphicsBeginImageContextWithOptions(contextSize, NO, u_screen_scale());
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // draw border
    if (borderColor != nil) {
        CGPathRef path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0.0f, 0.0f, contextSize.width, contextSize.height) cornerRadius:cornerRadius].CGPath;
        CGContextAddPath(context, path);
        CGContextSetFillColorWithColor(context, borderColor.CGColor);
        CGContextClosePath(context);
        CGContextFillPath(context);
    }
    
    // draw background color
    if (backgroundColor == nil) {
        backgroundColor = UIColor.whiteColor;
    }
    CGPathRef path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(borderWidth, borderWidth, contextSize.width - borderWidth - borderWidth, contextSize.height - borderWidth - borderWidth) cornerRadius:MAX(cornerRadius - borderWidth, 0.0f)].CGPath;
    CGContextAddPath(context, path);
    CGContextSetFillColorWithColor(context, backgroundColor.CGColor);
    CGContextClosePath(context);
    CGContextFillPath(context);
    
    // draw string
    [attributedString drawAtPoint:CGPointMake(edgeInsets.left, edgeInsets.top)];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
