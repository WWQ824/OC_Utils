//
//  NSDateFormatter+Utils.h
//  OC_Utils
//
//  Created by WWQ on 2021/8/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDateFormatter (Utils)


@property (nonatomic, strong, class, readonly) NSDateFormatter *apiDefaultDF;

@property (nonatomic, strong, class, readonly) NSDateFormatter *liveJsonLogDF;

@property (nonatomic, strong, class, readonly) NSDateFormatter *liveMonitorDF;

@property (nonatomic, strong, class, readonly) NSDateFormatter *apiSimpleDF;

@property (nonatomic, strong, class, readonly) NSDateFormatter *publishWholeDF;

@property (nonatomic, strong, class, readonly) NSDateFormatter *publishDF;

@property (nonatomic, strong, class, readonly) NSDateFormatter *commentDF;

@property (nonatomic, strong, class, readonly) NSDateFormatter *simpleDF;

@property (nonatomic, strong, class, readonly) NSDateFormatter *todayLiveDF;

@property (nonatomic, strong, class, readonly) NSDateFormatter *tomorrowLiveDF;

@property (nonatomic, strong, class, readonly) NSDateFormatter *timeDF;


+ (NSString *)shortFormatPlayDurationTimeWithDuration:(NSTimeInterval)duration;

+ (NSString *)stringFromDate:(NSDate *)date;

+ (NSString *)liveDateStringFrom:(NSDate *)date;


@end

NS_ASSUME_NONNULL_END
