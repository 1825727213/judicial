//
//  JDLLawyerController.h
//  judicial
//
//  Created by zjsos on 16/6/12.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDLLawyerController : NSObject

-(NSInteger)getPaperToBranchId:(NSString *)paper;
-(NSString *)getPaperToLawyerName:(NSString *)paper;

-(NSInteger)getLawyerNameToBranchId:(NSString *)LawyerName;

+(instancetype)sharedSupport;
+(NSMutableArray *)Lawyers;
@end
