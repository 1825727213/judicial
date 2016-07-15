//
//  JDLPictrueShowViewController.m
//  judicial
//
//  Created by zjsos on 16/6/25.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import "JDLPictrueShowViewController.h"
#import "JDLMainRollView.h"
#import "JDLPictrue.h"
@interface JDLPictrueShowViewController ()

@property (nonatomic,strong)JDLMainRollView *rollView;
@property (nonatomic,strong)UIPageControl *pageControl;
@property (nonatomic,strong)NSMutableArray *allImages;
@property (nonatomic,assign)NSInteger currentIndex;
@end

@implementation JDLPictrueShowViewController

-(instancetype)init{
    self=[super init];
    if (self) {
        self.view.backgroundColor=[UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    
    UIBarButtonItem *delItem=[[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(deleteItem:)];
    
    self.navigationItem.rightBarButtonItem=delItem;
    [self.view addSubview:self.rollView];
    [self.view addSubview:self.pageControl];
    // Do any additional setup after loading the view.
}

-(void)deleteItem:(UIBarButtonItem *)item{
    if (self.currentIndex!= 1000) {
        self.delImage(self.currentIndex);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)viewDidLayoutSubviews{
    self.rollView.frame=self.view.frame;
    self.pageControl.frame=CGRectMake(0, self.view.frame.size.height-40,self.view.frame.size.width , 40);
}


-(void)setImages:(NSMutableArray *)arr andIndex:(NSInteger)index{
    self.allImages=arr;
    NSMutableArray *newArr=[arr mutableCopy];
    [newArr removeObjectAtIndex:0];
    [self.rollView setImages:newArr andIndex:index-1];
}


-(JDLMainRollView *)rollView{
    if (!_rollView) {
        _rollView=[[JDLMainRollView alloc] initWithImages:nil];
        __weak JDLPictrueShowViewController *ps=self;
        __weak NSMutableArray *picArr=self.allImages;
       
        _rollView.crtPicture=^(NSInteger currentIndex ){
            JDLPictrue *pic=picArr[currentIndex+1];
            ps.currentIndex=currentIndex+1;
            ps.title=[pic.thumbnailPath lastPathComponent];
        };
        _rollView.pageControl=self.pageControl;
        //_rollView.backgroundColor=[UIColor blueColor];
    }
    return _rollView;
}

-(UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl=[[UIPageControl alloc] init];
        _pageControl.userInteractionEnabled=NO;
    }
    return _pageControl;
}

-(NSInteger )currentIndex{
    if (!_currentIndex) {
        _currentIndex=1000;
    }
    return _currentIndex;
}


@end
