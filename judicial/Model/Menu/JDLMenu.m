//
//  JDLMenu.m
//  MenuDemo
//
//  Created by zjsos on 16/7/14.
//  Copyright © 2016年 Lying. All rights reserved.
//

#import "JDLMenu.h"

@implementation JDLMenu

-(instancetype)initWithImageName:(NSString *)imageName andTitle:(NSString *)title{
    self=[super init];
    if (self) {
        self.imageName=imageName;
        self.title=title;
    }
    return self;
}

+(instancetype)initWithImageName:(NSString *)imageName andTitle:(NSString *)title{
    return [[self alloc] initWithImageName:imageName andTitle:title];
}

+(NSArray *)defaultMenu{
    NSMutableArray *arr=[NSMutableArray new];
    
    [arr addObject:[self initWithImageName:@"person-icon1" andTitle:@"我的案件"]];
    [arr addObject:[self initWithImageName:@"person-icon9" andTitle:@"个人信息"]];
    
    return  [arr copy];
}



@end
