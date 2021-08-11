# OC_Utils
OC工具类

开发过程中经常用的公共方法，写成分类

# NSString

/**<br>
 判断是否包含表情<br>
 */
```ObjectiveC
@property (nonatomic, readonly) BOOL u_containsEmoji;
```
/**<br>
 判断是否是干净的Int数据<br>
 */
```ObjectiveC
@property (nonatomic, readonly) BOOL u_isPureIntNumber;
```
/**<br>
 判断是否是邮箱<br>
 */
```ObjectiveC
@property (nonatomic, readonly) BOOL u_isEmail;
```
/**<br>
 判断是否是身份证<br>
 */
```ObjectiveC
@property (nonatomic, readonly) BOOL u_isIDCard;
````

/**<br>
 判断是否是中文字符<br>
 */
```ObjectiveC
@property (nonatomic, readonly) BOOL u_isChineseCharacter;
```

/**<br>
 是否是number或者英文或者中文<br>
 */
```ObjectiveC
@property (nonatomic, readonly) BOOL u_isNumberOrEnglishOrChineseCharacter;
```

/**<br>
 是否是纯正的Decimal<br>
 */
```ObjectiveC
@property (nonatomic, readonly) BOOL u_isPureDecimalDigits;
```

/**<br>  
 是否包含非法字符<br>
 @return YES：包含了非法字符 NO：没有包含非法字符<br>  
 */
```ObjectiveC
@property (nonatomic, readonly) BOOL u_containInvalidString;
```

/**<br>
 去掉空格、空行之后判断是否为空<br>
 */
```ObjectiveC
@property (nonatomic, readonly) BOOL u_isEmptyAfterTrimmingWhitespaceAndNewlineCharacters;
```

/**<br>
 MD5加密<br>
 */
```ObjectiveC
@property (nonatomic, readonly, copy) NSString *u_md5;
```
/**<br>
 sha1加密<br>
 */
```ObjectiveC
@property (nonatomic, readonly, copy) NSString *u_sha1String;
```

/**<br>
 string 转 base64 Data<br>
 */
```ObjectiveC
@property (nonatomic, readonly, copy) NSData *u_base64Data;
```

/**<br>
 string base64 encode<br>
 */
```ObjectiveC
@property (nonatomic, nullable, readonly, copy) NSString *u_base64Encoded;
```

/**<br>
 base64 encode  safe<br>
 */
```ObjectiveC
@property (nonatomic, nullable, readonly, copy) NSString *u_base64EncodedSafe;
```

/**<br>
 base64 decode  safe<br>
 */
```ObjectiveC
@property (nonatomic, nullable, readonly, copy) NSString *u_base64DecodedSafe;
```

/**<br>
 去空格、空行<br>
 */
```ObjectiveC
@property (nonatomic, readonly, copy) NSString *u_stringByTrimmingWhitespaceAndNewlineCharacters;
```

/**<br>
string encode编码<br>
 */
```ObjectiveC
@property (nonatomic, readonly, copy) NSString *u_URLEncoded;
```

/**<br>
 string decoded解码<br>
*/

```ObjectiveC
@property (nonatomic, readonly, copy) NSString *u_URLDecoded;
```

/**<br>
 将date根据format转成string<br>
 @param date 日期<br>
 @param format 格式<br>
 @return 按format格式返回string<br>
 */
```ObjectiveC
+ (NSString *)u_StringWithDate:(NSDate *)date dateFormat:(nullable NSString *)format;
```

/**<br>
 版本字符串比较<br>
 @param string 版本号<br>
 @return 升序、降序、相等<br>
 */
```ObjectiveC
- (NSComparisonResult)u_versionNumberCompare:(NSString *)string;
```

/**<br>
 长度是否在一个范围之内, 包括范围值<br>
 @param minimum 最小长度<br>
 @param maximum 最大长度<br>
 @return YES：在此范围内，NO：不在此范围内<br>
 */
```ObjectiveC
- (BOOL)u_isLengthGreaterThanOrEqual:(NSInteger)minimum lessThanOrEqual:(NSInteger)maximum;
```

/**<br>
 取出字符串中第一个url的rang<br>
 */
```ObjectiveC
- (NSRange)u_firstRangeOfURLSubstring;
```

/**<br>
 取出字符串中第一个url<br>
 */
```ObjectiveC
- (nullable NSString *)u_firstURLSubstring;
```

/**<br>
 根据正则匹配符合的第一个字符串<br>
 @param regularExpression 正则表达式<br>
 @return 符合的第一个字符串<br>
 */
```ObjectiveC
- (nullable NSString *)u_firstMatchUsingRegularExpression:(NSRegularExpression *)regularExpression;
```

/**<br>
 根据正则匹配符合的第一个字符串<br>
 @param regularExpressionPattern 正则表达式<br>
 @return 符合的第一个字符串<br>
 */
```ObjectiveC
- (nullable NSString *)u_firstMatchUsingRegularExpressionPattern:(NSString *)regularExpressionPattern;
```

/**<br>
 注意这个是全文匹配<br>
 @param regularExpressionPattern 正则表达式<br>
 @return 是否包含了符合正则表达的字符串<br>
 */
```ObjectiveC
- (BOOL)u_matchesRegularExpressionPattern:(NSString *)regularExpressionPattern;
```

/**<br>
 第一个符合正则表达式的rang<br>
 @param regularExpressionPattern 正则表达式<br>
 */
```ObjectiveC
- (NSRange)u_rangeOfFirstMatchUsingRegularExpressionPattern:(NSString *)regularExpressionPattern;
```

/**
 根据表达式查找并替换成字符串templ<br>
 @param regularExpressionPattern 正在表达式<br>
 @param templ 替换的字符串<br>
 @return 替换好的字符串<br>
 */
```ObjectiveC
- (NSString *)u_stringByReplacingMatchesUsingRegularExpressionPattern:(NSString *)regularExpressionPattern withTemplate:(NSString *)templ;
```

/**<br>
 string转json对象<br>
 */
```ObjectiveC
- (nullable id)u_JSONObject;
```

/**<br>
 string转NSURL<br>
 */
```ObjectiveC
- (NSURL *)u_toURL;
```

/**<br>
 将人数转换中文 1000、0.1万、10+ 格式 <br>
 @return 1000、0.1万、10+<br>
 */
```ObjectiveC
- (NSString *)u_numberAbbrev;
```

/**<br>
 将人数转换英文 1000、0.1W、10+ 格式<br> 
 @return 1000、0.1W、10+<br>
 */
```ObjectiveC
- (NSString *)u_numberAbbrevInEnglish;
```

/**<br>
 根据font计算size<br>
 @param font 字体<br>
 @return 计算好的size<br>
 */
```ObjectiveC
- (CGSize)u_sizeWithSingleLineFont:(UIFont *)font;
```

/**<br>
 计算字符串size<br>
 @param font 字体<br>
 @param maxWidth 最大宽度 <br>
 @param maxLineCount 最大行数 <br>
 @return 计算好的size <br>
 */
```ObjectiveC
- (CGSize)u_sizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)maxWidth lineCount:(NSUInteger)maxLineCount;
```

/** <br>
 计算字符串size <br>
 @param font 字体 <br>
 @param maxWidth 最大宽度 <br>
 @param maxLineCount 最大行数 <br>
 @param constrained 是否受限制 <br>
 @return 计算好的size <br>
 */
```ObjectiveC
- (CGSize)u_sizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)maxWidth lineCount:(NSUInteger)maxLineCount constrained:(BOOL *)constrained;
```

/**<br>
 计算字符串height<br>
 @param font 字体<br>
 @param maxWidth 最大宽<br><br>
 @param maxLineCount 最大行数<br>
 @return 计算好的height<br>
 */
```ObjectiveC
- (CGFloat)u_heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)maxWidth lineCount:(NSUInteger)maxLineCount;
```

/**<br>
 计算字符串height<br> 
 @param font 字体<br>
 @param maxWidth 最大宽<br>
 @param maxLineCount 最大行数<br>
 @param constrained 是否受限制<br>
 @return 计算好的height<br>
 */
```ObjectiveC
- (CGFloat)u_heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)maxWidth lineCount:(NSUInteger)maxLineCount constrained:(BOOL *)constrained;
```

/**<br>
  计算字符串size<br>
 @param font 字体<br>
 @param maxHeight 最大高<br>
 @param maxLineCount 最大行数<br>
 @return 计算好的size<br>
 */
```ObjectiveC
- (CGSize)u_sizeWithFont:(UIFont *)font constrainedToHeight:(CGFloat)maxHeight lineCount:(NSUInteger)maxLineCount;

- (CGSize)u_sizeWithFont:(UIFont *)font constrainedToHeight:(CGFloat)maxheight lineCount:(NSUInteger)maxLineCount constrained:(BOOL *)constrained;

- (CGFloat)u_widthWithFont:(UIFont *)font constrainedToHeight:(CGFloat)maxHeight lineCount:(NSUInteger)maxLineCount;
```

# NSData

/**<br>
 MD5加密<br>
 */
```ObjectiveC
- (NSString *)u_md5String;
```

/**<br>
 base64编码<br>
 */
```ObjectiveC
- (NSString *)u_base64EncodedString;
```

/**<br>
 base64编码<br>
 */
```ObjectiveC
- (NSString *)u_base64EncodedStringWithLineLength:(NSUInteger)lineLength;
```

/**<br>
 base64解码<br>
 */
```ObjectiveC
- (NSData *)u_base64Decoded;
```

/**<br>
 是否有这个前缀字节<br>
 */
```ObjectiveC
- (BOOL)u_hasPrefixBytes:(const void *)prefix length:(NSUInteger)length;
```

/**<br>
 是否有这个后缀字节<br>
 */
```ObjectiveC
- (BOOL)u_hasSuffixBytes:(const void *)suffix length:(NSUInteger)length;
```

/**<br>
 图片格式<br>
 */
```ObjectiveC
@property (nonatomic, readonly) UImageFormat imageFormat;
```

/**<br>
 图片格式名称<br>
 */
```ObjectiveC
@property (nonatomic, readonly, nullable, copy) NSString *imageMIMEType;
```
# NSArray
# NSMutableArray
# NSDate
# NSAttributedString
# NSDateFormatter
# NSDictionary
# NSNumber
# NSError
# NSFileManager
# NSNull
# NSObject
# NSURL
