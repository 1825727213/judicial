//
//  JDLPictureCollectionViewCell.m
//  judicial
//
//  Created by zjsos on 16/6/23.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import "JDLPictureCollectionViewCell.h"
#import "JDLPictrue.h"
#import "UIColor+Art.h"
@interface JDLPictureCollectionViewCell ()


@property (nonatomic,strong)UIImageView *imageView;

@end

@implementation JDLPictureCollectionViewCell


-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        
        [self.contentView addSubview:self.imageView];
        self.backgroundColor=[UIColor whiteColor];
        self.layer.borderWidth=1;
        self.layer.borderColor=[UIColor colorWithHex:0x7b7b7b andAlpha:1.0].CGColor;
        
    }
    return self;
}

-(void)setPictrue:(JDLPictrue *)pictrue{
    _pictrue=pictrue;
    self.imageView.image=[UIImage imageWithContentsOfFile:pictrue.thumbnailPath];
}


-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView=[[UIImageView alloc] init];
        _imageView.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        _imageView.contentMode=UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}


@end
