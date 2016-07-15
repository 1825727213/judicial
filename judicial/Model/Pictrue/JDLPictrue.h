//
//  JDLPictrue.h
//  judicial
//
//  Created by zjsos on 16/6/23.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDLPictrue : NSObject

@property (nonatomic ,strong )NSString *thumbnailPath;

@property (nonatomic ,strong )NSString *picturnPath;

@property (nonatomic,strong)NSString *type;

@property (nonatomic,strong)NSString *openURL;

+(instancetype)initWithThumbnailPath:(NSString *)thumbnailPath andPicturnPath:(NSString *)picturnPath andType:(NSString *)type;

@end
