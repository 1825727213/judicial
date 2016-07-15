//
//  JDLPictrue.m
//  judicial
//
//  Created by zjsos on 16/6/23.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import "JDLPictrue.h"

@implementation JDLPictrue

-(instancetype)initWithThumbnailPath:(NSString *)thumbnailPath andPicturnPath:(NSString *)picturnPath andType:(NSString *)type{
    self=[super init];
    if (self) {
        self.thumbnailPath=thumbnailPath;
        self.picturnPath=picturnPath;
        self.type=type;
    }
    return self;
}

+(instancetype)initWithThumbnailPath:(NSString *)thumbnailPath andPicturnPath:(NSString *)picturnPath andType:(NSString *)type{
    return [[self alloc] initWithThumbnailPath:thumbnailPath andPicturnPath:picturnPath andType:type];
}

@end
