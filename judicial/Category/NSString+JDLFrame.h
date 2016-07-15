//
//  NSString+JDLFrame.h
//  judicial
//
//  Created by zjsos on 16/6/18.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (JDLFrame)

-(CGFloat)getShowHeight:(CGFloat)maxWidth font:(UIFont *)font;
-(CGFloat)get320Height;
-(NSString *)emptyStringTo0;
-(NSString *)nilStringToEmptyString;

@end
