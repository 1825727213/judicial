//
//  JDLCase.m
//  judicial
//
//  Created by zjsos on 16/6/12.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import "JDLCase.h"
#import "JDLField.h"
#import "JDLTextTableViewCell.h"
#import "JDLConversion.h"
@interface JDLCase ()

@end

@implementation JDLCase

-(NSMutableArray *)histortCaseContent{
    
    NSMutableArray *newArr=[NSMutableArray new];
    [newArr addObject:[JDLField initWithHistortCaseFieldNmae:@"案件标题" fieldType:0 fieldContent:self.case_reason]];
    [newArr addObject:[JDLField initWithHistortCaseFieldNmae:@"案件性质" fieldType:0 fieldContent:self.case_kind]];
    [newArr addObject:[JDLField initWithHistortCaseFieldNmae:@"处理进度" fieldType:0 fieldContent:self.apply_status_name]];
    
    if ([self.apply_status isEqualToString:@"5"]) {
        [newArr addObject:[JDLField initWithHistortCaseFieldNmae:@"审批答复" fieldType:0 fieldContent:@"您的申请为非正常申请，系统已经删除"]];
    }
    else{
        [newArr addObject:[JDLField initWithHistortCaseFieldNmae:@"审批答复" fieldType:0 fieldContent:self.audit_reply]];
    }
    
    [newArr addObject:[JDLField initWithHistortCaseFieldNmae:@"申请人" fieldType:0 fieldContent:self.person_name]];
    [newArr addObject:[JDLField initWithHistortCaseFieldNmae:@"性别" fieldType:0 fieldContent:self.sex]];
    [newArr addObject:[JDLField initWithHistortCaseFieldNmae:@"联系电话" fieldType:0 fieldContent:self.link_tel]];
    [newArr addObject:[JDLField initWithHistortCaseFieldNmae:@"身份证号码" fieldType:0 fieldContent:[JDLConversion encryptCard:self.id_no]]];
    [newArr addObject:[JDLField initWithHistortCaseFieldNmae:@"案情概述" fieldType:0 fieldContent:self.case_truth]];
    return newArr ;

}






+(id)initWidthDict:(NSDictionary *)dict{
    JDLCase *caseOne=[[JDLCase alloc] init];
    [caseOne setValuesForKeysWithDictionary:dict];
    return  caseOne;
}

+(NSMutableArray *)defaultCase{
    NSMutableArray *cases= [NSMutableArray new];

    
    return cases;
}


@end
