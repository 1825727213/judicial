//
//  JDLTools.m
//  judicial
//
//  Created by zjsos on 16/6/12.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import "JDLTools.h"
#import "JDLRecipient.h"
#import "config.h"
#import "JDLField.h"
#import <CommonCrypto/CommonDigest.h>
@implementation JDLTools


+ (NSString *) macaddress
{
    NSString *defaultUUID= [[NSUserDefaults standardUserDefaults] objectForKey:@"uuid"];
    if (!defaultUUID) {
        NSMutableString *uuid=[NSMutableString new ];
        for (int i=0; i<32; i++) {
            [uuid appendFormat:@"%d",arc4random() %10];
        }
        defaultUUID=[uuid copy];
        [[NSUserDefaults standardUserDefaults] setObject:defaultUUID forKey:@"uuid"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    return defaultUUID;
}


+(NSArray *)removeIndex0Item:(NSMutableArray *)arr{
    NSMutableArray *newArr=[arr mutableCopy];
    [newArr removeObjectAtIndex:0];
    return [newArr copy];
}

//单个文件的大小
+ (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}
//遍历文件夹获得文件夹大小，返回多少M
+(float ) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}

/**
 *  自定义查询(多)
 *
 *  @param arr   查询的数组
 *  @param where 查询的内容
 *
 *  @return 查询到下标
 */
-(NSArray *)selectObjWithArray:(NSArray *)arr andWhere:(NSDictionary *)where
{
    NSMutableArray *arrNew=[NSMutableArray new];
    for (NSString *key in where) {
        NSInteger index=[self selectObjWithArray:arr andKey:key andValue:where[key]];
        if (index!= -1) {
            [arrNew addObject:[NSNumber numberWithInteger:index]];
        }
    }
    
    return [arrNew copy];
    
}
/**
 *  自定义查询(单)
 *
 *  @param arr   查询的数组
 *  @param key   查询的标题
 *  @param value 查询的值
 *
 *  @return <#return value description#>
 */
-(NSInteger)selectObjWithArray:(NSArray *)arr andKey:(NSString *)key andValue:(NSString *)value{
    
    for (int i=0; i<arr.count; i++) {
        id obj=arr[i];
        SEL getValue=NSSelectorFromString(key);
        if ([obj respondsToSelector:getValue] ) {
            NSString *str=@"";
            SuppressPerformSelectorLeakWarning(str=[obj performSelector:getValue]);
            if ([str isEqualToString:value]) {
                return i;
            }
        }
    }
    return -1;
}

+(NSInteger)selectObjWithArray:(NSArray *)arr andKey:(NSString *)key andValue:(NSString *)value{
    return [[self alloc] selectObjWithArray:arr andKey:key andValue:value];
}

+(NSArray *)selectObjWithArray:(NSArray *)arr andWhere:(NSDictionary *)where{
    return [[self alloc] selectObjWithArray:arr andWhere:where];
}

/**
 *  类对象赋值
 *
 *  @param dict 需要赋值的属性和值
 *
 *  @return <#return value description#>
 */
+(int)updateReciptentAttributes:(id)obj :(NSDictionary *)dict{
    int i=0;

    for (NSString *key in dict) {
        NSString *selStr=[NSString stringWithFormat:@"set%@:",[key capitalizedString]];
        SEL setValue=NSSelectorFromString(selStr);
        if ([obj respondsToSelector:setValue]) {
           SuppressPerformSelectorLeakWarning([obj performSelector:setValue withObject:dict[key]]);
            i++;
        }
    }
    return i;
}


+(BOOL)isRespondsToSelector:(id)obj SelName:(NSString *)selName{
    SEL setValue=NSSelectorFromString(selName);
    return [obj respondsToSelector:setValue];
}
/**
 *  调用某类的方法
 *
 *  @param obj     类
 *  @param selName 方法名称
 *  @param object  参数
 */
+(void)setValue:(id)obj SelName:(NSString *)selName withObject:(id)object{
    if ([self isRespondsToSelector:obj SelName:selName]) {
        SuppressPerformSelectorLeakWarning([obj performSelector:NSSelectorFromString(selName) withObject:object]);
    }
}
/**
 *  调用某类的方法
 *
 *  @param obj     类
 *  @param selName 方法名称
 *  @param object  参数
 *
 *  @return 
 */
+(NSString *)getValue:(id)obj SelName:(NSString *)selName withObject:(id)object{
    NSString *str=@"";
    if ([self isRespondsToSelector:obj SelName:selName]) {
        SuppressPerformSelectorLeakWarning(str=[obj performSelector:NSSelectorFromString(selName) withObject:object]);
        if (str==nil) {
            str=@"";
        }
        return str;
    }
    return @"";
}

+(NSArray *)repeatFieldIdentifierArrayContent:(NSArray *)arr{
    NSMutableArray *arrnew=[NSMutableArray new];
    for (JDLField *field in arr) {
        if (field.identifier!=nil && ![field.identifier isEqualToString:@""]) {
            [arrnew addObject:field.identifier];
        }
    }
    NSSet *set = [NSSet setWithArray:arrnew];
    
    return [set allObjects];
}


@end
