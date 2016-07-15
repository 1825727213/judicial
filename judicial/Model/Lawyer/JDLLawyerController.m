//
//  JDLLawyerController.m
//  judicial
//
//  Created by zjsos on 16/6/12.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import "JDLLawyerController.h"
#import "JDLLawyer.h"
#import "JDLTools.h"
@interface JDLLawyerController ()

@property (nonatomic,strong)NSMutableArray *allLawyers;

@end

static JDLLawyerController  *sharedStore=nil;

@implementation JDLLawyerController

+(instancetype)sharedSupport
{
    //加锁使之线程安全
    @synchronized(self){
        if (!sharedStore) {
            sharedStore=[[self alloc] init];
        }
    }
    return sharedStore;
}

-(NSInteger)getLawyerNameToBranchId:(NSString *)LawyerName{
    NSInteger i= [JDLTools selectObjWithArray:self.allLawyers andKey:@"name" andValue:LawyerName];
    JDLLawyer *lawyer=self.allLawyers[i];
    return lawyer.branchId;
}

-(NSInteger)getPaperToBranchId:(NSString *)paper{
    NSInteger i= [JDLTools selectObjWithArray:self.allLawyers andKey:@"paper" andValue:paper];
    JDLLawyer *lawyer=self.allLawyers[i];
    return lawyer.branchId;
}

-(NSString *)getPaperToLawyerName:(NSString *)paper{
    NSInteger i= [JDLTools selectObjWithArray:self.allLawyers andKey:@"paper" andValue:paper];
    JDLLawyer *lawyer=self.allLawyers[i];
    return lawyer.name;
}


-(NSMutableArray *)allLawyers{
    if (!_allLawyers) {
        _allLawyers=[JDLLawyer defaultLawyers];
    }
    return _allLawyers;
}


+(NSMutableArray *)Lawyers{
    return  [[self sharedSupport] allLawyers];
}


@end
