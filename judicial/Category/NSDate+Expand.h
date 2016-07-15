//
//  NSDate+Expand.h
//  Lovesickness
//
//  Created by w gq on 15/8/13.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Expand)
+(NSDateComponents *)componentsDate:(NSDate *)date;
+(NSDateComponents *)ComponentsCurrentData;
+(NSString *)XSLCurrentDate;
+(NSString *)XSLCurrentDate1;
+(NSString *)XSLCurrentTime;
+(NSString *)XSLdateToString:(NSDate *)date Format:(NSString *)format;
+(NSDate *)XSLStringToDate:(NSString *)date  Format:(NSString *)format;

-(BOOL)compareData:(NSDate *)tomorrow;


@end
