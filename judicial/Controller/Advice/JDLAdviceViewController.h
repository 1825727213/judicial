//
//  JDLAdviceViewController.h
//  judicial
//
//  Created by zjsos on 16/6/11.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JDLCase;
@interface JDLAdviceViewController : UIViewController

@property (nonatomic,strong)NSString *postURL;

@property (nonatomic,strong)JDLCase *assistanceCase;

@end
