//
//  JDLPartiesTableViewController.h
//  judicial
//
//  Created by zjsos on 16/6/9.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JDLField;
typedef void(^returnSelectedRecipient)(NSString *str);
@interface JDLRecipientTableViewController : UITableViewController

@property (nonatomic,strong)JDLField *field;

@property (nonatomic,strong)NSArray *caseRecipients;

@property (nonatomic,strong)returnSelectedRecipient selectedRecipient;


@end
