//
//  JDLRadioTableViewCell.m
//  judicial
//
//  Created by zjsos on 16/6/15.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import "JDLRadioTableViewCell.h"
#import "JDLField.h"
#import "JDLConversion.h"
@interface JDLRadioTableViewCell ()

@property (nonatomic,strong)NSMutableArray *allBtns;

@property (nonatomic,strong)NSMutableArray *allLabels;

@end

@implementation JDLRadioTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

-(void)setField:(JDLField *)field{
    _field=field;
    self.textLabel.text=field.fieldNmae;
    self.textLabel.font=[UIFont systemFontOfSize:14];
    self.clickRadio=field.clickMethods;
    
    [self createInterface:field.defaultRadioValue];
}

-(void)createInterface:(NSString *)defaultRadioValue{
    int width=self.frame.size.width-10;
    
    NSInteger index=0;
    
    [self clearView];
    for (NSInteger i=self.field.fieldRadioValue.count-1; i>=0; i--) {
        /**
         *  添加文字
         */
        UIFont *fnt = [UIFont fontWithName:@"HelveticaNeue" size:12];
        NSString *title=self.field.fieldRadioValue[i];
        if ([title isEqualToString:self.field.fieldContent]) {
            index=i;
        }
        CGSize size = [title sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:fnt,NSFontAttributeName, nil]];
        UILabel *label=[[UILabel alloc] init];
        label.text=title;
        label.font=fnt;
        label.frame=CGRectMake( width -= size.width , 0, size.width, 50);
        [self addSubview:label];
        [self.allLabels addObject:label];
        /**
         *  添加按钮
         */
        UIButton *btn= [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"recipient"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"recipientSelected"] forState:UIControlStateSelected];
        btn.frame=CGRectMake(width -= 50 , 0, 50, 50);
        btn.tag=i;
        if (i==index) {
             [btn setSelected:YES];
        }
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [self.allBtns addObject:btn];
        
    }
}


-(void)clickBtn:(UIButton *)selBtn{
    for (UIButton *btn in self.allBtns) {
        [btn setSelected:NO];
    }
    [selBtn setSelected:YES];
    self.field.fieldContent=self.field.fieldRadioValue[selBtn.tag];
    if (self.clickRadio!=nil) {
        self.clickRadio(self.field.fieldRadioValue[selBtn.tag]);
    }
}


-(void)clearView{
    for (int i=0; i<self.allBtns.count; i++) {
        UIButton *btn=self.allBtns[i];
        [btn removeFromSuperview];
        UILabel *lab=self.allLabels[i];
        [lab removeFromSuperview];
    }
    self.allLabels=[NSMutableArray new];
    self.allBtns=[NSMutableArray new];
}

-(NSMutableArray *)allLabels{
    if (!_allLabels) {
        _allLabels=[NSMutableArray new];
    }
    return _allLabels;
}

-(NSMutableArray *)allBtns{
    if (!_allBtns) {
        _allBtns=[NSMutableArray new];
    }
    return _allBtns;
}


@end
