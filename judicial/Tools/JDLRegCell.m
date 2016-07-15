//
//  JDLRegCell.m
//  judicial
//
//  Created by zjsos on 16/6/13.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import "JDLRegCell.h"

@implementation JDLRegCell

+(void)regCell:(UITableView *)tableiView Class:(NSArray *)cells{
    
    for (int i=0; i<cells.count; i++) {
        [tableiView registerClass:NSClassFromString(cells[i]) forCellReuseIdentifier:[NSString stringWithFormat:@"%@Cell",cells[i]]];
    }
}

@end
