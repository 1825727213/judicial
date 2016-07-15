//
//  UIColor+Art.h
//  demo_color_category
//
//  Created by w gq on 15/6/17.
//  Copyright (c) 2015年 w gq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Art)

+(UIColor *)colorWith255Red:(NSInteger)red greed:(NSInteger)greed blue:(NSInteger )blue alpha:(CGFloat)alpha;
+(UIColor *)colorWithHex:(long)hex andAlpha:(CGFloat )alpha;
+(UIColor *)colorWithCGFloatRed:(CGFloat)red greed:(CGFloat)greed blue:(CGFloat)blue alpha:(CGFloat)alpha;
@end
