//
//  UIButton+Utils.h
//  OC_Utils
//
//  Created by WWQ on 2021/8/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (Utils)


/**
 构造button

 @param image 正常状态下的图片
 @param highlightedImage 高亮下的图片
 @param alwaysRenderingAsTemplate Always draw the image as a template image, ignoring its color information
 @param title title
 @param target target
 @param action action
 */
+ (instancetype)u_buttonWithImage:(UIImage *)image
                 highlightedImage:(nullable UIImage *)highlightedImage
        alwaysRenderingAsTemplate:(BOOL)alwaysRenderingAsTemplate
                            title:(nullable NSString *)title
                           target:(nullable id)target
                           action:(SEL)action;

/**
 image和title垂直布局，中间有间隙

 @param padding 间隙大小
 */
- (void)u_makeVerticalWithPadding:(CGFloat)padding;

/**
 image和title水平布局，中间有间隙

 @param padding 间隙大小
 */
- (void)u_addHorizontalPadding:(CGFloat)padding;

@end

NS_ASSUME_NONNULL_END
