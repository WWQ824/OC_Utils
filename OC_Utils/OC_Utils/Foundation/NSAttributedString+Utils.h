//
//  NSAttributedString+Utils.h
//  OC_Utils
//
//  Created by WWQ on 2021/8/11.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface NSAttributedString (Utils)


- (instancetype)initWithString:(NSString *)string font:(UIFont *)font foregroundColor:(UIColor *)foregroundColor lineSpacing:(CGFloat)lineSpacing;

- (CGFloat)u_heightConstrainedToWidth:(CGFloat)maxWidth;

    /**
     计算AttributedString的高度
     
     @param font 字体
     @param lineSpacing 行间距
     @param maxWidth 最大宽
     @param maxLineCount 最大行数
     @return 返回AttributedString的高度
     */
- (CGFloat)u_heightWithFont:(UIFont *)font
                  lineSpacing:(CGFloat)lineSpacing
           constrainedToWidth:(CGFloat)maxWidth
                    lineCount:(NSUInteger)maxLineCount;
    
- (CGFloat)u_heightWithFont:(UIFont *)font
                  lineSpacing:(CGFloat)lineSpacing
          firstLineHeadIndent:(CGFloat)firstLineHeadIndent
           constrainedToWidth:(CGFloat)maxWidth
                    lineCount:(NSUInteger)maxLineCount;

- (CGFloat)u_heightWithFont:(UIFont *)font
                  lineSpacing:(CGFloat)lineSpacing
          firstLineHeadIndent:(CGFloat)firstLineHeadIndent
           constrainedToWidth:(CGFloat)maxWidth
                    lineCount:(NSUInteger)maxLineCount
                      options:(NSStringDrawingOptions)options;


@end

NS_ASSUME_NONNULL_END
