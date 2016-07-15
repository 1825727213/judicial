//
//  JDLMainModuleView.m
//  judicial
//
//  Created by zjsos on 16/6/8.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import "JDLMainModuleView.h"
#import "JDLModuleImageView.h"
@interface JDLMainModuleView ()

@property (nonatomic,strong)JDLModuleImageView *topLeftImageView;
@property (nonatomic,strong)JDLModuleImageView *topRightImageView;
@property (nonatomic,strong)JDLModuleImageView *bottomLeftImageView;
@property (nonatomic,strong)JDLModuleImageView *bottomRightImageView;
@property (nonatomic,strong)JDLModuleImageView *contentImageView;


@end

@implementation JDLMainModuleView

-(instancetype)init{
    self=[super init];
    if (self) {
        [self mainElementAdd];
    }
    return self;
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    int space=25;
    
    CGFloat width=(frame.size.width-space)/2  ;
    CGFloat height=(frame.size.height-space)/2 ;
    int roundSpace=13;
    //NSLog(@"width=%f height=%f",width,height);
    self.topLeftImageView.frame=CGRectMake(0, 0,width ,height);
    self.topRightImageView.frame=CGRectMake(width+space , 0,width ,height);
    self.bottomLeftImageView.frame=CGRectMake(0, height+space,width ,height);
    self.bottomRightImageView.frame=CGRectMake(width+space, height+space,width ,height);
    self.contentImageView.frame=CGRectMake(width/2+roundSpace, height/2+roundSpace,width ,height);
}

-(void)mainElementAdd{
    [self addSubview:self.topLeftImageView];
    [self addSubview:self.topRightImageView];
    [self addSubview:self.bottomLeftImageView];
    [self addSubview:self.bottomRightImageView];
    [self addSubview:self.contentImageView];
    
}

#pragma mark 懒加载
-(UIImageView *)topLeftImageView{
    if (!_topLeftImageView)
    {
        _topLeftImageView=[[JDLModuleImageView alloc] init];
        _topLeftImageView.image=[UIImage imageNamed:@"mainTopLeft"];
        _topLeftImageView.moduleType=0;
        //_topLeftImageView.backgroundColor=[UIColor blueColor];
    }
    return _topLeftImageView;
}
-(UIImageView *)topRightImageView{
    if (!_topRightImageView) {
        _topRightImageView=[[JDLModuleImageView alloc] init];
        _topRightImageView.image=[UIImage imageNamed:@"mainTopRight"];
        _topRightImageView.moduleType=1;
        //_topRightImageView.backgroundColor=[UIColor yellowColor];
    }
    return _topRightImageView;
}
-(UIImageView *)bottomLeftImageView{
    if (!_bottomLeftImageView) {
        _bottomLeftImageView=[[JDLModuleImageView alloc] init];
        _bottomLeftImageView.image=[UIImage imageNamed:@"mainBottomLeft"];
        _bottomLeftImageView.moduleType=2;
        //_bottomLeftImageView.backgroundColor=[UIColor purpleColor];
    }
    return _bottomLeftImageView;
}
-(UIImageView *)bottomRightImageView{
    if (!_bottomRightImageView) {
        _bottomRightImageView=[[JDLModuleImageView alloc] init];
        _bottomRightImageView.image=[UIImage imageNamed:@"mainBottomRight"];
        _bottomRightImageView.moduleType=3;
        //_bottomRightImageView.backgroundColor=[UIColor orangeColor];
    }
    return _bottomRightImageView;
}
-(UIImageView *)contentImageView{
    if (!_contentImageView) {
        _contentImageView=[[JDLModuleImageView alloc] init];
        _contentImageView.image=[UIImage imageNamed:@"mainRound"];
        //_contentImageView.backgroundColor=[UIColor lightGrayColor];
        _contentImageView.moduleType=5;
    }
    return _contentImageView;
}

@end
