//
//  JDLRecipientControl.h
//  judicial
//
//  Created by zjsos on 16/6/5.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JDLRecipient;
    
@interface JDLRecipientControl : NSObject
///添加受援人信息
+(BOOL)addRecipient:(NSDictionary *)dict;
///修改受援人信息
+(void)updateRecipient:(NSString *)card newRecipient:(NSDictionary *)newRecipient;
///查找受援人
+(NSInteger)selectRecipient:(NSString *)card;
+(JDLRecipient *)selectRecipientName:(NSString *)name;
///删除受援人
+(void)deleteRecipient:(JDLRecipient *)recipient;
///获取全部受援人
+(NSMutableArray *)recipients;



@end
