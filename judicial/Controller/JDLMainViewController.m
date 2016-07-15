//
//  JDLMainViewController.m
//  judicial
//
//  Created by zjsos on 16/6/5.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import "JDLMainViewController.h"
#import "JDLMainRollView.h"
#import "JDLMainModuleView.h"
#import "JDLRecipientTableViewController.h"
#import "JDLAdviceViewController.h"
#import "JDLCaseTableViewController.h"
#import "JDLChoosePictureCollectionViewController.h"
#import "JDLChoosePictureLayout.h"
#import "JDLTools.h"
#import "config.h"
#import "MBProgressHUD+MJ.h"
#import "UIColor+Art.h"
#import "JDLAssistanceLawyersTableViewController.h"
#import "JDLLoginViewController.h"
#import "JDLPromptedViewController.h"
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequest.h"
#import "JDLConversion.h"
#import "JDLHelppageViewController.h"
#import "JDLCaseViewController.h"
#import "JDLRequestString.h"
#import "Scan_VC.h"
#import "JDLPictrue.h"
#import "MenuView.h"
#import "LeftMenuViewDemo.h"
#import "JDLHistoryCaseTableViewController.h"
#import "JDLUserInfoTableViewController.h"
#import "JDLStatisticalNetWordRequest.h"
@interface JDLMainViewController ()<UIAlertViewDelegate,HomeMenuViewDelegate>

//@property (nonatomic,strong)JDLMainRollView *rollView;
//@property (nonatomic,strong)UIPageControl *pageControl;

//主模块
@property (nonatomic,strong)JDLMainModuleView *moduleView;

//横幅
@property (nonatomic,strong)UIImageView *bannerImageView;

//用户登录按钮
@property (nonatomic,strong)UIButton *userBtn;

//自动更新下载地址
@property (nonatomic,strong)NSString *updateUrl;

//用户信息
@property (nonatomic,strong)NSDictionary *dictUserInfo;

//版权
@property (nonatomic,strong)UILabel *copyrightLabel;

//左侧菜单
@property (nonatomic ,strong)MenuView      *menu;
@property (nonatomic,strong)LeftMenuViewDemo *menuVC;

@end

@implementation JDLMainViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    //设置头部显示
    [self setheadView];
    //添加元素
    [self setAllElement];
    //网络请求
    [self networkrRequest];
}



-(void)networkrRequest{
    //自动更新
    [self showMessage];
    //获取用户信息
    [self getUserInfo:[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]];
    //打开统计
    [JDLStatisticalNetWordRequest submitUserinfo:nil andOperAtion:@"open"];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(click:) name:@"mianClickImageView" object:nil];
}

-(void)viewDidDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"mianClickImageView" object:nil];
}

#pragma mark 模块点击

-(void)click:(NSNotification *)not{
    NSDictionary *dict=not.userInfo;
    NSNumber *tag=dict[@"tag"];
    switch ([tag intValue]) {
        case 0:
            NSLog(@"网上申请");
            [self goToJDLRecipientTableViewController];
            break;
        case 1:
            [JDLStatisticalNetWordRequest submitUserinfo:nil andOperAtion:@"consult"];
            [self goToAdviceViewController:CONSULTINGURL andTitle:@"法律咨询"];
            NSLog(@"法律咨询");
            break;
        case 2:
            NSLog(@"点援");
            [self goToJDLChoosePictureViewController];
            break;
        case 3:
            //办案助手
            [JDLStatisticalNetWordRequest submitUserinfo:nil andOperAtion:@"handle"];
            [self goToAdviceViewController:BANANZHUSHOU andTitle:nil];
            break;
        default:
            [self goToHelp];
            NSLog(@"材料上传");
            break;
    }
}

#pragma mark 页面跳转

-(void)goToHelp{
    JDLHelppageViewController *helpVc=[[JDLHelppageViewController alloc] init];
    helpVc.title=@"使用须知";
    helpVc.docmentName=@"helppage.docx";
    [self.navigationController pushViewController:helpVc animated:YES];
}

-(void)goToJDLChoosePictureViewController{
    JDLAssistanceLawyersTableViewController *assistanceVC=[[JDLAssistanceLawyersTableViewController alloc] init];
    assistanceVC.title=@"点援律师列表";
    assistanceVC.assistanceCase=nil;
    [self.navigationController pushViewController:assistanceVC animated:YES];
}

-(void)goToJDLRecipientTableViewController{
    if (self.dictUserInfo!=nil) {
        JDLCaseTableViewController *caseTableViewController=[[JDLCaseTableViewController alloc] init];
        caseTableViewController.title=@"在线申请";
        NSLog(@"dict=%@",self.dictUserInfo);
        caseTableViewController.userInfo=self.dictUserInfo;
        [self.navigationController pushViewController:caseTableViewController animated:YES];
    }
    else{
        [MBProgressHUD showError:@"当前没有帐号登录" toView:self.view];
    }
}

-(void)goToAdviceViewController:(NSString *)openURL andTitle:(NSString *)title{
    JDLAdviceViewController *adviceViewController=[[JDLAdviceViewController alloc] init];
    if (title!=nil) {
        adviceViewController.title=title;
    }
    adviceViewController.postURL=openURL;
    [self.navigationController pushViewController:adviceViewController animated:YES];
}

#pragma mark 头部按钮点击事件
//打开用户登录或者打开左侧菜单
-(void)clickUser:(UIButton *)btn{
    if (self.dictUserInfo==nil) {
        JDLLoginViewController *loginVC=[[JDLLoginViewController alloc] init];
        loginVC.title=@"用户登录";
        loginVC.loginSuccess=^(NSDictionary *userDict){
            self.dictUserInfo=userDict;
            [self setMenuUserInfo];
            [MBProgressHUD showSuccess:@"登录成功" toView:self.view];
        };
        [self.navigationController pushViewController:loginVC animated:YES];
    }
    else{
        [self.menu show];
    }
}
//打开二维码
-(void)openCode:(UIButton *)item{
    Scan_VC *svc=[[Scan_VC  alloc] init];
    [self.navigationController pushViewController:svc animated:YES];
}
#pragma mark 页面布局

-(void)viewDidLayoutSubviews{
    //计算比例
    CGFloat proportion=self.view.frame.size.height/480;
    //根据比例计算出
    int y=self.topLayoutGuide.length,width=self.view.frame.size.width,moduleViewWidth=217*proportion,moduleViewHeight=239 *proportion;
    CGFloat rollViewProportion=self.view.frame.size.width/320;
    self.bannerImageView.frame=CGRectMake(0, y, width, 150*rollViewProportion);
    //self.rollView.frame=CGRectMake(0, y, width, 150*rollViewProportion);
    y+=self.bannerImageView.frame.size.height ;
    //self.pageControl.frame=CGRectMake(0, y-60,width, 40);
    y+=(self.view.frame.size.height-y-moduleViewHeight)/2 ;
    self.moduleView.frame=CGRectMake((width - moduleViewWidth )/2,y, moduleViewWidth, moduleViewHeight);
    self.copyrightLabel.frame=CGRectMake(0, self.view.frame.size.height - 25 , self.view.frame.size.width, 20);
}

-(void)setheadView{
    self.view.backgroundColor=[UIColor whiteColor];
    UIBarButtonItem *btnItem=[[UIBarButtonItem alloc] initWithCustomView:self.userBtn];
    self.navigationItem.leftBarButtonItem=btnItem;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    
    UIButton *codeBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [codeBtn setImage:[UIImage imageNamed:@"code"] forState:UIControlStateNormal];
    [codeBtn addTarget:self action:@selector(openCode:) forControlEvents:UIControlEventTouchUpInside];
    codeBtn.frame=CGRectMake(0, 0, 25, 25);
    
    UIBarButtonItem *codeItem=[[UIBarButtonItem alloc] initWithCustomView:codeBtn ];
    self.navigationItem.rightBarButtonItem=codeItem;
}

-(void)setAllElement{
    
    self.title=@"温州市法律援助";
    [self.view addSubview:self.bannerImageView];
    //[self.view addSubview:self.rollView];
    //[self.view addSubview:self.pageControl];
    [self.view addSubview:self.moduleView];
    [self.view addSubview:self.copyrightLabel];
    //设置左侧菜单
    self.menuVC = [[LeftMenuViewDemo alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width * 0.8, [[UIScreen mainScreen] bounds].size.height)];
    self.menuVC.customDelegate = self;
    
    MenuView *menu = [MenuView MenuViewWithDependencyView:self.view MenuView:self.menuVC isShowCoverView:YES];
    self.menu = menu;
    
}

#pragma mark 左侧菜单点击事件

-(void)LeftMenuViewClick:(NSInteger)tag{
    [self.menu hidenWithAnimation];
    if (tag==0) {
        JDLHistoryCaseTableViewController *historyCase=[[JDLHistoryCaseTableViewController alloc] init];
        historyCase.card=self.dictUserInfo[@"idnum"];
        historyCase.title=@"已申请案件";
        [self.navigationController pushViewController:historyCase animated:YES];
    }
    else if(tag==1){
        JDLUserInfoTableViewController *userInfoVC=[[JDLUserInfoTableViewController alloc] init];
        userInfoVC.userInfo=self.dictUserInfo;
        userInfoVC.title=@"用户信息";
        [self.navigationController pushViewController:userInfoVC animated:YES];
    }
    else if(tag==99 ){
        JDLUserInfoTableViewController *userInfoVC=[[JDLUserInfoTableViewController alloc] init];
        userInfoVC.userInfo=self.dictUserInfo;
        userInfoVC.title=@"用户信息";
        [self.navigationController pushViewController:userInfoVC animated:YES];
    }
    else if(tag==88){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提醒" message:@"确定退出登录？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.dictUserInfo=nil;
            self.menu.isPanOff=NO;
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

-(void)setMenuUserInfo{
    self.menu.isPanOff=YES;
    [self.menuVC setUserName:self.dictUserInfo[@"username"]];
}

#pragma mark 自动更新
-(void)showMessage//得到新版本号 显示提示框
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        NSURL *url=[NSURL URLWithString:UPDATEURL];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            NSString *jsonResponseString;
            ASIHTTPRequest *versionRequest = [ASIHTTPRequest requestWithURL:url];
            [versionRequest startSynchronous];
            [versionRequest setResponseEncoding:NSUTF8StringEncoding];
            NSError *error = [versionRequest error];
            if (!error) {
                //NSLog(@"[versionRequest responseString]=%@",[versionRequest responseString]);
                jsonResponseString = [versionRequest responseString];
            }
            if (jsonResponseString) {
                NSDictionary *loginAuthenticationResponse= [NSJSONSerialization JSONObjectWithData:[jsonResponseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self updateInformation:loginAuthenticationResponse];
                });
            }
    }
    });
}
-(void)updateInformation:(NSDictionary *)loginAuthenticationResponse{
    NSString *newversion=[loginAuthenticationResponse objectForKey:@"version"];
    self.updateUrl=[loginAuthenticationResponse objectForKey:@"updateurl"];
    
    NSString *update= [loginAuthenticationResponse objectForKey:@"update"];
    
    ///获取本地version
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *nowversion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSLog(@"nowversion=%@",nowversion);
    if (![nowversion isEqualToString:newversion] && newversion !=nil) {
        UIAlertView *helloWorldAlert = [[UIAlertView alloc] initWithTitle:(@"发现新版本！") message:update delegate:self cancelButtonTitle:@"取消"otherButtonTitles:@"立即更新", nil];
        [helloWorldAlert show];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)
    {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:self.updateUrl]];
    }
}
#pragma mark 获取用户信息
-(void)getUserInfo:(NSString *)token{
    ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@getUserInfo.do?token=%@",CONFIG_XMLURL,token]]];
    [request setRequestMethod:@"get"];
    __weak ASIFormDataRequest *requst1=request;
    [request setCompletionBlock:^{
        NSDictionary *dict=[JDLConversion jsonToid:[requst1 responseString]];
        if ([dict[@"result"] isEqualToString:@"0"]) {
            self.dictUserInfo=dict;
            [JDLStatisticalNetWordRequest submitUserinfo:dict andOperAtion:@"login"];
            [self setMenuUserInfo];
        }
    }];
    [request startAsynchronous];
}



#pragma mark 懒加载
//用户按钮
-(UIButton *)userBtn{
    if (!_userBtn) {
        _userBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_userBtn setImage:[UIImage imageNamed:@"head"] forState:UIControlStateNormal];
        _userBtn.frame=CGRectMake(0, 0, 30 , 30);
        [_userBtn addTarget:self action:@selector(clickUser:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _userBtn;
}
//模块视图 中间五个模块的视图
-(JDLMainModuleView *)moduleView{
    if (!_moduleView) {
        _moduleView=[[JDLMainModuleView alloc] init];
    }
    return _moduleView;
}



-(UIImageView *)bannerImageView{
    if (!_bannerImageView) {
        _bannerImageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"banner"]];
    }
    return _bannerImageView;
}

-(UILabel *)copyrightLabel{
    if (!_copyrightLabel) {
        _copyrightLabel=[[UILabel alloc] init];
        _copyrightLabel.text=@"©2016 温州市司法局";
        _copyrightLabel.font=[UIFont systemFontOfSize:12];
        _copyrightLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _copyrightLabel;
}

//-(JDLMainRollView *)rollView{
//    if (!_rollView) {
//        NSString *path=[[NSBundle mainBundle] pathForResource:@"banner" ofType:@"png"];
//        JDLPictrue *pictrue=[JDLPictrue initWithThumbnailPath:path andPicturnPath:path andType:@"首页1"];
//        NSString *path1=[[NSBundle mainBundle] pathForResource:@"banner1" ofType:@"png"];
//        JDLPictrue *pictrue1=[JDLPictrue initWithThumbnailPath:path1 andPicturnPath:path1 andType:@"首页2"];
//        pictrue1.openURL=@"http://mp.weixin.qq.com/s?__biz=MzIxMjEwNDY0MA==&mid=2661452873&idx=1&sn=30825e0ff0d17f6c9791c22a3b85481c&scene=0#wechat_redirect";
//        _rollView=[[JDLMainRollView alloc] initWithImages:nil];
//        _rollView.pageControl=self.pageControl;
//        _rollView.contentMode=UIViewContentModeScaleAspectFill;
//        _rollView.crtPicture=^(NSInteger currentIndex ){
//            
//        };
//        __weak JDLMainViewController *mainVC=self;
//        _rollView.clickPicture=^(JDLMainRollView * rollView, JDLPictrue *pictrue ,NSInteger currentIndex){
//            NSLog(@"prcture=%@",pictrue.type);
//            if (currentIndex==1) {
//                [mainVC goToAdviceViewController:pictrue.openURL andTitle:nil];
//            }
//        };
//        [_rollView setImages:@[pictrue,pictrue1] andIndex:0];
//        //_rollView.backgroundColor=[UIColor grayColor];
//    }
//    return _rollView;
//}

//-(UIPageControl *)pageControl{
//    if (!_pageControl) {
//        _pageControl=[[UIPageControl alloc] init];
//        _pageControl.userInteractionEnabled=NO;
//    }
//    return _pageControl;
//}

@end
