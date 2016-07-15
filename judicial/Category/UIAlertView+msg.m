//
//  UIAlertView+msg.m
//  Lovesickness
//
//  Created by w gq on 15/8/6.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import "UIAlertView+msg.h"

@implementation UIAlertView (msg)

+(void)alertWithMsg:(NSString *)msg
{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"错误提示" message:msg delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alert show];
    
}

@end
