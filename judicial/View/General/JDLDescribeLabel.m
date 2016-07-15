//
//  JDLDescribeLabel.m
//  judicial
//
//  Created by zjsos on 16/6/14.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import "JDLDescribeLabel.h"
#import "UIColor+Art.h"
@implementation JDLDescribeLabel
-(instancetype)init{
    self=[super init];
    if (self) {
        self.backgroundColor=[UIColor colorWithHex:0xfdf7e7 andAlpha:1.0];
        self.textColor=[UIColor colorWithHex:0x64696c andAlpha:1.0];
    }
    return self;
}

-(void)setText:(NSString *)text{
    [super setText:text];
    [self changeText];
}

-(void)changeText{
    NSUInteger length = [self.text length];
    if (length>0) {
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:self.text];
        NSMutableParagraphStyle *  style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        style.firstLineHeadIndent = 40;//首行头缩进
        [attrString addAttribute:NSStrokeColorAttributeName value:[UIColor greenColor] range:[self.text rangeOfString:@"is"]];
        const CGFloat fontSize = 12.0;
        UIFont *boldFont = [UIFont boldSystemFontOfSize:fontSize];
        [attrString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, length)];
        self.font=boldFont;
        self.attributedText = attrString;
    }
    
}
@end
