//
//  JDLConversion.h
//  judicial
//
//  Created by zjsos on 16/6/5.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDLConversion : NSObject


/**
 *  身份证加密 3303***************7156
 *
 *  @param card 身份证
 *
 *  @return 加密后的身份证
 */
+(NSString *)encryptCard:(NSString *)card;

/**
 *  json的字符串转数组或者字典
 *
 *  @param json json字符串
 *
 *  @return 数组或者字典 ，空的话 返回nil
 */
+(id)jsonToid:(NSString *)json;

/**
 *  把数组转化成字符串，中间用逗号隔开（只针对字符串数组）
 *
 *  @param arr 字符串数组
 *
 *  @return v1,v2,v3
 */
+(NSString *)arrToString:(NSArray *)arr;
/**
 *  对象转json
 *
 *  @param obj        对象
 *  @param attributes 需要转化的对象属性 如：@[@"属性1",@"属性2"]；
 *
 *  @return json字符串
 */
+(NSString *)objtoJson:(id)obj Attributes:(NSArray *)attributes;

/**
 *  获取司法返回的数据接口（司法专用）
 *
 *  @param xml webserice返回信息
 *
 *  @return 解析后的信息
 */
+(NSString *)SetLegaCaseApplyPersonParse:(id)xml;

/**
 *  分数转成星级
 *
 *  @param star 分数
 *
 *  @return 星数
 */
+(NSInteger)scoreToStar:(NSInteger)star;

@end
