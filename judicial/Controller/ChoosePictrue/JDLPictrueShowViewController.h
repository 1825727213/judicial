//
//  JDLPictrueShowViewController.h
//  judicial
//
//  Created by zjsos on 16/6/25.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DeleteImage)(NSInteger);

@interface JDLPictrueShowViewController : UIViewController

@property (nonatomic,strong)DeleteImage delImage;

-(void)setImages:(NSMutableArray *)arr andIndex:(NSInteger)index;

@end
