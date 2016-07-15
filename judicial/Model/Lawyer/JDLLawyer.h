//
//  JDLLawyer.h
//  judicial
//
//  Created by zjsos on 16/6/12.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDLLawyer : NSObject

///分支编号
@property (nonatomic,assign)NSInteger branchId;
///事务所名称
@property (nonatomic,strong)NSString *name;
///事务所简述
@property (nonatomic,strong)NSString *paper;

+(NSMutableArray *)defaultLawyers;

@end
