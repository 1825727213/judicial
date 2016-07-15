
//
//  JDLdDictionary.m
//  judicial
//
//  Created by zjsos on 16/6/10.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import "JDLdDictionary.h"
#import "JDLLawyer.h"
@implementation JDLdDictionary

+(NSString *)returnField:(NSString *)key{
    NSMutableDictionary *dict=[NSMutableDictionary new];
    [dict setObject:@"地区" forKey:@"region"];
    [dict setObject:@"姓名" forKey:@"name"];
    [dict setObject:@"手机号" forKey:@"phone"];
    [dict setObject:@"身份证" forKey:@"card"];
    return  dict[key];
}

+(NSString *)returnBranch:(NSString *)key{
    NSMutableDictionary *dict=[NSMutableDictionary new];
    [dict setObject:@"330300" forKey:@"温州市法律援助中心"];
    [dict setObject:@"330302" forKey:@"温州市鹿城区法律援助中心"];
    [dict setObject:@"330303" forKey:@"温州市龙湾区法律援助中心"];
    [dict setObject:@"330304" forKey:@"温州市瓯海区法律援助中心"];
    return  dict[key];
}


@end
