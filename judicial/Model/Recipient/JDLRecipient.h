//
//  JDLRecipient.h
//  judicial
//
//  Created by zjsos on 16/6/5.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDLRecipient : NSObject

@property (nonatomic,strong)NSString *caseid;

@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *phone;
@property (nonatomic,strong)NSString *card;
@property (nonatomic,strong)NSString *region;
@property (nonatomic,strong)NSString *address;
@property (nonatomic,strong)NSString *sex;
@property (nonatomic,strong)NSString *center;

@property (nonatomic,assign)int *sort;



+(instancetype)createWithDict:(NSDictionary *)dict;
+(instancetype)createWithJson:(NSString *)json;
-(int)updateReciptentAttributes:(NSDictionary *)dict;
-(NSString *)toJsonObject;
@end
