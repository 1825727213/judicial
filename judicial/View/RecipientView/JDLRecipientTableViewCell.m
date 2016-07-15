//
//  JDLRecipientTableViewCell.m
//  judicial
//
//  Created by zjsos on 16/6/9.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import "JDLRecipientTableViewCell.h"

@interface JDLRecipientTableViewCell ()

@end

@implementation JDLRecipientTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier    {
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryView=self.btn;
    }
    return self;
}

-(void)click:(UIButton *)btn{
    self.clickBtn(self.cellIndexPath);
}

-(void)setRecipient:(JDLRecipient *)recipient{
    _recipient=recipient;
    self.textLabel.text=recipient.name;
    
}

-(void)setAllSelectRecipients:(NSArray *)allSelectRecipients{
    _allSelectRecipients=allSelectRecipients;
    for (NSString *name in allSelectRecipients) {
        if ([name isEqualToString:self.recipient.name]) {
            [self.btn setSelected:YES];
        }
    }
}


-(UIButton *)btn{
    if (!_btn) {
        _btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_btn setImage:[UIImage imageNamed:@"recipient"] forState:UIControlStateNormal];
        [_btn setImage:[UIImage imageNamed:@"recipientSelected"] forState:UIControlStateSelected];
        [_btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        _btn.frame=CGRectMake(0, 0, 25, 25);
    }
    return _btn;
}
@end
