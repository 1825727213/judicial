//
//  JDLRequestString.h
//  judicial
//
//  Created by zjsos on 16/6/16.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDLRequestString : NSObject

+(NSString *)createStatisticsLogin:(NSDictionary *)userInfo andOperAtion:(NSString *)operAtion;

+(NSString *)createSetLegaCaseApplyPerson:(NSDictionary *)dict;
+(NSString *)createSetLegaCaseApplyInfo:(NSDictionary *)dict;
+(NSString *)createGetLawyerInfoJson:(NSDictionary *)dict;
+(NSString *)createGetApplyJson:(NSString *)strIdNo andIntCaseIndex:(NSString *)intCaseIndex;

+(NSString *)createGetCaseBaseInfoJson:(NSString *)intCaseIndex;
+(NSString *)createGetCaseLawyerJson:(NSString *)intCaseIndex andIntLawyerIndex:(NSString *)intLawyerIndex;
+(NSString *)nilToString:(NSString *)str andEmptyStringTo0:(BOOL)start;
@end
