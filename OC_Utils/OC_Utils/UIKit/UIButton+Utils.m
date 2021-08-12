//
//  UIButton+Utils.m
//  OC_Utils
//
//  Created by WWQ on 2021/8/12.
//

#import "UIButton+Utils.h"

@implementation UIButton (Utils)


+ (instancetype)u_buttonWithImage:(UIImage *)image highlightedImage:(nullable UIImage *)highlightedImage alwaysRenderingAsTemplate:(BOOL)alwaysRenderingAsTemplate title:(nullable NSString *)title target:(nullable id)target action:(SEL)action {
    NSAssert(image != nil, @"The image is nil");
    if (image == nil) {
        return nil;
    }
    
    CGSize imageSize = [image size];
    CGSize highlightedImageSize = [highlightedImage size];
    
    if (highlightedImage != nil) {
        NSAssert(CGSizeEqualToSize(imageSize, highlightedImageSize), @"The sizes of image and highlightedImage r not equal.");
        if (!CGSizeEqualToSize(imageSize, highlightedImageSize)) {
            return nil;
        }
    }
    
    if (alwaysRenderingAsTemplate) {
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        highlightedImage = [highlightedImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, imageSize.width, imageSize.height)];
    if (title != nil) {
        [button setTitle:title forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont boldSystemFontOfSize:12.0f]];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    [button setBackgroundImage:image forState:UIControlStateNormal];
    if (highlightedImage != nil) {
        [button setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
    }
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}


- (void)u_makeVerticalWithPadding:(CGFloat)padding {
    UIImageView *imageView = self.imageView;
    UILabel *titleLabel = self.titleLabel;
    
    self.imageEdgeInsets = UIEdgeInsetsMake(padding * - 0.5f, (titleLabel.bounds.size.width ) * 0.5f, titleLabel.frame.size.height, (titleLabel.bounds.size.width) * -0.5f);
    self.titleEdgeInsets = UIEdgeInsetsMake(imageView.frame.size.height, (imageView.frame.size.width) * -0.5f, padding * - 0.5f, imageView.frame.size.width * 0.5f);
}


- (void)u_addHorizontalPadding:(CGFloat)padding {
    UIEdgeInsets imageEdgeInsets = self.imageEdgeInsets;
    UIEdgeInsets titleEdgeInsets = self.titleEdgeInsets;
    
    imageEdgeInsets.right += padding * 0.5f;
    titleEdgeInsets.left += padding * 0.5f;
    
    self.imageEdgeInsets = imageEdgeInsets;
    self.titleEdgeInsets = titleEdgeInsets;
}


@end
