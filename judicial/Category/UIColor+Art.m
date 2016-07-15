//
//  UIColor+Art.m
//  demo_color_category
//
//  Created by w gq on 15/6/17.
//  Copyright (c) 2015年 w gq. All rights reserved.
//

#import "UIColor+Art.h"

@implementation UIColor (Art)

//使用十进制设置背景颜色
+(UIColor *)colorWith255Red:(NSInteger)red greed:(NSInteger)greed blue:(NSInteger)blue alpha:(CGFloat)alpha
{
    
    return [UIColor colorWithRed:red/255.0 green:greed/255.0 blue:blue/255.0 alpha:alpha];
}
//使用16进制设置颜色
+(UIColor *)colorWithHex:(long)hex andAlpha:(CGFloat)alpha
{
    
    float red= (float)((hex & 0xff0000) >> 16 )/255.0;
    float greed= (float)((hex & 0x00ff00) >> 8 )/255.0;
    float blue= (float)(hex & 0x0000ff )/255.0;
    return [UIColor colorWithRed:red green:greed blue:blue alpha:alpha];
}

+(UIColor *)colorWithCGFloatRed:(CGFloat)red greed:(CGFloat)greed blue:(CGFloat)blue alpha:(CGFloat)alpha
{
    
    return [UIColor colorWithRed:red/255.0 green:greed/255.0 blue:blue/255.0 alpha:alpha];
}

@end
