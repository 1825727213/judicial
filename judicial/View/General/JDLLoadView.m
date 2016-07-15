//
//  JDLLoadView.m
//  judicial
//
//  Created by zjsos on 16/6/29.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import "JDLLoadView.h"

@implementation JDLLoadView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
        UIImageView *imageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"akert"]];
        
        [self addSubview:imageView];
    }
    return self;
}

@end
