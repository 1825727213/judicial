//
//  NSString+JDLFrame.m
//  judicial
//
//  Created by zjsos on 16/6/18.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import "NSString+JDLFrame.h"

@implementation NSString (JDLFrame)


/**
 *  获取显示文字的高度
 *
 *  @param maxWidth 最大宽度
 *  @param font     字体
 *
 *  @return 文字的高度
 */
-(CGFloat)getShowHeight:(CGFloat)maxWidth font:(UIFont *)font{
    
    CGRect tmpRect = [self boundingRectWithSize:CGSizeMake(maxWidth, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil];
    return tmpRect.size.height;
}
-(CGFloat)get320Height{
    UIFont *fnt = [UIFont fontWithName:@"HelveticaNeue" size:24.0f];
    return [self getShowHeight:320 font:fnt];
}

-(NSString *)emptyStringTo0{
    if ([self isEqualToString:@""]) {
        return @"0";
    }
    return self;
}

-(NSString *)nilStringToEmptyString{
    if (self==nil) {
        return  @"";
    }
    return self;
}

@end
