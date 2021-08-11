//
//  NSDateFormatter+Utils.m
//  OC_Utils
//
//  Created by WWQ on 2021/8/11.
//

#import "NSDateFormatter+Utils.h"


static const NSInteger minute = 60;
static const NSInteger hour = minute * 60;
//static const NSInteger day = hour * 24;


@implementation NSDateFormatter (Utils)


+ (NSDateFormatter *)apiDefaultDF {
    return [self dateFormatter:@"yyyy-MM-dd HH:mm:ss"];
}


+ (NSDateFormatter *)liveJsonLogDF {
    return [self dateFormatter:@"yyyy-MM-dd HH:mm:ss.SSS"];
}


+ (NSDateFormatter *)liveMonitorDF {
    return [self dateFormatter:@"yyyyMMddHHmmss"];
}


+ (NSDateFormatter *)apiSimpleDF {
    return [self dateFormatter:@"yyyy-MM-dd"];
}


+ (NSDateFormatter *)publishWholeDF {
    return [self dateFormatter:@"yyyy.MM.dd"];
}


+ (NSDateFormatter *)publishDF {
    return [self dateFormatter:@"MM月dd日 HH:mm"];
}


+ (NSDateFormatter *)commentDF {
    return [self dateFormatter:@"MM-dd HH:mm"];
}


+ (NSDateFormatter *)simpleDF {
    return [self dateFormatter:@"yyyyMMdd"];
}


+ (NSDateFormatter *)todayLiveDF {
    return [self dateFormatter:@"今天 HH:mm"];
}


+ (NSDateFormatter *)tomorrowLiveDF {
    return [self dateFormatter:@"明天 HH:mm"];
}


+ (NSDateFormatter *)timeDF {
    return [self dateFormatter:@"HH:mm"];
}


+ (NSDateFormatter *)dateFormatter:(NSString *)dateFormat {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = dateFormat;
    formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:hour * 8];
    return formatter;
}


+ (NSString *)shortFormatPlayDurationTimeWithDuration:(NSTimeInterval)d {
    NSInteger duration = (NSInteger)d;
    NSInteger seconds = duration % 60;
    NSInteger minutes = duration / 60;
    if (minutes < 60) {
        return [NSString stringWithFormat:@"%02ld:%02ld", minutes, seconds];
    } else {
        NSInteger hours = minutes / 60;
        minutes %= 60;
        return [NSString stringWithFormat:@"%02ld:%02ld:%02ld", hours, minutes, seconds];
    }
}


+ (NSString *)stringFromDate:(NSDate *)date {
    NSDate *nowDate = [NSDate date];
    NSTimeInterval timeInterval = [nowDate timeIntervalSinceDate:date];
    if (timeInterval < 60) {
        return @"刚刚";
    } else if (timeInterval == 60) {
        return @"1分钟前";
    } else if (timeInterval > 60 && timeInterval < 3600) {
        return [NSString stringWithFormat:@"%ld分钟前",(NSInteger)timeInterval / 60];
    } else if (timeInterval == 3600) {
        return @"1小时前";
    } else if (timeInterval > 3600 && timeInterval < 86400) {
        return [NSString stringWithFormat:@"%ld小时前",(NSInteger)timeInterval / 3600];
    } else if (timeInterval == 86400) {
        return @"1天前";
    }
    NSString *dateString = [NSDateFormatter.commentDF stringFromDate:date];
    return dateString;
}


+ (NSString *)liveDateStringFrom:(NSDate *)date {
    NSDate *nowDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    if (timeZone == nil) {
        return [NSDateFormatter.publishDF stringFromDate:date];
    }
    calendar.timeZone = timeZone;
    NSLocale *locale = [NSLocale localeWithLocaleIdentifier:@"zh-CN"];
    calendar.locale = locale;
    
    NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
    dateformat.dateFormat = @"yyyyMMdd";
    dateformat.calendar = calendar;
    dateformat.locale = calendar.locale;
    
    NSDate *raceDate = [dateformat dateFromString:[dateformat stringFromDate:date]];
    NSDate *todayDate = [dateformat dateFromString:[dateformat stringFromDate:nowDate]];
    if (raceDate == nil || todayDate == nil ) {
        return [self.publishDF stringFromDate:date];
    }
    NSDateComponents *components = [calendar components:NSCalendarUnitDay fromDate:raceDate toDate:todayDate options:0];
    NSInteger days = components.day;
    if (days == 0) {
        return [self.todayLiveDF stringFromDate:date];
    } else if (days == -1) {
        return [self.tomorrowLiveDF stringFromDate:date];
    } else {
        return [self.publishDF stringFromDate:date];
    }
}

@end
