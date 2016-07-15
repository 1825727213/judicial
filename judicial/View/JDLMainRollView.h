//
//  JDLMainRollView.h
//  judicial
//
//  Created by zjsos on 16/6/6.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JDLPictrue,JDLMainRollView;
typedef void(^currentPicture)(NSInteger );

typedef void(^ClickPicture)(JDLMainRollView * rollView, JDLPictrue *pictrue ,NSInteger currentIndex);

@interface JDLMainRollView : UIScrollView

@property (nonatomic)UIViewContentMode contentMode;

@property (nonatomic,strong)NSArray *allImages;


@property (nonatomic,strong)UIPageControl *pageControl;

@property (nonatomic,strong)currentPicture crtPicture;

@property (nonatomic,strong)ClickPicture clickPicture;


-(instancetype)initWithImages:(NSArray *)images;
-(void)setImages:(NSArray *)arr andIndex:(NSInteger)index;
@end
