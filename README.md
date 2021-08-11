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
 @param maxWidth 最大宽<br>
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

/** <br>
 获取符合正则的数据 <br>
 @param predicate 正则的block <br>
 */
```ObjectiveC
- (NSArray<ObjectType> *)u_arrayWithObjectsPassingTest:(BOOL (^)(id obj, NSUInteger idx, BOOL *stop))predicate;
```

/** <br>
 移除class为aClass的对象 <br>
 */
```ObjectiveC
- (NSArray<ObjectType> *)u_arrayByRemovingObjectsOfClass:(Class)aClass;
```

/** <br>
 保留class为aClass的对象 <br>
 */
```ObjectiveC
- (NSArray<ObjectType> *)u_arrayByKeepingObjectsOfClass:(Class)aClass;
```

/** <br>
 将otherArray里面的对象从当前数组移除 <br>
 */
```ObjectiveC
- (NSArray<ObjectType> *)u_arrayByRemovingObjectsFromArray:(NSArray<ObjectType> *)otherArray;
```

/** <br>
 获取符合正则的对象 <br>
 */
```ObjectiveC
- (nullable ObjectType)u_objectPassingTest:(BOOL (^)(id obj, NSUInteger idx, BOOL *stop))predicate;
```

/** <br>
 取出某一位置的对象，有边界检查 <br>
 */
```ObjectiveC
- (nullable ObjectType)u_nullableObjectAtIndex:(NSInteger)index;
```

/** <br>
 duplicate objects with other array. <br>
 */
```ObjectiveC
- (NSArray<ObjectType> *)u_duplicateObjectsWithArray:(NSArray<ObjectType> *)otherArray;
```

/** <br>
 用handler进行匹配 <br>
 */
```ObjectiveC
- (NSArray *)u_mapUsing:(id (^)(ObjectType originalObject, NSUInteger index))handler;
```

/** <br>
 数组转json字符串 <br>
 */
```ObjectiveC
- (nullable NSString *)u_JSONString;
```

# NSMutableArray

/** <br>
 生成一定容量的数组 <br>
 @param capacity 容量 <br>
 @return 数组 <br>
 */
```ObjectiveC
+ (NSMutableArray<ObjectType> *)u_nullArrayWithCapacity:(NSUInteger)capacity;
```

/** <br>
 根据正则删除符合的对象 <br>
 @param predicate 正则 <br>
 */
```ObjectiveC
- (void)u_removeObjectsPassingTest:(BOOL (^)(id obj, NSUInteger idx, BOOL *stop))predicate;
```

/** <br>
 超出最大容量删除老的数据 <br>
 @param maxCount 最大容量 <br>
 */
```ObjectiveC
- (void)u_removeLatterObjectsToKeepObjectsNoMoreThan:(NSInteger)maxCount;
```

/** <br>
 将 index 位置处的 object 替换成 anotherObject <br>
 */
```ObjectiveC
- (void)u_replaceObjectAtIndex:(NSUInteger)index withObject:(ObjectType)anotherObject;
```

/** <br>
 将anObject替换成anotherObject <br>
 */
```ObjectiveC
- (void)u_replaceObject:(ObjectType)anObject withObject:(ObjectType)anotherObject;
```

/** <br>
 插入对象 <br>
 @param anObject 对象 <br>
 */
```ObjectiveC
- (void)u_insertUniqueObject:(ObjectType)anObject;
```

/** <br>
 将对象插入某一位置 <br>
 @param anObject 对象 <br>
 @param index 位置 <br>
 */
```ObjectiveC
- (void)u_insertUniqueObject:(ObjectType)anObject atIndex:(NSInteger)index;
```

/** <br>
 从otherArray插入对象（去重） <br>
 @param otherArray 另一个数据 <br>
 */
```ObjectiveC
- (void)u_insertUniqueObjectsFromArray:(NSArray<ObjectType> *)otherArray;
```

/** <br>
 insert a nullable object, if the object is nil, does nothing  <br>
 @param anObject an object to insert <br>
 @param index the index where to insert <br>
 */
```ObjectiveC
- (void)u_insertNullableObject:(nullable ObjectType)anObject atIndex:(NSUInteger)index;
```

/** <br>
 从otherArray追加对象 <br>
 @param otherArray 另一个数组 <br>
 */
```ObjectiveC
- (void)u_appendUniqueObjectsFromArray:(NSArray<ObjectType> *)otherArray;
```

/** <br>
 添加可空的对象 <br>
 @param anObject 可能为nil的对象 <br>
 */ 
```ObjectiveC
- (void)u_appendNullableObject:(nullable ObjectType)anObject;
```

/** <br>
 将对象移到另一个位置 <br>
 @param object 对象 <br>
 @param index 另外的位置 <br>
 */
```ObjectiveC
- (void)u_moveObject:(ObjectType)object toIndex:(NSUInteger)index;
```

/** <br>
 从otherArray中获取下一页数据并加入当前数组 <br>
 @param otherArray 另一个数组 <br>
 @param pageSize 一页数量 <br>
 */
```ObjectiveC
- (BOOL)u_appendObjectsInLastPageFromArray:(NSArray<ObjectType> *)otherArray pageSize:(NSUInteger)pageSize;
```

# NSDate

/** <br>
 是否是今天 <br>
 */
```ObjectiveC
@property (nonatomic, readonly) BOOL u_isToday;
```

/** <br>
 是否是明天 <br>
 */
```ObjectiveC
@property (nonatomic, readonly) BOOL u_isTomorrow;
```

/** <br>
 是否是昨天 <br>
 */
```ObjectiveC
@property (nonatomic, readonly) BOOL u_isYesterday;
```

/** <br>
 是否是这个月 <br>
 */
```ObjectiveC
@property (nonatomic, readonly) BOOL u_isThisMonth;
```

/** <br>
 是否是今年 <br>
 */
```ObjectiveC
@property (nonatomic, readonly) BOOL u_isThisYear;
```

/** <br>
 是否是明年 <br>
 */
```ObjectiveC
@property (nonatomic, readonly) BOOL u_isNextYear;
```

/** <br>
 是否是去年 <br>
 */
```ObjectiveC
@property (nonatomic, readonly) BOOL u_isLastYear;
```

/** <br>
 是否是将来 <br>
 */
```ObjectiveC
@property (nonatomic, readonly) BOOL u_isInFuture;
```

/** <br>
 是否是过去 <br>
 */
```ObjectiveC
@property (nonatomic, readonly) BOOL u_isInPast;
```

/** <br>
 获取year <br>
 */
```ObjectiveC
@property (nonatomic, readonly) NSInteger u_year;
```

/** <br>
 获取month <br>
 */
```ObjectiveC
@property (nonatomic, readonly) NSInteger u_month;
```

/** <br>
 获取day <br>
 */
```ObjectiveC
@property (nonatomic, readonly) NSInteger u_day;
```

/** <br>
 获取一年内的第几周 <br>
 */
```ObjectiveC
@property (nonatomic, readonly) NSInteger u_weekOfYear;
```

/** <br>
 获取星期几 <br>
 */
```ObjectiveC
@property (nonatomic, readonly) NSInteger u_weekday;
```

/** <br>
 表示WeekDay在下一个更大的日历单元中的位置。例如WeekDay=3，WeekDayOrdinal=2  就表示这个月的第2个周二。 <br>
 */
```ObjectiveC
@property (nonatomic, readonly) NSInteger u_weekdayOrdinal;
```

/** <br>
 获取小时 <br>
 */
```ObjectiveC
@property (nonatomic, readonly) NSInteger u_hour;
```

/** <br>
 获取分钟 <br>
 */
```ObjectiveC
@property (nonatomic, readonly) NSInteger u_minute;
```

/** <br>
 获取秒 <br>
 */
```ObjectiveC
@property (nonatomic, readonly) NSInteger u_seconds;
```

/** <br>
 转换成一定格式的string <br>
 若format为nil ,默认为 yyyy.MM.dd HH: mm: ss 格式 <br>
 @param format 格式 <br>
 @return 返回string <br>
 */
```ObjectiveC
- (NSString *)u_stringRepresentationWithDateFormat:(nullable NSString *)format;
```

/** <br>
 string转Date <br>
 @param string 时间String <br>
 @param format 格式 <br>
 @return Date <br>
 */
```ObjectiveC
+ (nullable NSDate *)u_dateWithString:(NSString *)string format:(NSString *)format;
```

/** <br>
 判断时间是否相等（忽略time） <br>
 @param aDate 时间 <br>
 */
```ObjectiveC
- (BOOL)u_isEqualToDateIgnoringTime:(NSDate *)aDate;
```

/** <br>
 判断是否是同一周 <br>
 @param aDate 时间 <br>
 @param firstWeekday first weekday in a week (1-Sunday, 2-Monday, 3-Tuesday...) <br>
 */
```ObjectiveC
- (BOOL)u_isSameWeekAsDate:(NSDate *)aDate firstWeekday:(NSUInteger)firstWeekday;
```

/** <br>
 判断是否是同一个月 <br>
 */
```ObjectiveC
- (BOOL)u_isSameMonthAsDate:(NSDate *)aDate;
```

/** <br>
 判断是否是同一年 <br>
 */
```ObjectiveC
- (BOOL)u_isSameYearAsDate:(NSDate *)aDate;
```

/** <br>
 跟另一个时间比早 <br>
 @param otherDate 另一个时间 <br>
 @return YES：比otherDate早 NO：比otherDate不早 <br>
 */
```ObjectiveC
- (BOOL)u_earlierThan:(NSDate *)otherDate;
```

/** <br>
  跟另一个时间比晚 <br>
 @param otherDate 另一个时间 <br>
 @return YES：比otherDate晚 NO：比otherDate不晚 <br>
 */
```ObjectiveC
- (BOOL)u_laterThan:(NSDate *)otherDate;
```

/** <br>
 string按一定的格式转换date <br>
 格式：@"yyyy-MM-dd HH:mm:ss"  <br>
 @param dateString 时间string <br>
 @return date <br>
 */
```ObjectiveC
+ (NSDate *)dateFromLongString:(NSString *)dateString;
```

/** <br>
 string按一定的格式转换date <br>
 格式：@"yyyyMMdd"  <br>
 @param dateString 时间string <br>
 @return date <br>
 */
```ObjectiveC
+ (NSDate *)dateFromDayString:(NSString *)dateString;
```

/** <br>
 格式化数据 <br>
 @param date date <br>
 @param timeString 将替换的时间 <br>
 @return date 格式：@"yyyy-MM-dd HH:mm" <br>
 */
```ObjectiveC
+ (NSDate *)dateFromDate:(NSDate *)date replaceWithTimeString:(NSString *)timeString;
```

/** <br>
 date转string <br>
 格式："M月d日 HH:mm"  <br>
 @param date date <br>
 @return string <br>
 */
```ObjectiveC
+ (NSString *)stringFromDate1:(NSDate *)date;
```

/** <br>
 date转string <br>
 格式："yyyy-MM-dd"  <br>
 @param date date <br>
 @return string <br>
 */
```ObjectiveC
+ (NSString *)stringFromDate2:(NSDate *)date;
```

/** <br>
 date转string <br>
 格式："yyyyMMdd"  <br>
 @param date date <br>
 @return string <br>
 */
```ObjectiveC
+ (NSString *)stringFromDate3:(NSDate *)date;
```

/** <br>
 date转string <br>
 格式："yyyy-MM-dd HH:mm:ss"  <br>
 @param date date <br>
 @return string <br>
 */
```ObjectiveC
+ (NSString *)stringFromDate4:(NSDate *)date;
```

/** <br>
 date转string <br>
 格式："yyyy年MM月dd日"  <br>
 @param date date <br>
 @return string <br>
 */
```ObjectiveC
+ (NSString *)stringFromDate5:(NSDate *)date;
```

/** <br>
 date转string <br>
 格式："M'.'d"  <br>
 @param date date <br>
 @return string <br>
 */
```ObjectiveC
+ (NSString *)dateStringFromDate5:(NSDate *)date;
```

/** <br>
 date转string <br>
 格式："M月d日"  <br>
 @param date date <br>
 @return string <br>
 */
```ObjectiveC
+ (NSString *)dateStringFromDate:(NSDate *)date;
```

/** <br>
 date转string <br>
 格式："HH:mm"  <br>
 @param date date <br>
 @return string <br>
 */
```ObjectiveC
+ (NSString *)timeStringFromDate:(NSDate *)date;
```

/** <br>
 date转string <br>
 格式："EEEE"  <br>
 @param date date <br>
 @return string <br>
 */
```ObjectiveC
+ (NSString *)weekdayFromDate:(NSDate *)date;
```

/** <br>
 date转string <br>
 格式："M月d日 EEEE"  <br>
 @param date date <br>
 @return string <br>
 */
```ObjectiveC
+ (NSString *)weekdayFromDate1:(NSDate *)date;
```

/** <br>
 date转string <br>
 格式："M月d日 EEEE"  <br>
 @param date date <br>
 @return string <br>
 */
```ObjectiveC
+ (NSString *)weekdayFromDate2:(NSDate *)date;
```

/** <br>
 date转string <br>
 格式："yyyy-MM-dd HH:mm:ss.SSS"  <br>
 @param date date <br>
 @return string <br>
 */
```ObjectiveC
+ (NSString *)longStringFromDate:(NSDate *)date;
```

# NSAttributedString

/** <br>
 初始化 <br>
 */
```ObjectiveC
- (instancetype)initWithString:(NSString *)string font:(UIFont *)font foregroundColor:(UIColor *)foregroundColor lineSpacing:(CGFloat)lineSpacing;
```

/** <br>
 计算AttributedString的高度  <br>
 @param maxWidth 最大宽 <br>
 @return 返回AttributedString的高度 <br>
 */
```ObjectiveC
- (CGFloat)u_heightConstrainedToWidth:(CGFloat)maxWidth;
```

/** <br>
 计算AttributedString的高度  <br>
 @param font 字体 <br>
 @param lineSpacing 行间距 <br>
 @param maxWidth 最大宽 <br>
 @param maxLineCount 最大行数 <br>
 @return 返回AttributedString的高度 <br>
 */
```ObjectiveC
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
````

# NSDictionary

/** <br>
 字典转url字符串 <br>
 */
```ObjectiveC
- (NSString *)u_stringRepresentationByURLEncoding;
```

/** <br>
 根据key取字符串  <br>
 @param key key字符串 <br>
 */
```ObjectiveC
- (NSString *)u_stringForKey:(KeyType)key;
```

/** <br>
 根据key取integer  <br>
 @param key key字符串 <br>
 */
```ObjectiveC
- (NSInteger)u_integerForKey:(KeyType)key;
```

/** <br>
 根据key取double  <br>
 @param key key字符串 <br>
 */
```ObjectiveC
- (double)u_doubleForKey:(KeyType)key;
```

/** <br>
 根据key取bool <br>
 @param key key字符串 <br>
 */
```ObjectiveC
- (BOOL)u_boolForKey:(KeyType)key;
```

/** <br>
 根据key取数组 <br>
 @param key key字符串 <br>
 */
```ObjectiveC
- (NSArray<id> *)u_arrayForKey:(KeyType)key;
```

/** <br>
 根据key取字典 <br>
 @param key key字符串 <br>
 */
```ObjectiveC
- (NSDictionary<id, id> *)u_dictionaryForKey:(KeyType)key;
```

/** <br>
 字典转json字符串 <br>
 */
```ObjectiveC
- (nullable NSString *)u_JSONString;
```

/** <br>
 字典转json字符串 <br>
 */
```ObjectiveC
- (NSArray<KeyType> *)u_duplicateKeysWithDictionary:(NSDictionary<KeyType, id> *)otherDictionary;
```

/** <br>
 是否包含某key <br>
 @param key key名称 <br>
 */
```ObjectiveC
- (BOOL)u_hasKey:(KeyType)key;
```

# NSNumber

/** <br>
  number 转 string <br>
 */
```ObjectiveC
@property (nonatomic, readonly, copy) NSString *u_formattedString;
```
