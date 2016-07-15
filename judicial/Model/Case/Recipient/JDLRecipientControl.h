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

+(BOOL)addRecipient:(NSDictionary *)dict;

-(void)updateRecipient:(NSString *)card newRecipient:(NSDictionary *)newRecipient;

-(NSInteger)selectRecipient:(NSString *)card;

+(void)deleteRecipient:(JDLRecipient *)recipient;


+(NSMutableArray *)recipients;

@end
