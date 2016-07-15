//
//  JDLTextTableViewCell.m
//  judicial
//
//  Created by zjsos on 16/6/16.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import "JDLTextTableViewCell.h"
#import "JDLField.h"
#import "JDLChooseView.h"
#import "JDLLawyer.h"
#import "JDLLawyerController.h"
#import "JDLConversion.h"
@interface JDLTextTableViewCell ()<UITextFieldDelegate>

@property (nonatomic,strong)UIView *keepvView;

@end

@implementation JDLTextTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addSubview:self.textFiled];
        [self addSubview:self.keepvView];
       
        self.textLabel.font=[UIFont systemFontOfSize:14.0];
    }
    return self;
}
-(void)setField:(JDLField *)field{
    _field=field;
    self.textLabel.text=field.fieldNmae;
    self.textFiled.text=field.fieldContent;
    self.chooseTextValue=field.clickMethods;
}

-(UITextField *)textFiled{
    if (!_textFiled) {
        int width=200,height=30;
        _textFiled=[[UITextField alloc] initWithFrame:CGRectMake(self.frame.size.width-width-5, (self.frame.size.height-30)/2, width,height)];
        _textFiled.borderStyle=UITextBorderStyleNone;
        _textFiled.delegate=self;
        _textFiled.font=[UIFont systemFontOfSize:12];
        _textFiled.textAlignment=NSTextAlignmentRight;
        NSArray *lawyers=[JDLLawyer defaultLawyers];
        NSMutableArray *arr=[NSMutableArray new];
        for (int i=0; i<lawyers.count; i++) {
            JDLLawyer *lawyer=lawyers[i];
            [arr addObject:lawyer.paper];
        }
        self.keepvView.frame=_textFiled.frame;
        JDLChooseView *chooseView=[[JDLChooseView alloc] initWithFrame:CGRectMake(0, 44, 320,254) andArray:[arr copy]];
        chooseView.chooseValue=^(NSString *value){
            _textFiled.text=[[JDLLawyerController sharedSupport] getPaperToLawyerName:value] ;
            self.field.fieldContent=_textFiled.text;
            self.chooseTextValue(value);
        };
        chooseView.clickValue=^(){
            [_textFiled resignFirstResponder];
        };
        _textFiled.inputView=chooseView;
    }
    return _textFiled;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"textFieldShouldReturn");
    return YES;
}


-(UIView *)keepvView{

    if (!_keepvView) {
        _keepvView=[[UIView alloc] init];
    }
    return _keepvView;
}

@end
