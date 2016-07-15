//
//  JDLPrompted.m
//  judicial
//
//  Created by zjsos on 16/6/20.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import "JDLPromptedViewController.h"
#import "UIColor+Art.h"
#import "UIView+Shortcut.h"
#import "AppDelegate.h"
#import "JDLMainViewController.h"
#import "JDLNavMainViewController.h"
#import "ASIFormDataRequest.h"
@interface JDLPromptedViewController ()

@property (nonatomic,strong)UIView *titleView;

@property (nonatomic,strong)UIImageView *imageView;

@property (nonatomic,strong)UILabel *titleLabel;

@property (nonatomic,strong)UILabel *mainPromptedLabel;

@property (nonatomic,strong)UILabel *promptedLabel;

@property (nonatomic,strong)UIButton *btn;

@end

@implementation JDLPromptedViewController

-(instancetype)init{
    self=[super init];
    if (self) {
        self.view.backgroundColor=[UIColor whiteColor];
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    //[self.view addSubview:self.titleView];
    [self.view addSubview:self.imageView];
    //[self.view addSubview:self.titleLabel];
    [self.view addSubview:self.mainPromptedLabel];
    [self.view addSubview:self.promptedLabel];
    [self.view addSubview:self.btn];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.title=@"提交成功";
    
}

-(void)viewDidLayoutSubviews{
    int y=self.topLayoutGuide.length,imageWidth=self.imageView.frame.size.width,width=self.view.frame.size.width;
    //self.titleView.frame=CGRectMake(0, y, width, 44);
    self.imageView.frame=CGRectMake( (width - imageWidth)/2, y+=80, imageWidth, imageWidth);
    self.mainPromptedLabel.frame=CGRectMake(70, y+=imageWidth +20, width-140, 44);
    self.promptedLabel.frame=CGRectMake(25, y+=44, width-50, 100);
    self.btn.frame=CGRectMake(50, y+100, width-100, 44);
    //self.titleLabel.frame=self.titleView.frame;
}

-(void)setUserInfo:(NSDictionary *)userInfo{
    _userInfo=userInfo;
    [self submitUserinfo:userInfo];
}

#pragma mark 获取用户信息
-(void)submitUserinfo:(NSDictionary *)userInfo{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://www.zjsos.net:8888/Statisticslog.asmx/InserStatistics"]];
        [request addPostValue:userInfo[@"phone"] forKey:@"LoginName"];
        [request addPostValue:userInfo[@"name"] forKey:@"RealName"];
        [request addPostValue:userInfo[@"card"] forKey:@"LoginIMEI"];
        [request addPostValue:@"sf" forKey:@"applicationid"];
        [request addPostValue:@"Submit" forKey:@"operAtion"];
        [request startAsynchronous];
    });
}


-(void)clickBtn:(UIButton *)btn{
    NSLog(@"返回首页");
    [self.navigationController popToRootViewControllerAnimated:YES];
//    JDLMainViewController *main=[[JDLMainViewController alloc] init];
//    
//    JDLNavMainViewController *nav=[[JDLNavMainViewController alloc] initWithRootViewController:main];
//    [self presentViewController:nav animated:YES completion:nil];
}

-(void)setPromptedType:(NSString *)promptedType{
    _promptedType=promptedType;
    if ([promptedType isEqualToString:@"点援"]) {
        self.mainPromptedLabel.text=@"点援成功";
        self.promptedLabel.text=@"注意：我们在指派过程中将优先考虑您选择的律师，如该律师因为办案过多等原因无法给您提供援助，我们将给您指派其他律师，敬请谅解";
    }
    
}



-(UIButton *)btn{
    if (!_btn) {
        _btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        _btn.backgroundColor=[UIColor colorWithHex:0xcb414a andAlpha:1.0];
        [_btn setTitle:@"返回首页" forState:UIControlStateNormal];
        [_btn setTintColor:[UIColor whiteColor]];
        _btn.layer.cornerRadius=5;
        [_btn addTarget:self  action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}



-(UILabel *)mainPromptedLabel{
    if (!_mainPromptedLabel) {
        _mainPromptedLabel=[[UILabel alloc] init];
        _mainPromptedLabel.text=@"您在线申请的法律援助案件已经提交成功";
        _mainPromptedLabel.numberOfLines=0;
        _mainPromptedLabel.font=[UIFont systemFontOfSize:18];
        _mainPromptedLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _mainPromptedLabel;
}


-(UILabel *)promptedLabel{
    if (!_promptedLabel) {
        _promptedLabel=[[UILabel alloc] init];
        _promptedLabel.text=@"法律援助中心将在三个工作日内进行审核，请耐心等待。审核结果您可以在已申请案件界面中查询。";
        _promptedLabel.numberOfLines=0;
        _promptedLabel.font=[UIFont systemFontOfSize:14];
        _promptedLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _promptedLabel;
}


-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel=[[UILabel alloc] init];
        _titleLabel.text=@"提交成功";
        _titleLabel.font=[UIFont systemFontOfSize:18];
        _titleLabel.textAlignment=NSTextAlignmentCenter;
        _titleLabel.textColor=[UIColor whiteColor];
    }
    return _titleLabel;
}

-(UIView *)titleView{
    if (!_titleView) {
        _titleView=[[UIView alloc] init];
        _titleView.backgroundColor=[UIColor colorWithHex:0xcb414a andAlpha:1.0];
        [_titleView addSubview:self.titleLabel];
    }
    return _titleView;
}

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"success"]];
        
    }
    return _imageView;
}

@end
