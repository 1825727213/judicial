//
//  JDLInfoTableViewCell.m
//  judicial
//
//  Created by zjsos on 16/6/10.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import "JDLInfoTableViewCell.h"

@implementation JDLInfoTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
