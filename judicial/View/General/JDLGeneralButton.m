//
//  JDLGeneralButton.m
//  judicial
//
//  Created by zjsos on 16/6/27.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import "JDLGeneralButton.h"
#import "UIColor+Art.h"
@implementation JDLGeneralButton

+(instancetype)buttonWithType:(UIButtonType)buttonType{
    JDLGeneralButton *btn=[super buttonWithType:buttonType];
    btn.backgroundColor=[UIColor colorWithHex:0xcb414a andAlpha:1.0];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.layer.cornerRadius=5.0;
    return btn;
}

@end
