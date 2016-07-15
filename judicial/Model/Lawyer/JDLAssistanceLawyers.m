//
//  JDLAssistanceLawyers.m
//  judicial
//
//  Created by zjsos on 16/6/28.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import "JDLAssistanceLawyers.h"
#import "JDLAssistanceLawyer.h"
@interface JDLAssistanceLawyers ()

@property (nonatomic,strong)NSMutableArray *assistancaLawyes;

@end

@implementation JDLAssistanceLawyers



-(instancetype)initWidthArray:(NSArray *)arr{
    self=[super init];
    if (self) {
        for (int i=0; i<arr.count; i++) {
            [self.assistancaLawyes addObject:[JDLAssistanceLawyer initWithDict:arr[i]]];
        }
        
        
//        for (int i=0; i<self.assistancaLawyes.count; i++) {
//            JDLAssistanceLawyer *lawyer=self.assistancaLawyes[i];
//            NSLog(@"operator_name=%@ average=%@ case_count=%@",lawyer.operator_name,lawyer.average,lawyer.case_count);
//        }
        [self sortLawyes];
//        NSLog(@"****************************************");
//        NSLog(@"****************************************");
//        NSLog(@"****************************************");
//        NSLog(@"***************分隔符********************");
//        NSLog(@"****************************************");
//        NSLog(@"****************************************");
//        NSLog(@"****************************************");
//        
//        for (int i=0; i<self.assistancaLawyes.count; i++) {
//            JDLAssistanceLawyer *lawyer=self.assistancaLawyes[i];
//            NSLog(@"operator_name=%@ average=%@ case_count=%@",lawyer.operator_name,lawyer.average,lawyer.case_count);
//        }
        
    }
    return self;
}


-(void)sortLawyes{
    for (int i=0; i<self.assistancaLawyes.count; i++) {
        for (int j=i; j<self.assistancaLawyes.count; j++) {
            JDLAssistanceLawyer *lawyerI=self.assistancaLawyes[i];
            JDLAssistanceLawyer *lawyerJ=self.assistancaLawyes[j];
            int averageI=[lawyerI.average intValue];
            int averageJ=[lawyerJ.average intValue];
            if (averageI<averageJ) {
                [self.assistancaLawyes replaceObjectAtIndex:i withObject:lawyerJ];
                [self.assistancaLawyes replaceObjectAtIndex:j withObject:lawyerI];
            }
            else if (averageI==averageJ)
            {
                int case_countI=[lawyerI.case_count intValue];
                int case_counJ=[lawyerJ.case_count intValue];
                if (case_countI<case_counJ) {
                    [self.assistancaLawyes replaceObjectAtIndex:i withObject:lawyerJ];
                    [self.assistancaLawyes replaceObjectAtIndex:j withObject:lawyerI];
                }
            }
        }
    }
}

-(NSMutableArray *)assistancaLawyes{
    if (!_assistancaLawyes) {
        _assistancaLawyes=[NSMutableArray new];
    }
    return _assistancaLawyes;
}

-(NSMutableArray *)getLawyers{
    return [self.assistancaLawyes mutableCopy];
}

@end
