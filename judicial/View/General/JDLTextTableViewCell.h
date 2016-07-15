//
//  JDLTextTableViewCell.h
//  judicial
//
//  Created by zjsos on 16/6/16.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JDLField,JDLTextTableViewCell ;

typedef void(^confirmChooseTextValue)(NSString *value);

@interface JDLTextTableViewCell : UITableViewCell

@property (nonatomic)JDLField *field;

@property (nonatomic,strong)UITextField *textFiled;

@property (nonatomic,strong)confirmChooseTextValue chooseTextValue;

@end
