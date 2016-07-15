//
//  JDLSearchTextField.m
//  judicial
//
//  Created by zjsos on 16/7/7.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import "JDLSearchTextField.h"
#import "UIColor+Art.h"


@implementation JDLSearchTextField

-(instancetype)initWidthDelegate:(id<UITextFieldDelegate>) delegate{
    
    self=[super init];
    if (self) {
        self.delegate=delegate;
        self.frame= CGRectMake(10, 50,[[UIScreen mainScreen]bounds ].size.width-10, 30);
        //self.borderStyle=UITextBorderStyleLine;
        self.autocorrectionType = UITextAutocorrectionTypeNo;
        //self.layer.borderColor=[UIColor colorWithHex:0xb7b7b7 andAlpha:0.7].CGColor;
        UIImageView *imageview=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"seach"]];
        imageview.frame=CGRectMake(0, 0, 50, 25);
        self.placeholder=@"搜索律师:请输入律师名称";
        self.returnKeyType =UIReturnKeySearch;
        self.font=[UIFont systemFontOfSize:14];
        self.rightViewMode=UITextFieldViewModeAlways;
        self.rightView = imageview;
        self.textAlignment=NSTextAlignmentLeft;
        self.keyboardType=UIKeyboardTypeDefault;
        self.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    }
    return self;
}

@end
