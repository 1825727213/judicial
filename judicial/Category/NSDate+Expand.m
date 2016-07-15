//
//  NSDate+Expand.m
//  Lovesickness
//
//  Created by w gq on 15/8/13.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import "NSDate+Expand.h"

@implementation NSDate (Expand)

+(NSDateComponents *)ComponentsCurrentData
{
    return [NSDate componentsDate:[NSDate date]];
}

+(NSDateComponents *)componentsDate:(NSDate *)date
{
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:@"gregorian"];
    //NSLog(@"%@",NSGregorianCalendar);
    NSDateComponents *comps = [gregorian components:kCFCalendarUnitYear | kCFCalendarUnitMonth |  kCFCalendarUnitDay fromDate:date];
    return comps;
}

+(NSDate *)XSLStringToDate:(NSString *)date  Format:(NSString *)format
{
    NSDateFormatter *ff = [[NSDateFormatter alloc]init];
    ff.dateFormat = format;
    //把字符串转换成日期对象
    return  [ff dateFromString:date];
}


+(NSString *)XSLdateToString:(NSDate *)date Format:(NSString *)format{
    NSDateFormatter *fm = [[NSDateFormatter alloc]init];
    fm.dateFormat = format;
    NSString *str=[fm stringFromDate:date];
    return str;
}

+(NSString *)XSLCurrentDate1
{
    return  [NSDate XSLdateToString:[NSDate date] Format:@"yyyyMMddHHmmss"];
}

+(NSString *)XSLCurrentDate
{
    
    return  [NSDate XSLdateToString:[NSDate date] Format:@"yyyy-MM-dd"];
}

+(NSString *)XSLCurrentTime
{
    return  [NSDate XSLdateToString:[NSDate date] Format:@"HHmmss"];
}
-(BOOL)compareData:(NSDate *)tomorrow{
    NSDate *earlier_date = [self earlierDate:tomorrow];
    return  [self isEqualToDate:earlier_date];
    
}
@end
