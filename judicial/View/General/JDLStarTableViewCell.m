//
//  JDLStarTableViewCell.m
//  judicial
//
//  Created by zjsos on 16/7/1.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import "JDLStarTableViewCell.h"
#import "JDLLoadView.h"
@interface JDLStarTableViewCell ()

@property (nonatomic,strong)JDLLoadView *jdloadView;

@end

@implementation JDLStarTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

@end
