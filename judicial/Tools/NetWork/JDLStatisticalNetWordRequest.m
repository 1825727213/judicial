//
//  JDLStatisticalNetWordRequest.m
//  judicial
//
//  Created by zjsos on 16/7/15.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import "JDLStatisticalNetWordRequest.h"
#import "ASIFormDataRequest.h"
#import "JDLRequestString.h"
#import "JDLTools.h"
#define STATISTICALURL  @"http://www.zjsos.net:8888/Statisticslog.asmx/InserStatistics"

@implementation JDLStatisticalNetWordRequest

+(void)submitUserinfo:(NSDictionary *)userInfo andOperAtion:(NSString *)operAtion{
    
    ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:STATISTICALURL]];
    
    NSString *loginname=[JDLRequestString nilToString:userInfo[@"loginname"] andEmptyStringTo0:NO];
    NSString *username=[JDLRequestString nilToString:userInfo[@"username"] andEmptyStringTo0:NO];
    NSString *userid=[JDLTools macaddress];
    
    [request addPostValue:loginname forKey:@"LoginName"];
    [request addPostValue:username forKey:@"RealName"];
    [request addPostValue:userid forKey:@"LoginIMEI"];
    [request addPostValue:@"sf" forKey:@"applicationid"];
    [request addPostValue:operAtion forKey:@"operAtion"];
    [request startAsynchronous];
    
}

@end
