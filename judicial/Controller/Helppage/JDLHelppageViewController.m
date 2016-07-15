//
//  JDLHelppageViewController.m
//  judicial
//
//  Created by zjsos on 16/7/2.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import "JDLHelppageViewController.h"

@interface JDLHelppageViewController ()<UIWebViewDelegate>

@property (nonatomic,strong)UIWebView *webView;

@end

@implementation JDLHelppageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    [self.view addSubview:self.webView];
}

-(void)setDocmentName:(NSString *)docmentName{
    _docmentName=docmentName;
    NSString *path= [[NSBundle mainBundle] pathForResource:docmentName ofType:nil];
    //NSLog(@"path=%@",path);
    NSURL *url =[NSURL fileURLWithPath:path];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

-(UIWebView *)webView{
    if (!_webView) {
        _webView=[[UIWebView alloc] init];
        _webView.frame=self.view.frame;
        _webView.delegate=self;
        _webView.scalesPageToFit=YES;
        
    }
    return _webView;
}

@end
