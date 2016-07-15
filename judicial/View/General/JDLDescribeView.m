//
//  JDLDescribeView.m
//  judicial
//
//  Created by zjsos on 16/7/3.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import "JDLDescribeView.h"
#import "UIColor+Art.h"

@interface JDLDescribeView ()

@property (nonatomic,strong)UILabel *describeLabel;
@property (nonatomic,strong)UIImageView *imageView;

@end

@implementation JDLDescribeView

-(instancetype)init{
    self=[super init];
    if (self) {
        self.backgroundColor=[UIColor colorWithHex:0xfdf7e7 andAlpha:1.0];
        [self addSubview:self.describeLabel];
        [self addSubview:self.imageView];
    }
    return self;
}

-(void)setDescribeText:(NSString *)text{
    self.describeLabel.text=text;
    [self changeText];
}


-(void)setFrame:(CGRect)frame{
    [super  setFrame:frame];
    self.describeLabel.frame=CGRectMake(10, 10, frame.size.width-20, frame.size.height-15);
    self.imageView.frame=CGRectMake(10, 7, 20, 20);
}

-(void)changeText{
    NSUInteger length = [self.describeLabel.text length];
    if (length>0) {
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:self.describeLabel.text];
        NSMutableParagraphStyle *  style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        style.firstLineHeadIndent = 20;//首行头缩进
        [style setLineSpacing:3];
        [attrString addAttribute:NSStrokeColorAttributeName value:[UIColor greenColor] range:[self.describeLabel.text rangeOfString:@"is"]];
        const CGFloat fontSize = 12.0;
        UIFont *boldFont = [UIFont boldSystemFontOfSize:fontSize];
        [attrString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, length)];
        self.describeLabel.font=boldFont;
        self.describeLabel.attributedText = attrString;
    }
    
}



-(UILabel *)describeLabel{
    if (!_describeLabel) {
        _describeLabel=[[UILabel alloc] init];
        _describeLabel.numberOfLines=0;
        //_describeLabel.text=@"本界面仅展示可选择点援的律师信息，选择律师必须在法律援助案件申请受理后方可操作。";
        _describeLabel.textColor=[UIColor colorWithHex:0x64696c andAlpha:1.0];
        
    }
    return _describeLabel;
}

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"alert"]];
    }
    return _imageView;
    
}

@end
