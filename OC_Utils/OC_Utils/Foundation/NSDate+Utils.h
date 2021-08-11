//
//  NSDate+Utils.h
//  OC_Utils
//
//  Created by WWQ on 2021/8/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (Utils)


/**
 是否是今天
 */
@property (nonatomic, readonly) BOOL u_isToday;

/**
 是否是明天
 */
@property (nonatomic, readonly) BOOL u_isTomorrow;

/**
 是否是昨天
 */
@property (nonatomic, readonly) BOOL u_isYesterday;

/**
 是否是这个月
 */
@property (nonatomic, readonly) BOOL u_isThisMonth;

/**
 是否是今年
 */
@property (nonatomic, readonly) BOOL u_isThisYear;

/**
 是否是明年
 */
@property (nonatomic, readonly) BOOL u_isNextYear;

/**
 是否是去年
 */
@property (nonatomic, readonly) BOOL u_isLastYear;

/**
 是否是将来
 */
@property (nonatomic, readonly) BOOL u_isInFuture;

/**
 是否是过去
 */
@property (nonatomic, readonly) BOOL u_isInPast;

/**
 获取year
 */
@property (nonatomic, readonly) NSInteger u_year;

/**
 获取month
 */
@property (nonatomic, readonly) NSInteger u_month;

/**
 获取day
 */
@property (nonatomic, readonly) NSInteger u_day;

/**
 获取一年内的第几周
 */
@property (nonatomic, readonly) NSInteger u_weekOfYear;

/**
 获取星期几
 */
@property (nonatomic, readonly) NSInteger u_weekday;

/**
 表示WeekDay在下一个更大的日历单元中的位置。例如WeekDay=3，WeekDayOrdinal=2  就表示这个月的第2个周二。
 */
@property (nonatomic, readonly) NSInteger u_weekdayOrdinal;

/**
 获取小时
 */
@property (nonatomic, readonly) NSInteger u_hour;

/**
 获取分钟
 */
@property (nonatomic, readonly) NSInteger u_minute;

/**
 获取秒
 */
@property (nonatomic, readonly) NSInteger u_seconds;

/**
 转换成一定格式的string
 若format为nil ,默认为 yyyy.MM.dd HH: mm: ss 格式

 @param format 格式
 @return 返回string
 */
- (NSString *)u_stringRepresentationWithDateFormat:(nullable NSString *)format;

/**
 string转Date
 
 @param string 时间String
 @param format 格式
 @return Date
 */
+ (nullable NSDate *)u_dateWithString:(NSString *)string format:(NSString *)format;

/**
 判断时间是否相等（忽略time）

 @param aDate 时间
 */
- (BOOL)u_isEqualToDateIgnoringTime:(NSDate *)aDate;

/**
 判断是否是同一周

 @param aDate 时间
 @param firstWeekday first weekday in a week (1-Sunday, 2-Monday, 3-Tuesday...)
 */
- (BOOL)u_isSameWeekAsDate:(NSDate *)aDate firstWeekday:(NSUInteger)firstWeekday;

/**
 判断是否是同一个月
 */
- (BOOL)u_isSameMonthAsDate:(NSDate *)aDate;

/**
 判断是否是同一年
 */
- (BOOL)u_isSameYearAsDate:(NSDate *)aDate;

/**
 跟另一个时间比早

 @param otherDate 另一个时间
 @return YES：比otherDate早 NO：比otherDate不早
 */
- (BOOL)u_earlierThan:(NSDate *)otherDate;

/**
  跟另一个时间比晚

 @param otherDate 另一个时间
 @return YES：比otherDate晚 NO：比otherDate不晚
 */
- (BOOL)u_laterThan:(NSDate *)otherDate;

/**
 string按一定的格式转换date
 格式：@"yyyy-MM-dd HH:mm:ss"
 
 @param dateString 时间string
 @return date
 */
+ (NSDate *)dateFromLongString:(NSString *)dateString;

/**
 string按一定的格式转换date
 格式：@"yyyyMMdd"
 
 @param dateString 时间string
 @return date
 */
+ (NSDate *)dateFromDayString:(NSString *)dateString;

/**
 格式化数据

 @param date date
 @param timeString 将替换的时间
 @return date 格式：@"yyyy-MM-dd HH:mm"
 */
+ (NSDate *)dateFromDate:(NSDate *)date replaceWithTimeString:(NSString *)timeString;

/**
 date转string
 格式："M月d日 HH:mm"
 
 @param date date
 @return string
 */
+ (NSString *)stringFromDate1:(NSDate *)date;

/**
 date转string
 格式："yyyy-MM-dd"
 
 @param date date
 @return string
 */
+ (NSString *)stringFromDate2:(NSDate *)date;

/**
 date转string
 格式："yyyyMMdd"
 
 @param date date
 @return string
 */
+ (NSString *)stringFromDate3:(NSDate *)date;

/**
 date转string
 格式："yyyy-MM-dd HH:mm:ss"
 
 @param date date
 @return string
 */
+ (NSString *)stringFromDate4:(NSDate *)date;

/**
 date转string
 格式："yyyy年MM月dd日"
 
 @param date date
 @return string
 */
+ (NSString *)stringFromDate5:(NSDate *)date;

/**
 date转string
 格式："M'.'d"
 
 @param date date
 @return string
 */
+ (NSString *)dateStringFromDate5:(NSDate *)date;

/**
 date转string
 格式："M月d日"
 
 @param date date
 @return string
 */
+ (NSString *)dateStringFromDate:(NSDate *)date;

/**
 date转string
 格式："HH:mm"
 
 @param date date
 @return string
 */
+ (NSString *)timeStringFromDate:(NSDate *)date;

/**
 date转string
 格式："EEEE"
 
 @param date date
 @return string
 */
+ (NSString *)weekdayFromDate:(NSDate *)date;

/**
 date转string
 格式："M月d日 EEEE"
 
 @param date date
 @return string
 */
+ (NSString *)weekdayFromDate1:(NSDate *)date;

/**
 date转string
 格式："M月d日 EEEE"
 
 @param date date
 @return string
 */
+ (NSString *)weekdayFromDate2:(NSDate *)date;

/**
 date转string
 格式："yyyy-MM-dd HH:mm:ss.SSS"
 
 @param date date
 @return string
 */
+ (NSString *)longStringFromDate:(NSDate *)date;



@end

NS_ASSUME_NONNULL_END
