//
//  JDLTextViewController.h
//  judicial
//
//  Created by zjsos on 16/6/13.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JDLField,JDLTextViewController;
typedef void(^returnTextView)(JDLTextViewController * textView,NSString  *text);
@interface JDLTextViewController : UIViewController

@property (nonatomic,strong)returnTextView returnText;

@property (nonatomic,strong)JDLField *field;

@end
