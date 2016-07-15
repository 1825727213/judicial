//
//  JDLCase.h
//  judicial
//
//  Created by zjsos on 16/6/12.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDLCase : NSObject

@property (nonatomic,strong)NSString *branch_index;
@property (nonatomic,strong)NSString *case_index;
@property (nonatomic,strong)NSString *case_case_index;
@property (nonatomic,strong)NSString *case_kind;
@property (nonatomic,strong)NSString *case_reason_kind;
@property (nonatomic,strong)NSString *apply_date;
@property (nonatomic,strong)NSString *apply_time;
@property (nonatomic,strong)NSString *case_reason;
@property (nonatomic,strong)NSString *case_truth;
@property (nonatomic,strong)NSString *audit_oper;
@property (nonatomic,strong)NSString *audit_date;
@property (nonatomic,strong)NSString *audit_time;
@property (nonatomic,strong)NSString *audit_reply;
@property (nonatomic,strong)NSString *accept_oper;
@property (nonatomic,strong)NSString *accept_date;
@property (nonatomic,strong)NSString *accept_time;
@property (nonatomic,strong)NSString *status;
@property (nonatomic,strong)NSString *reserve;
@property (nonatomic,strong)NSString *apply_status_name;
@property (nonatomic,strong)NSString *person_name;
@property (nonatomic,strong)NSString *id_no;
@property (nonatomic,strong)NSString *link_tel;
@property (nonatomic,strong)NSString *address;
@property (nonatomic,strong)NSString *sex;
@property (nonatomic,strong)NSString *ethnic_group;
@property (nonatomic,strong)NSString *prove_status;
@property (nonatomic,strong)NSString *person_kind;
@property (nonatomic,strong)NSString *accept_oper_name;
@property (nonatomic,strong)NSString *apply_status;


+(id)initWidthDict:(NSDictionary *)dict;

-(NSMutableArray *)histortCaseContent;
+(NSMutableArray *)defaultCase;

@end
