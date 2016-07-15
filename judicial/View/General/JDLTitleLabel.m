//
//  JDLTitleLabel.m
//  judicial
//
//  Created by zjsos on 16/7/2.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import "JDLTitleLabel.h"

@implementation JDLTitleLabel

-(instancetype)init{
    self=[super init];
    if (self) {
        self.numberOfLines=0;
        self.textAlignment=NSTextAlignmentLeft;
        self.font=[UIFont systemFontOfSize:14];
    }
    return self;
}

@end
