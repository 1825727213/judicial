//
//  JDLChoosePictureCollectionViewController.h
//  judicial
//
//  Created by zjsos on 16/6/23.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^ChoosePicture)(NSArray *pictures,NSString *type);
@interface JDLChoosePictureCollectionViewController : UICollectionViewController
@property (nonatomic,strong)NSString *type;
@property (nonatomic,strong)NSMutableArray *BeforeArray;
@property (nonatomic,strong)ChoosePicture cosPicture;

@end
