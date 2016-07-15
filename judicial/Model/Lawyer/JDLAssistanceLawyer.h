//
//  JDLAssistanceLawyer.h
//  judicial
//
//  Created by zjsos on 16/6/28.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDLAssistanceLawyer : NSObject


@property (nonatomic,strong)NSString *branch_index;
@property (nonatomic,strong)NSString *lawyer_index;
@property (nonatomic,strong)NSString *operator_index;
@property (nonatomic,strong)NSString *operator_name;
@property (nonatomic,strong)NSString *mobile;
@property (nonatomic,strong)NSString *depa_name;
@property (nonatomic,strong)NSString *depa_index;
@property (nonatomic,strong)NSString *sex;
@property (nonatomic,strong)NSString *birth_year;
@property (nonatomic,strong)NSString *lawyer_id;
@property (nonatomic,strong)NSString *certified_kind;
@property (nonatomic,strong)NSString *certified_date;
@property (nonatomic,strong)NSString *director_branch;
@property (nonatomic,strong)NSString *specialty;
@property (nonatomic,strong)NSString *status;
@property (nonatomic,strong)NSString *reserve;
@property (nonatomic,strong)NSString *certified_kind_name;
@property (nonatomic,strong)NSString *branch_name;
@property (nonatomic,strong)NSString *star;
@property (nonatomic,strong)NSString *case_count;
@property (nonatomic,strong)NSString *average;
@property (nonatomic,strong)NSString *status1;

+(instancetype)initWithDict:(NSDictionary *)dict;

-(NSArray *)showArray;

@end
