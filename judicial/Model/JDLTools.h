//
//  JDLTools.h
//  judicial
//
//  Created by zjsos on 16/6/12.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDLTools : NSObject


+ (NSString *) macaddress;


+(NSArray *)selectObjWithArray:(NSArray *)arr andWhere:(NSDictionary *)where;
+(NSInteger)selectObjWithArray:(NSArray *)arr andKey:(NSString *)key andValue:(NSString *)value;

+(int)updateReciptentAttributes:(id)obj :(NSDictionary *)dict;
+(NSString *)getValue:(id)obj SelName:(NSString *)selName withObject:(id)object;
+(void)setValue:(id)obj SelName:(NSString *)selName withObject:(id)object;

+(BOOL)isRespondsToSelector:(id)obj SelName:(NSString *)selName;

+(NSArray *)repeatFieldIdentifierArrayContent:(NSArray *)arr;

+(NSArray *)removeIndex0Item:(NSMutableArray *)arr;

//遍历文件夹获得文件夹大小，返回多少M
+(float) folderSizeAtPath:(NSString*) folderPath;

//单个文件的大小
+ (long long) fileSizeAtPath:(NSString*) filePath;
@end
