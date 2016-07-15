//
//  JDLRecipientTableViewCell.h
//  judicial
//
//  Created by zjsos on 16/6/9.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JDLRecipient.h"

typedef void(^clickBlock)(NSIndexPath *indexPath);

@interface JDLRecipientTableViewCell : UITableViewCell

@property (nonatomic,strong)JDLRecipient *recipient;
@property (nonatomic,strong)UIButton *btn;

@property (nonatomic,strong)clickBlock clickBtn;
@property (nonatomic,strong)NSArray *allSelectRecipients;

@property (nonatomic,strong)NSIndexPath *cellIndexPath;

@end
