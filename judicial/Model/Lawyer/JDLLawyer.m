//
//  JDLLawyer.m
//  judicial
//
//  Created by zjsos on 16/6/12.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import "JDLLawyer.h"

@implementation JDLLawyer


- (instancetype)initWithBranchId:(NSInteger)branchId LawyerName:(NSString *)lawyerName paper:(NSString *)paper
{
    self = [super init];
    if (self) {
        self.branchId=branchId;
        self.name=lawyerName;
        self.paper=paper;
    }
    return self;
}

+ (instancetype)initWithBranchId:(NSInteger)branchId LawyerName:(NSString *)lawyerName paper:(NSString *)paper
{
    return [[self alloc] initWithBranchId:branchId LawyerName:lawyerName paper:paper];
}

+(NSMutableArray *)defaultLawyers{
    NSMutableArray *arr=[NSMutableArray new];
    [arr addObject:[self initWithBranchId:330300 LawyerName:@"温州市法律援助中心" paper:@"市中心"]];
    [arr addObject:[self initWithBranchId:330302 LawyerName:@"温州市鹿城区法律援助中心" paper:@"鹿城区"]];
    [arr addObject:[self initWithBranchId:330303 LawyerName:@"温州市龙湾区法律援助中心" paper:@"龙湾区"]];
    [arr addObject:[self initWithBranchId:330304 LawyerName:@"温州市瓯海区法律援助中心" paper:@"瓯海区"]];
    [arr addObject:[self initWithBranchId:330322 LawyerName:@"温州市洞头区法律援助中心" paper:@"洞头区"]];
    [arr addObject:[self initWithBranchId:330382 LawyerName:@"乐清市法律援助中心" paper:@"乐清市"]];
    [arr addObject:[self initWithBranchId:330381 LawyerName:@"瑞安市法律援助中心" paper:@"瑞安市"]];
    [arr addObject:[self initWithBranchId:330324 LawyerName:@"永嘉县法律援助中心" paper:@"永嘉县"]];
    [arr addObject:[self initWithBranchId:330328 LawyerName:@"文成县法律援助中心" paper:@"文成县"]];
    [arr addObject:[self initWithBranchId:330326 LawyerName:@"平阳县法律援助中心" paper:@"平阳县"]];
    [arr addObject:[self initWithBranchId:330329 LawyerName:@"泰顺县法律援助中心" paper:@"泰顺县"]];
    [arr addObject:[self initWithBranchId:330327 LawyerName:@"苍南县法律援助中心" paper:@"苍南县"]];
    [arr addObject:[self initWithBranchId:330305 LawyerName:@"经济开发区法律援助中心" paper:@"经济开发区"]];
    return  arr;
}

@end
