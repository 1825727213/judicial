//
//  JDLLoginViewController.m
//  judicial
//
//  Created by zjsos on 16/6/29.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import "JDLLoginViewController.h"
#import "UIColor+Art.h"
#import "ASIHTTPRequest.h"
#import "config.h"
#import "JDLConversion.h"
#import "JDLAdviceViewController.h"
#import "MBProgressHUD+MJ.h"
#import "ASIFormDataRequest.h"
@interface JDLLoginViewController ()<UITextFieldDelegate,ASIHTTPRequestDelegate>

/**
 *  用户框
 */
@property (nonatomic,strong)UITextField *userNameTextField;
@property (nonatomic,strong)UIView *userNameLineView;
/**
 *  密码框
 */
@property (nonatomic,strong)UITextField *passwrodTextField;
@property (nonatomic,strong)UIView *passwordLineView;
/**
 *  头部图片
 */
@property (nonatomic,strong)UIImageView *bannerImageView;
/**
 *  记住密码
 */
@property (nonatomic,strong)UIButton *keepBtn;

/**
 *  自动登录提醒
 */
@property (nonatomic,strong)UILabel *remindLabel;
/**
 *  登录按钮
 */
@property (nonatomic,strong)UIButton *loginBtn;
/**
 *  注册按钮
 */
@property (nonatomic,strong)UIButton *registerBtn;


/**
 *  忘记密码按钮
 */
@property (nonatomic,strong)UIButton *forgetBtn;


@property (nonatomic,strong)UITextField *selectTextFiled;

@end

@implementation JDLLoginViewController

-(instancetype)init{
    self=[super init];
    if (self) {
        self.view.backgroundColor=[UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.bannerImageView];
    [self.view addSubview:self.userNameTextField];
    [self.view addSubview:self.passwrodTextField];
    [self.view addSubview:self.keepBtn];
    [self.view addSubview:self.remindLabel];
    [self.view addSubview:self.loginBtn];
    [self.view addSubview:self.registerBtn];
    [self.view addSubview:self.forgetBtn];
    [self.view addSubview:self.userNameLineView];
    [self.view addSubview:self.passwordLineView];
    [self setupNotification];
}



-(void)viewWillDisappear:(BOOL)animated{
   
    [self removeNotification];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.userNameTextField resignFirstResponder];
    [self.passwrodTextField resignFirstResponder];
}

-(void)viewDidLayoutSubviews{
    CGFloat y=20,width=self.view.frame.size.width;
    self.bannerImageView.frame=CGRectMake(0, y, width,  300  );
    self.forgetBtn.frame=CGRectMake(width - 30 -100, 300 , 100, 30);
    y+=300;
    self.userNameTextField.frame=CGRectMake(20, y+=20 , width-40, 30);
    self.userNameLineView.frame=CGRectMake(20, y+=30 , width-40, 1);
    self.passwrodTextField.frame=CGRectMake(20, y+=10 , (width-40 )*0.6, 30);
    self.passwordLineView.frame=CGRectMake(20, y+=30 , (width-40 )*0.6, 1);
    self.keepBtn.frame=CGRectMake((width-40 )*0.6+10+20 , y-20 , 20,20);
    self.remindLabel.frame=CGRectMake((width-40 )*0.6+10+20+20+5 , y-20 , (width-40 )-((width-40 )*0.6+10+20+20+5),20);
    
    self.loginBtn.frame=CGRectMake(20, y+=30 , (width-40 )*0.7, 40);
    self.registerBtn.frame=CGRectMake((width-40 )*0.7 +30 , y , width - (width-40 )*0.7 -30-20, 40);
}


-(void)clickLogin:(UIButton *)btn{
    [MBProgressHUD showMessage:@"加载中..." toView:self.view];
    NSString *postURL=[NSString stringWithFormat:@"%@idValidation.do?userName=%@&PassWord=%@",CONFIG_XMLURL,self.userNameTextField.text,self.passwrodTextField.text];
    //NSLog(@"%@",postURL);
    ASIHTTPRequest *request =[ASIHTTPRequest requestWithURL:[NSURL URLWithString:postURL]];
    request.delegate=self;
    [request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request{
    NSDictionary *dict= [JDLConversion jsonToid:[request responseString]];
    if (![dict[@"result"] isEqualToString:@"0"]) {
        [MBProgressHUD showError:dict[@"errmsg"] toView:self.view];
    }
    else{
        NSLog(@"dict=%@",dict);
        if (self.keepBtn.backgroundColor==[UIColor redColor]) {
            [[NSUserDefaults standardUserDefaults] setObject:self.userNameTextField.text forKey:@"userName"];
            [[NSUserDefaults standardUserDefaults] setObject:self.passwrodTextField.text forKey:@"PassWord"];
            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"keep"];
        }
        else{
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"userName"];
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"PassWord"];
            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"keep"];
        }
        [[NSUserDefaults standardUserDefaults] setObject:[dict objectForKey:@"token"] forKey:@"token"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self getUserInfo:[dict objectForKey:@"token"]];
    }
    
}

-(void)getUserInfo:(NSString *)token{
    ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@getUserInfo.do?token=%@",CONFIG_XMLURL,token]]];
    [request setRequestMethod:@"get"];
    __weak ASIFormDataRequest *requst1=request;
    [request setCompletionBlock:^{
        NSDictionary *dict=[JDLConversion jsonToid:[requst1 responseString]];
        if ([dict[@"result"] isEqualToString:@"0"]) {
            [self.navigationController popViewControllerAnimated:YES];
            NSLog(@"dict=%@",dict);
            self.loginSuccess(dict);
        }
        else{
            [MBProgressHUD showError:@"登录失败!" toView:self.view];
        }
    }];
    [request setFailedBlock:^{
        [MBProgressHUD showError:@"网络失败!" toView:self.view];
    }];
    [request startAsynchronous];
}



-(void)requestFailed:(ASIHTTPRequest *)request{
   [MBProgressHUD showError:@"网络失败!" toView:self.view];
}

/**
 *  记住密码
 *
 *  @param btn <#btn description#>
 */
-(void)changeKeepBtn:(UIButton *)btn{
    
    if (btn.backgroundColor ==[UIColor whiteColor]) {
        btn.backgroundColor=[UIColor redColor];
    }
    else{
        btn.backgroundColor=[UIColor whiteColor];
    }
}

/**
 *  注册
 *
 *  @param btn <#btn description#>
 */
-(void)goTOregister:(UIButton *)btn{
    JDLAdviceViewController *adviceViewController=[[JDLAdviceViewController alloc] init];
    adviceViewController.postURL=REGISTEREDURL;
    [self.navigationController pushViewController:adviceViewController animated:YES];
    //[self presentViewController:adviceViewController animated:YES completion:nil];
}


#pragma  mark textfieldDelegate代理

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.selectTextFiled=textField;
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}




#pragma mark 通知及通知实现

-(void)setupNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openKeyboard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeKeyboard:) name:UIKeyboardWillHideNotification object:nil];
}
-(void)removeNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


-(void)openKeyboard:(NSNotification *)notification
{
    CGRect frame=[[notification.userInfo objectForKey:@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    CGRect textFieldFrame=self.selectTextFiled.frame;
    //NSLog(@"notification=%@",notification);
    NSTimeInterval duration=[[notification.userInfo objectForKey:@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
    UIViewAnimationOptions option=[[notification.userInfo objectForKey:@"UIKeyboardAnimationCurveUserInfoKey"] intValue];
    if (textFieldFrame.origin.y > frame.origin.y) {
        [UIView animateWithDuration:duration delay:0 options:option animations:^{
            self.view.transform=CGAffineTransformMakeTranslation(0, -(textFieldFrame.origin.y-frame.origin.y+textFieldFrame.size.height));
        } completion:nil];
    }
}
-(void)closeKeyboard:(NSNotification *)notification
{
    [UIView animateWithDuration:0.25 delay:0 options:7 animations:^{
        self.view.transform=CGAffineTransformIdentity;
    } completion:nil];
    self.selectTextFiled=nil;
}

-(UIButton *)registerBtn{
    if (!_registerBtn) {
        _registerBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
        _registerBtn.backgroundColor=[UIColor blackColor];
        [_registerBtn setTintColor:[UIColor whiteColor]];
        [_registerBtn addTarget:self action:@selector(goTOregister:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerBtn;
}

-(UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        _loginBtn.backgroundColor=[UIColor redColor];
        [_loginBtn setTintColor:[UIColor whiteColor]];
        [_loginBtn addTarget:self action:@selector(clickLogin:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

-(UILabel *)remindLabel{
    if (!_remindLabel) {
        _remindLabel=[[UILabel alloc] init];
        _remindLabel.text=@"记住密码";
        _remindLabel.font=[UIFont systemFontOfSize:14];
    }
    return _remindLabel;
}

-(UIButton *)keepBtn{
    if (!_keepBtn) {
        _keepBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        _keepBtn.layer.borderWidth=1;
        _keepBtn.layer.cornerRadius=5;
        _keepBtn.layer.borderColor=[UIColor colorWithHex:0xb7b4b4 andAlpha:1.0].CGColor;
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"keep"] isEqualToString:@"1"]) {
            _keepBtn.backgroundColor=[UIColor redColor];
        }
        else{
            _keepBtn.backgroundColor=[UIColor whiteColor];
        }
        
        [_keepBtn addTarget:self  action:@selector(changeKeepBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _keepBtn;
}
-(UIView *)passwordLineView{
    if (!_passwordLineView) {
        _passwordLineView=[[UIView alloc] init];
        _passwordLineView.backgroundColor=[UIColor colorWithHex:0xb7b4b4 andAlpha:1.0];
    }
    return _passwordLineView;
}

-(UIView *)userNameLineView{
    if (!_userNameLineView) {
        _userNameLineView=[[UIView alloc] init];
        _userNameLineView.backgroundColor=[UIColor colorWithHex:0xb7b4b4 andAlpha:1.0];
    }
    return _userNameLineView;
}

-(UIButton *)forgetBtn{
    if (!_forgetBtn) {
        _forgetBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
        _forgetBtn.font=[UIFont systemFontOfSize:14];
    }
    return _forgetBtn;
}

-(UIImageView *)bannerImageView{
    if (!_bannerImageView) {
        _bannerImageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_banner"]];
    }
    return _bannerImageView;
}


-(UITextField *)userNameTextField{
    if (!_userNameTextField) {
        _userNameTextField=[[UITextField alloc] init];
        _userNameTextField.borderStyle=UITextBorderStyleNone;
        _userNameTextField.placeholder=@"请输入用户名";
        _userNameTextField.text= [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
        _userNameTextField.delegate=self;
    }
    return _userNameTextField;
}

-(UITextField *)passwrodTextField{
    if (!_passwrodTextField) {
        _passwrodTextField=[[UITextField alloc] init];
        _passwrodTextField.borderStyle=UITextBorderStyleNone;
        _passwrodTextField.placeholder=@"请输入密码";
        _passwrodTextField.text= [[NSUserDefaults standardUserDefaults] objectForKey:@"PassWord"];
        _passwrodTextField.delegate=self;
        _passwrodTextField.secureTextEntry=YES;
    }
    return _passwrodTextField;
}

@end
