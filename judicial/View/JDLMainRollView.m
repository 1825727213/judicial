//
//  JDLMainRollView.m
//  judicial
//
//  Created by zjsos on 16/6/6.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import "JDLMainRollView.h"
#import "JDLMainImageView.h"
#import "JDLPictrue.h"
@interface JDLMainRollView ()<UIScrollViewDelegate>

@property(nonatomic,strong)UIImageView *leftImageView;
@property(nonatomic,strong)UIImageView *contentImageView;
@property(nonatomic,strong)UIImageView *rightImageView;

@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic,strong)NSArray *allImageView;

@property (nonatomic,assign)NSInteger currentIndex;

@property (nonatomic,assign)CGFloat haploidWidth;

@end

@implementation JDLMainRollView


-(instancetype)initWithImages:(NSArray *)images{
    self=[super init];
    if (self) {
        self.pagingEnabled=YES;
        self.delegate=self;
        self.bounces=NO;
        self.showsHorizontalScrollIndicator=NO;
        self.userInteractionEnabled=YES;
        [self mainElementAdd];
        UITapGestureRecognizer *tapGR=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:tapGR];
        
    }
    return self;
}



#pragma  mark 核心方法－控制图片
/**
 *  核心方法－控制图片
 */
-(void)controlImageView{
    if (self.allImages.count==0) {
        [self.pageControl setHidden:YES];
        return ;
    }
    else if (self.allImages.count==1)
    {
        JDLPictrue *pictrue=self.allImages[0];
        UIImage *image=[UIImage imageWithContentsOfFile:pictrue.thumbnailPath];
        self.leftImageView.image=image;
        self.contentImageView.image=image;
        self.rightImageView.image=image;
        [self.pageControl setHidden:YES];
        self.crtPicture(0);
    }
    else
    {
        
        self.pageControl.currentPage=self.currentIndex;
        JDLPictrue *pictrueBefore=self.allImages[[self getBefore:self.currentIndex]];
        JDLPictrue *pictrueCurrent=self.allImages[self.currentIndex];
        JDLPictrue *pictrueNext=self.allImages[[self getNext:self.currentIndex]];
        self.leftImageView.image=[UIImage imageWithContentsOfFile:pictrueBefore.thumbnailPath];
        self.contentImageView.image=[UIImage imageWithContentsOfFile:pictrueCurrent.thumbnailPath];
        self.rightImageView.image=[UIImage imageWithContentsOfFile:pictrueNext.thumbnailPath];
        self.crtPicture(self.currentIndex);
    }
}


-(void)setImages:(NSArray *)arr andIndex:(NSInteger)index{
    self.currentIndex=index;
    self.allImages=arr;
    self.pageControl.numberOfPages=arr.count;
    [self controlImageView];
}

//图片滚动到一定坐标 返回中间iamgeview的坐标
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    BOOL flog=NO;
    if (self.haploidWidth!=0) {
        if(scrollView.contentOffset.x == self.haploidWidth * 2){
            scrollView.contentOffset=CGPointMake(self.haploidWidth, scrollView.contentOffset.y);
            [self updateCurrentIndex:YES];
            flog=YES;
        }
        else if(scrollView.contentOffset.x == 0){
            scrollView.contentOffset=CGPointMake(self.haploidWidth, scrollView.contentOffset.y);
            [self updateCurrentIndex:NO];
            flog=YES;
        }
    }
    if (flog) {
        [self controlImageView];
    }
}
#pragma mark 布局
-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    CGFloat y= self.bounds.origin.y-10;
    CGFloat width=frame.size.width,height=frame.size.height,x=0;
    self.haploidWidth=frame.size.width;
    
    
    
    //设置左中右imageview的坐标
    for (int i=0; i<self.allImageView.count; i++) {
        UIImageView *imageView=self.allImageView[i];
        imageView.frame=CGRectMake(x, y, width, height);
        imageView.contentMode=self.contentMode;
        x+=width;
        
        
    }
    self.contentSize=CGSizeMake(self.haploidWidth*3, 0);
    self.contentOffset=CGPointMake(self.haploidWidth, self.contentOffset.y);
}

-(void)tap:(UITapGestureRecognizer *)gr{
    //NSLog(@"self.currentIndex=%ld",self.currentIndex);
    self.clickPicture(self,self.allImages[self.currentIndex],self.currentIndex);
}

/**
 *  获取上一张或下一张的坐标
 *
 *  @param type yes 下一张 no 上一张
 */
-(void)updateCurrentIndex:(BOOL)type{
    if (type) {
        self.currentIndex=[self getNext:self.currentIndex];
    }
    else{
        self.currentIndex=[self getBefore:self.currentIndex];
    }
    
}
/**
 *  获取前一个下标
 *
 *  @param current 当前坐标
 *
 *  @return 当最小后自动取最大的
 */
-(NSInteger)getBefore:(NSInteger)current {
    if (self.currentIndex <=0) {
        return self.allImages.count-1;
    }
    return self.currentIndex-1;
}
/**
 *  获取下一个下标
 *
 *  @param current 当前坐标
 *
 *  @return 最大后自动取最小的
 */
-(NSInteger)getNext:(NSInteger)current{
    if (self.currentIndex >=self.allImages.count-1 ) {
        return 0;
    }
    return self.currentIndex+1;
}



//添加页面元素
-(void)mainElementAdd{
    [self addSubview:self.leftImageView];
    [self addSubview:self.contentImageView];
    [self addSubview:self.rightImageView];
}
#pragma mark 懒加载
-(NSArray *)allImageView{
    if (!_allImageView) {
        _allImageView=@[self.leftImageView,self.contentImageView,self.rightImageView];
    }
    return _allImageView;
}

-(UIImageView *)leftImageView{
    if (!_leftImageView) {
        _leftImageView=[[JDLMainImageView alloc] init];
    }
    return _leftImageView;
}

-(UIImageView *)contentImageView{
    if (!_contentImageView) {
        _contentImageView=[[JDLMainImageView alloc] init];
    }
    return _contentImageView;
}

-(UIImageView *)rightImageView{
    if (!_rightImageView) {
        _rightImageView=[[JDLMainImageView alloc] init];
    }
    return _rightImageView;
}

-(NSInteger)currentIndex{
    if (!_currentIndex) {
        _currentIndex=0;
    }
    return _currentIndex;
}

-(UIViewContentMode)contentMode{
    if (!_contentMode) {
        _contentMode=UIViewContentModeScaleAspectFit;
    }
    return _contentMode;
}

@end
