//
//  JDLCaseTableViewCell.m
//  judicial
//
//  Created by zjsos on 16/6/11.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import "JDLCaseTableViewCell.h"
#import "JDLField.h"
#import "JDLConversion.h"
@implementation JDLCaseTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

-(void)setField:(JDLField *)field{
    _field=field;
    self.textLabel.text=field.fieldNmae;
    self.textLabel.font=[UIFont systemFontOfSize:14];
    self.detailTextLabel.text=field.fieldContent;
    if (field.fieldType==1) {
        self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
