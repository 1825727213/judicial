//
//  JDLLawyerContentTableViewController.h
//  judicial
//
//  Created by zjsos on 16/6/28.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JDLAssistanceLawyer,JDLCase  ;

@interface JDLLawyerContentTableViewController : UITableViewController

@property (nonatomic,strong)JDLCase *assistanceCase;
@property (nonatomic,strong)JDLAssistanceLawyer *lawyer;

@end
