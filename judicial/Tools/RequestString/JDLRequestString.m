//
//  JDLRequestString.m
//  judicial
//
//  Created by zjsos on 16/6/16.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import "JDLRequestString.h"
#import "JDLLawyerController.h"
#import "JDLRecipient.h"
#import "NSString+JDLFrame.h"
#import "config.h"
@implementation JDLRequestString


+(NSString *)createStatisticsLogin:(NSDictionary *)userInfo andOperAtion:(NSString *)operAtion{
    NSMutableString *requestStr=[NSMutableString new];
    [requestStr appendString:CONFIG_STATISTICSSERVICEURL];
    [requestStr appendFormat:@"InserStatistics?LoginName=%@",userInfo[@"loginname"]];
    [requestStr appendFormat:@"&RealName=%@",userInfo[@"username"]];
    [requestStr appendFormat:@"&LoginIMEI=%@",userInfo[@"userid"]];
    [requestStr appendFormat:@"&applicationid=%@",@"sf"];
    [requestStr appendFormat:@"&OperAtion=%@",operAtion];
    NSLog(@"requestStr=%@",requestStr);
    return [requestStr copy];
}


+(NSString *)createGetCaseLawyerJson:(NSString *)intCaseIndex andIntLawyerIndex:(NSString *)intLawyerIndex{
    NSMutableString *requestStr=[NSMutableString new];
    [requestStr appendString:CONFIG_SERVICEURL];
    [requestStr appendFormat:@"GetCaseLawyerJson?&intCaseIndex=%@&intLawyerIndex=%@",[self nilToString:intCaseIndex andEmptyStringTo0:YES],[self nilToString:intLawyerIndex andEmptyStringTo0:YES]];
    return [requestStr copy];
}

+(NSString *)createGetCaseBaseInfoJson:(NSString *)intCaseIndex{
    NSMutableString *requestStr=[NSMutableString new];
    [requestStr appendString:CONFIG_SERVICEURL];
    [requestStr appendFormat:@"GetCaseBaseInfo?&intCaesIndex=%@",[self nilToString:intCaseIndex andEmptyStringTo0:YES]];
    
    return [requestStr copy];
}

+(NSString *)createSetLegaCaseApplyPerson:(NSDictionary *)dict{
    NSMutableString *requestStr=[NSMutableString new];
    [requestStr appendString:CONFIG_SERVICEURL];
    [requestStr appendFormat:@"SetLegaCaseApplyPerson?intBranchIndex=%ld",(long)[[JDLLawyerController sharedSupport] getLawyerNameToBranchId:dict[@"center"]]];
    [requestStr appendFormat:@"&strPersonName=%@",dict[@"name"]];
    [requestStr appendFormat:@"&strIdNo=%@",dict[@"card"]];
    [requestStr appendFormat:@"&strLinkTel=%@",dict[@"phone"]];
    [requestStr appendFormat:@"&strAdress=%@",dict[@"address"]];
    [requestStr appendFormat:@"&intSex=%@",[dict[@"address"] isEqualToString:@"女"]?@"2":@"1"];
    return [requestStr copy];
}

+(NSString *)createSetLegaCaseApplyInfo:(NSDictionary *)dict{
    NSMutableString *requestStr=[NSMutableString new];
    [requestStr appendString:CONFIG_SERVICEURL];
    [requestStr appendFormat:@"SetLegaCaseApplyInfo?&intBranchIndex=%@",dict[@"intBranchIndex"]];
    [requestStr appendFormat:@"&intCaseIndex=%@",dict[@"intCaseIndex"]];
    [requestStr appendFormat:@"&strCaseReason=%@",dict[@"strCaseReason"]];
    [requestStr appendFormat:@"&strCaseTruth=%@",dict[@"strCaseTruth"]];
    return [requestStr copy];
}

+(NSString *)createGetLawyerInfoJson:(NSDictionary *)dict{
    NSMutableString *requestStr=[NSMutableString new];
    [requestStr appendString:CONFIG_SERVICEURL];
    [requestStr appendFormat:@"GetLawyerInfoJson?intBranchIndex=%@",[self nilToString:dict[@"intBranchIndex"] andEmptyStringTo0:YES]];
    [requestStr appendFormat:@"&intLawyerIndex=%@",[self nilToString:dict[@"intLawyerIndex"] andEmptyStringTo0:YES]];
    [requestStr appendFormat:@"&strName=%@",[self nilToString:dict[@"strName"] andEmptyStringTo0:NO]];
    [requestStr appendFormat:@"&intCertifiedKind=%@",[self nilToString:dict[@"intCertifiedKind"] andEmptyStringTo0:YES]];
    [requestStr appendFormat:@"&strUnit=%@",[self nilToString:dict[@"intCertifiedKind"] andEmptyStringTo0:NO]];
    [requestStr appendFormat:@"&strSpecialty=%@",[self nilToString:dict[@"intCertifiedKind"] andEmptyStringTo0:NO]];
    return [requestStr copy];
}


+(NSString *)createGetApplyJson:(NSString *)strIdNo andIntCaseIndex:(NSString *)intCaseIndex{
    NSMutableString *requestStr=[NSMutableString new];
    [requestStr appendString:CONFIG_SERVICEURL];
    [requestStr appendFormat:@"GetApplyJson?strIdNo=%@&intCaseIndex=%@",strIdNo,[self nilToString:intCaseIndex andEmptyStringTo0:YES]];
    
    return [requestStr copy];
}


+(NSString *)nilToString:(NSString *)str andEmptyStringTo0:(BOOL)start{
    NSString *newStr=@"";
    if (str!=nil) {
        newStr=str;
    }
    if ([newStr isEqualToString:@""] && start ) {
        newStr=@"0";
    }
    return newStr;
}

@end
