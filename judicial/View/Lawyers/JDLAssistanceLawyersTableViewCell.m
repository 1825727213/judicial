//
//  JDLAssistanceLawyersTableViewCell.m
//  judicial
//
//  Created by zjsos on 16/6/28.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import "JDLAssistanceLawyersTableViewCell.h"
#import "JDLAssistanceLawyer.h"
#import "NSString+JDLFrame.h"
#import "JDLStarsView.h"
#import "JDLConversion.h"
@interface JDLAssistanceLawyersTableViewCell ()

@property (nonatomic,strong)UILabel *numberLabel;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *lawyerLabel;
@property (nonatomic,strong)UILabel *specialtyLabel;
@property (nonatomic,strong)JDLStarsView *averageView;


@end

@implementation JDLAssistanceLawyersTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.numberLabel];
        [self addSubview:self.nameLabel];
        [self addSubview:self.lawyerLabel];
        [self addSubview:self.specialtyLabel];
        [self addSubview:self.averageView];
    }
    return self;
}

-(void)setLawyer:(JDLAssistanceLawyer *)lawyer{
    _lawyer=lawyer;
    self.numberLabel.text=[NSString stringWithFormat:@"%ld.",self.tag+1];
    self.nameLabel.text=lawyer.operator_name;
    self.lawyerLabel.text=lawyer.branch_name;
    self.specialtyLabel.text=lawyer.specialty;
    
    [self.averageView setStarsCount:[JDLConversion scoreToStar:[lawyer.average integerValue]]];
}




-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    CGFloat width=frame.size.width/3,y=0;
    self.numberLabel.frame=CGRectMake(0, y, width, frame.size.height);
    self.nameLabel.frame=CGRectMake(width , y+=10, width *2 - 10, 20);
    CGFloat lawyerLabelHeight=[self.lawyerLabel.text getShowHeight:width *2 - 10 font:self.lawyerLabel.font];
    self.lawyerLabel.frame=CGRectMake(width, y+=self.nameLabel.frame.size.height+5, width *2 - 10, lawyerLabelHeight);
    CGFloat specialtyLabelHeight=[self.specialtyLabel.text getShowHeight:width *2 - 10 font:self.lawyerLabel.font];
    self.specialtyLabel.frame=CGRectMake(width, y+=lawyerLabelHeight+5, width *2 - 10, specialtyLabelHeight);
    self.averageView.frame=CGRectMake(width, y+=specialtyLabelHeight+5, 16*5, 16);
}

-(UILabel *)numberLabel{
    if (!_numberLabel) {
        _numberLabel=[[UILabel alloc] init];
        _numberLabel.textColor=[UIColor redColor];
        _numberLabel.font=[UIFont systemFontOfSize:24];
        _numberLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _numberLabel;
}

-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel=[[UILabel alloc] init];
    }
    return _nameLabel;
}

-(UILabel *)lawyerLabel{
    if (!_lawyerLabel) {
        _lawyerLabel=[[UILabel alloc] init];
        _lawyerLabel.font=[UIFont systemFontOfSize:12];
    }
    return _lawyerLabel;
}

-(UILabel *)specialtyLabel{
    if (!_specialtyLabel) {
        _specialtyLabel=[[UILabel alloc] init];
        _specialtyLabel.font=[UIFont systemFontOfSize:12];
        _specialtyLabel.numberOfLines=0;
    }
    return _specialtyLabel;
}

-(JDLStarsView *)averageView{
    if (!_averageView) {
        _averageView=[[JDLStarsView alloc] init];
    }
    return _averageView;
}

@end
