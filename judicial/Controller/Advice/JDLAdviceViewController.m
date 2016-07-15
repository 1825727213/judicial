//
//  JDLAdviceViewController.m
//  judicial
//
//  Created by zjsos on 16/6/11.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import "JDLAdviceViewController.h"
#import "JDLAdviceWebView.h"
#import "UIColor+Art.h"
#import "MBProgressHUD+MJ.h"
#import "ASIFormDataRequest.h"
#import "JDLConversion.h"
#import "JDLAssistanceLawyersTableViewController.h"
#import "JDLCase.h"
#import "JDLRequestString.h"

@interface JDLAdviceViewController ()<UIWebViewDelegate>

@property (nonatomic,strong)JDLAdviceWebView *adiceWebView;

@property (nonatomic,strong)UIBarButtonItem *assistanceItem;

@end

@implementation JDLAdviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    [self.view addSubview:self.adiceWebView];
    
}


-(void)assistanceClick:(UIBarButtonItem *)item{
    JDLAssistanceLawyersTableViewController *assistancelVC=[[JDLAssistanceLawyersTableViewController alloc] init];
    assistancelVC.title=@"点援律师列表";
    assistancelVC.assistanceCase=self.assistanceCase;
    [self.navigationController pushViewController:assistancelVC animated:YES];
}

-(void)setAssistanceCase:(JDLCase *)assistanceCase{
    _assistanceCase=assistanceCase;
    [self getCaseInfo:assistanceCase.case_case_index];
}

-(void)getCaseInfo:(NSString *)case_case_index{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[JDLRequestString createGetCaseBaseInfoJson:case_case_index]]];
        [request setRequestMethod:@"get"];
        __weak ASIFormDataRequest *requst1=request;
        [request setCompletionBlock:^{
            NSString *data=[JDLConversion SetLegaCaseApplyPersonParse:[requst1 responseString]];
            if (data!=nil &&data.length>1) {
                NSArray *arr=[JDLConversion jsonToid:data];
                NSDictionary *dict=arr[0];
                NSString *chenck_status_name=dict[@"chenck_status_name"];
                NSString *lawyer_index=dict[@"lawyer_index"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.navigationItem.rightBarButtonItem=nil;
                    NSInteger flow_status=[dict[@"flow_status"] integerValue];
                    if ([chenck_status_name isEqualToString:@"初审通过"] && flow_status<7 &&  [lawyer_index isEqualToString:@"0"] ) {
                        self.navigationItem.rightBarButtonItem=self.assistanceItem;
                    }
                });
            }
            NSLog(@"%@",[JDLConversion SetLegaCaseApplyPersonParse:[requst1 responseString]]);
        }];
        
        [request startAsynchronous];
    });
}

-(void)viewDidLayoutSubviews{
    self.adiceWebView.frame=self.view.frame;
}

-(void)setPostURL:(NSString *)postURL{
    _postURL=postURL;
    [self.adiceWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:postURL]]];
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    
    [MBProgressHUD showMessage:@"加载中..." toView:self.view];
    NSLog(@"webViewDidStartLoad");
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *urlStr=[NSString stringWithFormat:@"%@",request.URL];
    
    if ([urlStr rangeOfString:@"cbfa4q"].location !=NSNotFound) {
        if(![[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"weixin://"]]){
           UIAlertView *alertView= [[UIAlertView alloc] initWithTitle:@"提示" message:@"您的手机未安装微信" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }
        return NO;
    }
    return YES;
    
   
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD showSuccess:@"加载成功" toView:self.view];
    if (self.title==nil || [self.title isEqualToString:@""]) {
        self.title= [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    }
    
    NSLog(@"webViewDidFinishLoad");
}

-(void)backClick:(UIButton  *)btn{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(JDLAdviceWebView *)adiceWebView{
    if (!_adiceWebView) {
        _adiceWebView=[[JDLAdviceWebView alloc] init];
        _adiceWebView.delegate=self;
    }
    return _adiceWebView;
}

-(UIBarButtonItem *)assistanceItem{
    if (!_assistanceItem) {
        self.assistanceItem=[[UIBarButtonItem alloc] initWithTitle:@"点援" style:UIBarButtonItemStylePlain target:self action:@selector(assistanceClick:)];
    }
    return _assistanceItem;
}


@end
