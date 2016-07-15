//
//  JDLAttachmentViewController.h
//  judicial
//
//  Created by zjsos on 16/6/27.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ChoosePictures)(NSArray *pictures);

@interface JDLAttachmentViewController : UIViewController

@property (nonatomic,strong)ChoosePictures choosePic;

@property (nonatomic,strong)NSArray *BeforeArray;

@end
