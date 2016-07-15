//
//  JDLChoosePictureLayout.m
//  judicial
//
//  Created by zjsos on 16/6/23.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import "JDLChoosePictureLayout.h"
#define CELLCOUNT 4
@implementation JDLChoosePictureLayout

-(instancetype)init
{
    self=[super init];
    if (self) {
        
        CGRect frame=[[UIScreen mainScreen] bounds];
        int width=(frame.size.width-40)/CELLCOUNT;
        //配置项的大小
        self.itemSize=CGSizeMake(width, width);
        //配置滚动的方向
        self.scrollDirection=UICollectionViewScrollDirectionVertical;
        //配置行间距
        self.minimumLineSpacing=10;
        //配置项间距
        self.minimumInteritemSpacing=1;
        //配置分区的外边距
        self.sectionInset=UIEdgeInsetsMake(10, 10, 10, 10);
    }
    return self;
}

@end
