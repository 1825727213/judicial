//
//  JDLLargeTextTableViewCell.m
//  judicial
//
//  Created by zjsos on 16/6/17.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import "JDLLargeTextTableViewCell.h"
#import "JDLField.h"
#import "JDLConversion.h"
#import "NSString+JDLFrame.h"
#import "JDLTitleLabel.h"
#import "UIColor+Art.h"
@interface JDLLargeTextTableViewCell ()

@property (nonatomic,strong)JDLTitleLabel *titleLabel;
@property (nonatomic,strong)JDLTitleLabel *contentLabel;

@end

@implementation JDLLargeTextTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.contentLabel];
        [self addSubview:self.titleLabel];
    }
    return self;
}
-(void)setField:(JDLField *)field{
    _field=field;
    
    self.contentLabel.text=field.fieldContent;
    self.titleLabel.text=field.fieldNmae;
    
    [self changeContentLabelFrame:self.contentLabel.text];
    
    
}



/**
 *  根据文字的不同，设置显示的位置和高度
 *
 *  @param showContent 显示的文字
 */
-(void)changeContentLabelFrame:(NSString *)showContent{
    if ([showContent isEqualToString:@""]) {
        self.contentLabel.text=self.field.prompted;
        self.contentLabel.textColor=[UIColor grayColor];
        showContent=self.field.prompted;
    }
    else{
        self.contentLabel.textColor=[UIColor blackColor];
    }
    
    CGFloat singleLineHeight=[@"请输入" getShowHeight:self.frame.size.width-(self.titleLabel.frame.size.width+self.titleLabel.frame.origin.x)-10 font:self.contentLabel.font];
    
    CGFloat height=[showContent getShowHeight:self.frame.size.width-(self.titleLabel.frame.size.width+self.titleLabel.frame.origin.x)-10 font:self.contentLabel.font];
    if (height<=singleLineHeight) {
        height=44;
        int x=self.titleLabel.frame.origin.x+self.titleLabel.frame.size.width+5;
        self.contentLabel.frame=CGRectMake(x, 0, self.frame.size.width-x-10, height);
        self.contentLabel.textAlignment=NSTextAlignmentRight;
    }
    else{
        height=[showContent getShowHeight:self.frame.size.width-50 font:self.contentLabel.font];
        self.contentLabel.frame=CGRectMake(30, 40, self.frame.size.width-50, height);
        self.contentLabel.textAlignment=NSTextAlignmentLeft;
        height+=55;
    }
    self.field.fieldHeight=height;
    if (self.field.fieldType==4) {
        self.contentLabel.textColor=[UIColor grayColor];
    }
}



-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel=[[JDLTitleLabel alloc] init];
        _contentLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _contentLabel;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel=[[JDLTitleLabel alloc] init];
        _titleLabel.frame=CGRectMake(15, 0, 100, 44);
    }
    return _titleLabel;
}

@end
