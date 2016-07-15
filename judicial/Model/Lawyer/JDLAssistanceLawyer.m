//
//  JDLAssistanceLawyer.m
//  judicial
//
//  Created by zjsos on 16/6/28.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import "JDLAssistanceLawyer.h"

@interface JDLAssistanceLawyer ()

@property (nonatomic,strong)NSMutableArray *showArrays;

@end

@implementation JDLAssistanceLawyer

-(instancetype)initWithDict:(NSDictionary *)dict{
    self=[self init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}


+(instancetype)initWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}



//@property (nonatomic,strong)NSString *branch_index;
//@property (nonatomic,strong)NSString *lawyer_index;
//@property (nonatomic,strong)NSString *operator_index;
//@property (nonatomic,strong)NSString *operator_name;
//@property (nonatomic,strong)NSString *mobile;
//@property (nonatomic,strong)NSString *depa_name;
//@property (nonatomic,strong)NSString *depa_index;
//@property (nonatomic,strong)NSString *sex;
//@property (nonatomic,strong)NSString *birth_year;
//@property (nonatomic,strong)NSString *lawyer_id;
//@property (nonatomic,strong)NSString *certified_kind;
//@property (nonatomic,strong)NSString *certified_date;
//@property (nonatomic,strong)NSString *director_branch;
//@property (nonatomic,strong)NSString *specialty;
//@property (nonatomic,strong)NSString *status;
//@property (nonatomic,strong)NSString *reserve;
//@property (nonatomic,strong)NSString *certified_kind_name;
//@property (nonatomic,strong)NSString *branch_name;
//@property (nonatomic,strong)NSString *star;
//@property (nonatomic,strong)NSString *case_count;
//@property (nonatomic,strong)NSString *average;
//@property (nonatomic,strong)NSString *status1;

-(NSArray *)showArray{
    
    [self addElement:@"律师名称" andShowValue:self.operator_name andId:@"operator_name"];
    [self addElement:@"联系电话" andShowValue:self.mobile andId:@"mobile"];
    [self addElement:@"性别" andShowValue:self.sex andId:@"sex"];
    [self addElement:@"所属单位" andShowValue:self.depa_name andId:@"depa_name"];
    [self addElement:@"出生年月" andShowValue:self.birth_year andId:@"birth_year"];
    [self addElement:@"擅长案件" andShowValue:self.specialty andId:@"specialty"];
    [self addElement:@"执业类别" andShowValue:self.certified_kind_name andId:@"certified_kind_name"];
    [self addElement:@"执业证号" andShowValue:self.lawyer_id andId:@"lawyer_id"];
    [self addElement:@"首次获得执业证书日期" andShowValue:self.certified_date andId:@"certified_date"];
    [self addElement:@"地区" andShowValue:self.branch_name andId:@"branch_name"];
    //[self addElement:@"星级" andShowValue:self.average andId:@"average"];
    [self addElement:@"案件评估次数" andShowValue:self.case_count andId:@"case_count"];
    [self addElement:@"案件平均分" andShowValue:self.average andId:@"average"];
    

    return [self.showArrays copy];
}

-(void)addElement:(NSString *)showName andShowValue:(NSString *)showValue andId:(NSString *)strId{
    NSMutableDictionary *newDict=[NSMutableDictionary new];
    [newDict setObject:showName forKey:@"showName"];
    [newDict setObject:showValue forKey:@"showValue"];
    [newDict setObject:strId forKey:@"id"];
    [self.showArrays addObject:newDict];
}

-(NSMutableArray *)showArrays{
    if (!_showArrays) {
        _showArrays=[NSMutableArray new];
    }
    return _showArrays;
}

@end
