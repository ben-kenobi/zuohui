//
//  NSDate+Ex.h
//Created by apple on 17/07/21.
//

#import <Foundation/Foundation.h>

@interface NSDate (Ex)
@property (nonatomic,assign)BOOL viewed;
-(NSString *)dateFormat;
-(NSString *)dateFormat2;
-(NSString *)dateFormat3;
-(NSString *)timeFormat;
-(NSString *)timeFormat2;
-(NSString *)timeFormat3;
-(NSString *)timeFormat4;
-(NSString *)timeMilliFormat;
+(instancetype)dateFromStr:(NSString *)str;
+(instancetype)timeFromStr:(NSString *)str;
+(instancetype)timeMilliFromStr:(NSString *)str;
+(NSInteger)curTimeMilli;
+(NSDate *)dateWithMilli:(NSInteger)millis;

+(instancetype)fromCommonDateFormat:(NSString*)datestr;
-(NSString *)toCommonDateFormat;

-(NSString *)postDateString ;

-(BOOL)isThisYear;
-(BOOL)isToday;
-(BOOL)isWeekend;
-(BOOL)isTomorrow;
-(BOOL)isYesterday;
-(BOOL)isSameDay:(NSDate *)date;
-(BOOL)isSameWeek:(NSDate *)date;
-(BOOL)isSameMonth:(NSDate *)date;
-(BOOL)isSameYear:(NSDate *)date;
-(BOOL)isSameHour:(NSDate *)date;
-(BOOL)isSameMinute:(NSDate *)date;


@end
