//
//  JDLRecipientInfoTableViewController.h
//  judicial
//
//  Created by zjsos on 16/6/10.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JDLRecipient;

typedef void(^returnSaveBtn)();
@interface JDLRecipientInfoTableViewController : UITableViewController

@property (nonatomic,strong)JDLRecipient *recipient;

@property (nonatomic,strong)returnSaveBtn saveBtn;

@end
