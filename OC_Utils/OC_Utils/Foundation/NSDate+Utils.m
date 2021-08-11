//
//  NSDate+Utils.m
//  OC_Utils
//
//  Created by WWQ on 2021/8/11.
//

#import "NSDate+Utils.h"

@implementation NSDate (Utils)


- (NSString *)u_stringRepresentationWithDateFormat:(nullable NSString *)format {
    static NSDateFormatter *formatter_ = nil;
    formatter_ = [[NSDateFormatter alloc] init];
    NSString *dateFormat = nil;
    if (format == nil) {
        dateFormat = @"yyyy.MM.dd HH: mm: ss";
    } else {
        dateFormat = format;
    }
    formatter_.dateFormat = dateFormat;
    NSString *dateString = [formatter_ stringFromDate:self];
    return dateString;
}


+ (NSDate *)u_dateWithString:(NSString *)string format:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    dateFormatter.dateFormat = format;
    NSDate *date = [dateFormatter dateFromString:string];
    return date;
}


- (BOOL)u_isEqualToDateIgnoringTime:(NSDate *)aDate {
    NSDateComponents *components1 = [NSCalendar.currentCalendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    NSDateComponents *components2 = [NSCalendar.currentCalendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:aDate];
    return ((components1.year == components2.year) &&
            (components1.month == components2.month) &&
            (components1.day == components2.day));
}


- (BOOL)u_isToday {
    return [self u_isEqualToDateIgnoringTime:[NSDate date]];
}


- (BOOL)u_isTomorrow {
    NSDate *tomorrow = [NSDate dateWithTimeIntervalSinceNow:60.0 * 60.0 * 24.0];
    return [self u_isEqualToDateIgnoringTime:tomorrow];
}


- (BOOL)u_isYesterday {
    NSDate *yesterday = [NSDate dateWithTimeIntervalSinceNow:60.0 * 60.0 * 24.0 * (-1.0)];
    return [self u_isEqualToDateIgnoringTime:yesterday];
}


- (BOOL)u_isSameWeekAsDate:(NSDate *)aDate firstWeekday:(NSUInteger)firstWeekday {
    NSCalendar *calendar = NSCalendar.currentCalendar;
    calendar.firstWeekday = firstWeekday;
    NSDateComponents *components1 = [calendar components:NSCalendarUnitYear | NSCalendarUnitWeekOfYear fromDate:self];
    NSDateComponents *components2 = [calendar components:NSCalendarUnitYear | NSCalendarUnitWeekOfYear fromDate:aDate];
    return ((components1.year == components2.year) &&
            (components1.weekOfYear == components2.weekOfYear));
}


- (BOOL)u_isSameMonthAsDate:(NSDate *)aDate {
    NSDateComponents *components1 = [NSCalendar.currentCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:self];
    NSDateComponents *components2 = [NSCalendar.currentCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:aDate];
    return ((components1.month == components2.month) &&
            (components1.year == components2.year));
}


- (BOOL)u_isThisMonth {
    return [self u_isSameMonthAsDate:[NSDate date]];
}


- (BOOL)u_isSameYearAsDate:(NSDate *)aDate {
    NSDateComponents *components1 = [NSCalendar.currentCalendar components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [NSCalendar.currentCalendar components:NSCalendarUnitYear fromDate:aDate];
    return (components1.year == components2.year);
}


- (BOOL)u_isThisYear {
    // Thanks, baspellis
    return [self u_isSameYearAsDate:[NSDate date]];
}


- (BOOL)u_isNextYear {
    NSDateComponents *components1 = [NSCalendar.currentCalendar components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [NSCalendar.currentCalendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return (components1.year == (components2.year + 1));
}


- (BOOL)u_isLastYear {
    NSDateComponents *components1 = [NSCalendar.currentCalendar components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [NSCalendar.currentCalendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return (components1.year == (components2.year - 1));
}


- (BOOL)u_earlierThan:(NSDate *)otherDate {
    return ([self compare:otherDate] == NSOrderedAscending);
}


- (BOOL)u_laterThan:(NSDate *)otherDate {
    return ([self compare:otherDate] == NSOrderedDescending);
}


- (BOOL)u_isInFuture {
    return ([self u_laterThan:[NSDate date]]);
}


- (BOOL)u_isInPast {
    return ([self u_earlierThan:[NSDate date]]);
}


- (NSInteger)u_year {
    NSDateComponents *components = [NSCalendar.currentCalendar components:NSCalendarUnitYear fromDate:self];
    return components.year;
}


- (NSInteger)u_month {
    NSDateComponents *components = [NSCalendar.currentCalendar components:NSCalendarUnitMonth fromDate:self];
    return components.month;
}


- (NSInteger)u_day {
    NSDateComponents *components = [NSCalendar.currentCalendar components:NSCalendarUnitDay fromDate:self];
    return components.day;
}


- (NSInteger)u_weekOfYear {
    NSDateComponents *components = [NSCalendar.currentCalendar components:NSCalendarUnitWeekOfYear fromDate:self];
    return components.weekOfYear;
}


- (NSInteger)u_weekday {
    NSDateComponents *components = [NSCalendar.currentCalendar components:NSCalendarUnitWeekday fromDate:self];
    return components.weekday;
}


- (NSInteger)u_weekdayOrdinal {
    NSDateComponents *components = [NSCalendar.currentCalendar components:NSCalendarUnitWeekdayOrdinal fromDate:self];
    return components.weekdayOrdinal;
}


- (NSInteger)u_hour {
    NSDateComponents *components = [NSCalendar.currentCalendar components:NSCalendarUnitHour fromDate:self];
    return components.hour;
}


- (NSInteger)u_minute {
    NSDateComponents *components = [NSCalendar.currentCalendar components:NSCalendarUnitMinute fromDate:self];
    return components.minute;
}


- (NSInteger)u_seconds {
    NSDateComponents *components = [NSCalendar.currentCalendar components:NSCalendarUnitSecond fromDate:self];
    return components.second;
}


+ (NSDate *)dateFromLongString:(NSString *)dateString {
    static NSDateFormatter *formatter = nil;
    
    if (!formatter) {
        @synchronized(self) {
            formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        }
    }
    
    return [formatter dateFromString:dateString];
}


+ (NSDate *)dateFromDayString:(NSString *)dayString {
    static NSDateFormatter *formatter = nil;
    
    if (!formatter) {
        @synchronized(self) {
            formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyyMMdd"];
        }
    }
    
    return [formatter dateFromString:dayString];
}


+ (NSDate *)dateFromDate:(NSDate *)date replaceWithTimeString:(NSString *)timeString {
    static NSDateFormatter *dayFormatter = nil;
    static NSDateFormatter *dateFormatter = nil;
    
    if (!dayFormatter) {
        @synchronized(self) {
            dayFormatter = [[NSDateFormatter alloc] init];
            [dayFormatter setDateFormat:@"yyyy-MM-dd"];
            
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        }
    }
    
    return [dateFormatter dateFromString:[NSString stringWithFormat:@"%@ %@", [dayFormatter stringFromDate:date], timeString]];
}


+ (NSString *)stringFromDate1:(NSDate *)date {
    static NSDateFormatter *formatter = nil;
    
    if (!formatter) {
        @synchronized(self) {
            formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"M月d日 HH:mm"];
        }
    }
    
    return [formatter stringFromDate:date];
}


+ (NSString *)stringFromDate2:(NSDate *)date {
    static NSDateFormatter *formatter = nil;
    
    if (!formatter) {
        @synchronized(self) {
            formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
        }
    }
    
    return [formatter stringFromDate:date];
}


+ (NSString *)stringFromDate3:(NSDate *)date {
    static NSDateFormatter *formatter = nil;
    
    if (!formatter) {
        @synchronized(self) {
            formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyyMMdd"];
        }
    }
    
    return [formatter stringFromDate:date];
}


+ (NSString *)stringFromDate4:(NSDate *)date {
    static NSDateFormatter *formatter = nil;
    
    if (!formatter) {
        @synchronized(self) {
            formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        }
    }
    
    return [formatter stringFromDate:date];
}


+ (NSString *)stringFromDate5:(NSDate *)date {
    static NSDateFormatter *formatter = nil;
    
    if (!formatter) {
        @synchronized(self) {
            formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy年MM月dd日"];
        }
    }
    
    return [formatter stringFromDate:date];
}


+ (NSString *)dateStringFromDate5:(NSDate *)date {
    static NSDateFormatter *formatter = nil;
    
    if (!formatter) {
        @synchronized(self) {
            formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"M'.'d"];
        }
    }
    
    return [formatter stringFromDate:date];
}


+ (NSString *)dateStringFromDate:(NSDate *)date {
    static NSDateFormatter *formatter = nil;
    
    if (!formatter) {
        @synchronized(self) {
            formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"M月d日"];
        }
    }
    
    return [formatter stringFromDate:date];
}


+ (NSString *)timeStringFromDate:(NSDate *)date {
    static NSDateFormatter *formatter = nil;
    
    if (!formatter) {
        @synchronized(self) {
            formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"HH:mm"];
        }
    }
    
    return [formatter stringFromDate:date];
}


+ (NSString *)weekdayFromDate:(NSDate *)date {
    static NSDateFormatter *formatter = nil;
    
    if (!formatter) {
        @synchronized(self) {
            formatter = [[NSDateFormatter alloc] init];
            formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh"];
            [formatter setDateFormat:@"EEEE"];
        }
    }
    
    return [[formatter stringFromDate:date] stringByReplacingOccurrencesOfString:@"星期" withString:@"周"];
}


+ (NSString *)weekdayFromDate1:(NSDate *)date {
    static NSDateFormatter *formatter = nil;
    
    if (!formatter) {
        @synchronized(self) {
            formatter = [[NSDateFormatter alloc] init];
            formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh"];
            [formatter setDateFormat:@"M月d日 EEEE"];
        }
    }
    
    return [[formatter stringFromDate:date] stringByReplacingOccurrencesOfString:@"星期" withString:@"周"];
}


+ (NSString *)weekdayFromDate2:(NSDate *)date {
    static NSDateFormatter *formatter = nil;
    
    if (!formatter) {
        @synchronized(self) {
            formatter = [[NSDateFormatter alloc] init];
            formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh"];
            [formatter setDateFormat:@"M月d日 EEEE"];
        }
    }
    
    return [formatter stringFromDate:date];
}


+ (NSString *)longStringFromDate:(NSDate *)date {
    static NSDateFormatter *formatter = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    });
    
    return [formatter stringFromDate:date];
}



@end
