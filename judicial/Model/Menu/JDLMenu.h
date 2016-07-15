//
//  JDLMenu.h
//  MenuDemo
//
//  Created by zjsos on 16/7/14.
//  Copyright © 2016年 Lying. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDLMenu : NSObject

@property (nonatomic,strong)NSString * imageName;

@property (nonatomic,strong)NSString *title;


//-initWithImageName:(NSString *)imageName andTitle:(NSString *)title;


+(instancetype)initWithImageName:(NSString *)imageName andTitle:(NSString *)title;


+(NSArray *)defaultMenu;

@end
