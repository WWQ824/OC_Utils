//
//  NSAttributedString+Utils.m
//  OC_Utils
//
//  Created by WWQ on 2021/8/11.
//

#import "NSAttributedString+Utils.h"

@implementation NSAttributedString (Utils)


- (instancetype)initWithString:(NSString *)string font:(UIFont *)font foregroundColor:(UIColor *)foregroundColor lineSpacing:(CGFloat)lineSpacing {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing;
    
    NSDictionary *attributes = @{NSFontAttributeName: font, NSForegroundColorAttributeName: foregroundColor, NSParagraphStyleAttributeName : paragraphStyle};
    
    self = [self initWithString:string attributes:attributes];
    return self;
}


- (CGFloat)u_heightConstrainedToWidth:(CGFloat)maxWidth {
    CGFloat height = 0.0f;
    
    NSStringDrawingOptions options = (NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading);
    CGSize size = [self boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX)
                                     options:options
                                     context:nil].size;
    height = ceilf(size.height);
    return height;
}

    
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
                    lineCount:(NSUInteger)maxLineCount {
    return [self u_heightWithFont:font lineSpacing:lineSpacing firstLineHeadIndent:0.0f constrainedToWidth:maxWidth lineCount:maxLineCount];
}

- (CGFloat)u_heightWithFont:(UIFont *)font
                  lineSpacing:(CGFloat)lineSpacing
          firstLineHeadIndent:(CGFloat)firstLineHeadIndent
           constrainedToWidth:(CGFloat)maxWidth
                    lineCount:(NSUInteger)maxLineCount {
    return [self u_heightWithFont:font lineSpacing:lineSpacing firstLineHeadIndent:firstLineHeadIndent constrainedToWidth:maxWidth lineCount:maxLineCount options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading];
}

- (CGFloat)u_heightWithFont:(UIFont *)font
                  lineSpacing:(CGFloat)lineSpacing
          firstLineHeadIndent:(CGFloat)firstLineHeadIndent
           constrainedToWidth:(CGFloat)maxWidth
                    lineCount:(NSUInteger)maxLineCount
                      options:(NSStringDrawingOptions)options {
    if (self.length == 0) {
        return 0.0f;
    }
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
    attributes[NSFontAttributeName] = font;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing;
    paragraphStyle.firstLineHeadIndent = firstLineHeadIndent;
    attributes[NSParagraphStyleAttributeName] = paragraphStyle;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self];
    [attributedString addAttributes:attributes range:NSMakeRange(0, self.length)];
    CGFloat maxHeight = font.lineHeight * maxLineCount + lineSpacing * (maxLineCount     - 1);
    if (maxLineCount == 0) {
        maxHeight = CGFLOAT_MAX;
    }
    //计算字符串在label上的高度
    CGSize labelSize = [attributedString boundingRectWithSize:CGSizeMake(maxWidth,maxHeight) options:options context:nil].size;
    return labelSize.height;
}

@end
