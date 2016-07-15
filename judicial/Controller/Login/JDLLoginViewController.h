//
//  JDLLoginViewController.h
//  judicial
//
//  Created by zjsos on 16/6/29.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UserLoginSuccess)(NSDictionary *userInfo);
@interface JDLLoginViewController : UIViewController

@property (nonatomic,strong)UserLoginSuccess loginSuccess;

@end
