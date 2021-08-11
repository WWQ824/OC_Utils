//
//  UIColor+Utils.h
//  OC_Utils
//
//  Created by WWQ on 2021/8/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Utils)


@property (nonatomic, strong, class, readonly) UIColor *u_salmon;
@property (nonatomic, strong, class, readonly) UIColor *u_bloodOrange;
@property (nonatomic, strong, class, readonly) UIColor *u_orangeYellow;
@property (nonatomic, strong, class, readonly) UIColor *u_greyish;
@property (nonatomic, strong, class, readonly) UIColor *u_warmGrey;
@property (nonatomic, strong, class, readonly) UIColor *u_paleGrey;
@property (nonatomic, strong, class, readonly) UIColor *u_fadedBlue;
@property (nonatomic, strong, class, readonly) UIColor *u_pinkishGrey;
@property (nonatomic, strong, class, readonly) UIColor *u_purpleBrown;
@property (nonatomic, strong, class, readonly) UIColor *u_carolinaBlue;
@property (nonatomic, strong, class, readonly) UIColor *u_backgroundGrey;
@property (nonatomic, strong, class, readonly) UIColor *u_barTintColor;
@property (nonatomic, strong, class, readonly) UIColor *u_clayBrown;
@property (nonatomic, strong, class, readonly) UIColor *u_dirtBrown;
@property (nonatomic, strong, class, readonly) UIColor *u_shallowGrey;
@property (nonatomic, strong, class, readonly) UIColor *u_black_alpha_40;
@property (nonatomic, strong, class, readonly) UIColor *u_selectedCellColor;
@property (nonatomic, strong, class, readonly) UIColor *u_mostlyWhite;
@property (nonatomic, strong, class, readonly) UIColor *u_silver;
@property (nonatomic, strong, class, readonly) UIColor *u_baseYellow;
@property (nonatomic, strong, class, readonly) UIColor *u_blackColor;
@property (nonatomic, strong, class, readonly) UIColor *u_titleRagularColor;


@property (nonatomic,strong, readonly) NSString *u_hexString;

/**
 构造color
 @param r 整数 0~255
 @param g 整数 0~255
 @param b 整数 0~255
 */
+ (UIColor *)u_colorWithIntegerRed:(NSInteger)r green:(NSInteger)g blue:(NSInteger)b;

/**
 构造color

 @param r 整数 0~255
 @param g 整数 0~255
 @param b 整数 0~255
 @param alpha 0~1
 */
+ (UIColor *)u_colorWithIntegerRed:(NSInteger)r green:(NSInteger)g blue:(NSInteger)b alpha:(CGFloat)alpha;

/**
 根据16进制生成color

 @param string 16进制 支持#FFFFFFFF、#FFFFFF、#FFF、FFF
 */
+ (nullable UIColor *)u_colorWithHexString:(NSString *)string;

/**
 根据16进制生成color

 @param string 16进制 支持#FFFFFF,#FFF,FFF
 @param alpha 0~1
 */
+ (nullable UIColor *)u_colorWithHexString:(NSString *)string alpha:(CGFloat)alpha;



@end

NS_ASSUME_NONNULL_END
