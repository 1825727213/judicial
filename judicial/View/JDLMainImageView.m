//
//  JDLMainImageView.m
//  judicial
//
//  Created by zjsos on 16/6/8.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import "JDLMainImageView.h"

@implementation JDLMainImageView

-(instancetype)init
{
    self=[super init];
    if (self) {
        self.contentMode=UIViewContentModeScaleAspectFit;
        //self.userInteractionEnabled=YES;
        //self.contentMode=UIViewContentModeScaleAspectFill;
        //self.backgroundColor=[UIColor purpleColor];
    }
    return self;
}

@end
