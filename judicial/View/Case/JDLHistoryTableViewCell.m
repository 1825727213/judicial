//
//  JDLHistoryTableViewCell.m
//  judicial
//
//  Created by zjsos on 16/7/1.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import "JDLHistoryTableViewCell.h"
#import "JDLCase.h"
#import "NSString+JDLFrame.h"
#import "UIColor+Art.h"
@interface JDLHistoryTableViewCell ()

@property (nonatomic,strong)UILabel *titleLabel;

@property (nonatomic,strong)UILabel *leftLabel;

@property (nonatomic,strong)UILabel *rightLabel;

@end

@implementation JDLHistoryTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.leftLabel];
        [self addSubview:self.rightLabel];
    }
    return self;
}


-(void)setOnCase:(JDLCase *)onCase{
    _onCase=onCase;
    
    NSString *caseTitle=onCase.case_reason;
    if ([caseTitle isEqualToString:@""]) {
            caseTitle=@"无标题";
    }
    self.titleLabel.text=caseTitle;
    self.leftLabel.text=onCase.person_name;
    self.rightLabel.text=onCase.apply_date;
    [self changeViewFrame:self.frame];
}

-(void)changeViewFrame:(CGRect )frame{
    
    CGFloat titleHeight=[self.titleLabel.text getShowHeight:frame.size.width-40 font:self.titleLabel.font];
    
    CGFloat y=5;
    if (titleHeight<44) {
        titleHeight=44;
    }
    self.titleLabel.frame=CGRectMake(20, y, frame.size.width-40, titleHeight);
    
    self.leftLabel.frame=CGRectMake(20, y+=titleHeight+5, frame.size.width/2, 20);
    
    self.rightLabel.frame=CGRectMake(20+frame.size.width/2 +10, y, frame.size.width - 30 -10 -(frame.size.width/2) , 20);
    
}


-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel=[[UILabel alloc] init];
        _titleLabel.numberOfLines=0;
        _titleLabel.font=[UIFont systemFontOfSize:14];
    }
    return _titleLabel;
}

-(UILabel *)leftLabel{
    if (!_leftLabel) {
        _leftLabel=[[UILabel alloc] init];
        _leftLabel.font=[UIFont systemFontOfSize:12];
        _leftLabel.textColor=[UIColor colorWithHex:0xb7b7b7 andAlpha:1.0];
    }
    return _leftLabel;
}

-(UILabel *)rightLabel{
    if (!_rightLabel) {
        _rightLabel =[[UILabel alloc] init];
        _rightLabel.font=[UIFont systemFontOfSize:12];
        _rightLabel.textAlignment=NSTextAlignmentRight;
        _rightLabel.textColor=[UIColor colorWithHex:0xb7b7b7 andAlpha:1.0];
    }
    return _rightLabel;
}

@end
