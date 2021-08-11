//
//  NSString+Utils.h
//  OC_Utils
//
//  Created by WWQ on 2021/8/10.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface NSString (Utils)

/******************** validation *************************/


/**
 判断是否包含表情
 */
@property (nonatomic, readonly) BOOL u_containsEmoji;

/**
 判断是否是干净的Int数据
 */
@property (nonatomic, readonly) BOOL u_isPureIntNumber;

/**
 判断是否是邮箱
 */
@property (nonatomic, readonly) BOOL u_isEmail;

/**
 判断是否是身份证
 */
@property (nonatomic, readonly) BOOL u_isIDCard;


/**
 判断是否是中文字符
 */
@property (nonatomic, readonly) BOOL u_isChineseCharacter;


/**
 是否是number或者英文或者中文
 */
@property (nonatomic, readonly) BOOL u_isNumberOrEnglishOrChineseCharacter;


/**
 是否是纯正的Decimal
 */
@property (nonatomic, readonly) BOOL u_isPureDecimalDigits;


/**
 是否包含非法字符
 
 @return YES：包含了非法字符 NO：没有包含非法字符
 */
@property (nonatomic, readonly) BOOL u_containInvalidString;


/**
 去掉空格、空行之后判断是否为空
 */
@property (nonatomic, readonly) BOOL u_isEmptyAfterTrimmingWhitespaceAndNewlineCharacters;


/********************** format *************************/

/**
 MD5加密
 */
@property (nonatomic, readonly, copy) NSString *u_md5;

/**
 sha1加密
 */
@property (nonatomic, readonly, copy) NSString *u_sha1String;

/**
 string 转 base64 Data
 */
@property (nonatomic, readonly, copy) NSData *u_base64Data;

@property (nonatomic, nullable, readonly, copy) NSString *u_base64Encoded;

/**
 base64 encode  safe
 */
@property (nonatomic, nullable, readonly, copy) NSString *u_base64EncodedSafe;

/**
 base64 decode  safe
 */
@property (nonatomic, nullable, readonly, copy) NSString *u_base64DecodedSafe;


/**
 去空格、空行
 */
@property (nonatomic, readonly, copy) NSString *u_stringByTrimmingWhitespaceAndNewlineCharacters;

/**
string encode编码
 */
@property (nonatomic, readonly, copy) NSString *u_URLEncoded;

/**
 string decoded解码
 */
@property (nonatomic, readonly, copy) NSString *u_URLDecoded;

/**
 将date根据format转成string

 @param date 日期
 @param format 格式
 @return 按format格式返回string
 */
+ (NSString *)u_StringWithDate:(NSDate *)date dateFormat:(nullable NSString *)format;

/**
 版本字符串比较

 @param string 版本号
 @return 升序、降序、相等
 */
- (NSComparisonResult)u_versionNumberCompare:(NSString *)string;


/**
 长度是否在一个范围之内, 包括范围值

 @param minimum 最小长度
 @param maximum 最大长度
 @return YES：在此范围内，NO：不在此范围内
 */
- (BOOL)u_isLengthGreaterThanOrEqual:(NSInteger)minimum lessThanOrEqual:(NSInteger)maximum;

/**
 取出字符串中第一个url的rang
 */
- (NSRange)u_firstRangeOfURLSubstring;

/**
 取出字符串中第一个url
 */
- (nullable NSString *)u_firstURLSubstring;

/**
 根据正则匹配符合的第一个字符串

 @param regularExpression 正则表达式
 @return 符合的第一个字符串
 */
- (nullable NSString *)u_firstMatchUsingRegularExpression:(NSRegularExpression *)regularExpression;

/**
 根据正则匹配符合的第一个字符串
 
 @param regularExpressionPattern 正则表达式
 @return 符合的第一个字符串
 */
- (nullable NSString *)u_firstMatchUsingRegularExpressionPattern:(NSString *)regularExpressionPattern;


/**
 注意这个是全文匹配
 
 @param regularExpressionPattern 正则表达式
 @return 是否包含了符合正则表达的字符串
 */
- (BOOL)u_matchesRegularExpressionPattern:(NSString *)regularExpressionPattern;

/**
第一个符合正则表达式的rang

 @param regularExpressionPattern 正则表达式
 */
- (NSRange)u_rangeOfFirstMatchUsingRegularExpressionPattern:(NSString *)regularExpressionPattern;

/**
 根据表达式查找并替换成字符串templ

 @param regularExpressionPattern 正在表达式
 @param templ 替换的字符串
 @return 替换好的字符串
 */
- (NSString *)u_stringByReplacingMatchesUsingRegularExpressionPattern:(NSString *)regularExpressionPattern withTemplate:(NSString *)templ;

/**
 string转json对象
 */
- (nullable id)u_JSONObject;

/**
 string转NSURL
 */
- (NSURL *)u_toURL;

/**
 将人数转换中文 1000、0.1万、10+ 格式
 
 @return 1000、0.1万、10+
 */
- (NSString *)u_numberAbbrev;

/**
 将人数转换英文 1000、0.1W、10+ 格式
 
 @return 1000、0.1W、10+
 */
- (NSString *)u_numberAbbrevInEnglish;

/********************** size *************************/

/**
 根据font计算size
 
 @param font 字体
 @return 计算好的size
 */
- (CGSize)u_sizeWithSingleLineFont:(UIFont *)font;


/**
 计算字符串size

 @param font 字体
 @param maxWidth 最大宽度
 @param maxLineCount 最大行数
 @return 计算好的size
 */
- (CGSize)u_sizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)maxWidth lineCount:(NSUInteger)maxLineCount;

/**
  计算字符串size

 @param font 字体
 @param maxWidth 最大宽度
 @param maxLineCount 最大行数
 @param constrained 是否受限制
 @return 计算好的size
 */
- (CGSize)u_sizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)maxWidth lineCount:(NSUInteger)maxLineCount constrained:(BOOL *)constrained;

/**
 计算字符串height

 @param font 字体
 @param maxWidth 最大宽
 @param maxLineCount 最大行数
 @return 计算好的height
 */
- (CGFloat)u_heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)maxWidth lineCount:(NSUInteger)maxLineCount;

/**
 计算字符串height
 
 @param font 字体
 @param maxWidth 最大宽
 @param maxLineCount 最大行数
 @param constrained 是否受限制
 @return 计算好的height
 */
- (CGFloat)u_heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)maxWidth lineCount:(NSUInteger)maxLineCount constrained:(BOOL *)constrained;

/**
  计算字符串size

 @param font 字体
 @param maxHeight 最大高
 @param maxLineCount 最大行数
 @return 计算好的size
 */
- (CGSize)u_sizeWithFont:(UIFont *)font constrainedToHeight:(CGFloat)maxHeight lineCount:(NSUInteger)maxLineCount;

- (CGSize)u_sizeWithFont:(UIFont *)font constrainedToHeight:(CGFloat)maxheight lineCount:(NSUInteger)maxLineCount constrained:(BOOL *)constrained;

- (CGFloat)u_widthWithFont:(UIFont *)font constrainedToHeight:(CGFloat)maxHeight lineCount:(NSUInteger)maxLineCount;


@end

NS_ASSUME_NONNULL_END
