//
//  JDLRadioTableViewCell.h
//  judicial
//
//  Created by zjsos on 16/6/15.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JDLField;

typedef void (^ClickRadio)(NSString *value);
@interface JDLRadioTableViewCell : UITableViewCell

@property (nonatomic,strong)JDLField *field;

@property (nonatomic,strong)ClickRadio clickRadio;


@end
