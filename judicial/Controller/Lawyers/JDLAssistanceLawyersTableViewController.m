//
//  JDLAssistanceLawyersTableViewController.m
//  judicial
//
//  Created by zjsos on 16/6/28.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import "JDLAssistanceLawyersTableViewController.h"
#import "JDLAssistanceLawyersTableViewCell.h"
#import "ASIFormDataRequest.h"
#import "JDLRequestString.h"
#import "config.h"
#import "JDLConversion.h"
#import "JDLAssistanceLawyer.h"
#import "JDLAssistanceLawyers.h"
#import "JDLLawyerContentTableViewController.h"
#import "JDLLoadView.h"
#import "MBProgressHUD+MJ.h"
#import "JDLCase.h"
#import "JDLDescribeView.h"
#import "JDLSearchTextField.h"
#import "UIColor+Art.h"
@interface JDLAssistanceLawyersTableViewController ()<UITextFieldDelegate>

@property (nonatomic,strong)NSMutableArray *lawyers;
@property (nonatomic,strong)JDLLoadView *jdloadView;

@property (nonatomic,strong)JDLDescribeView *describeView;
@property (nonatomic,strong)JDLSearchTextField *textField;
@property (nonatomic,strong)UIView *headerView;

@end



@implementation JDLAssistanceLawyersTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self.view addSubview:self.jdloadView];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    [self.tableView registerClass:[JDLAssistanceLawyersTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.tableHeaderView=self.headerView;
}

-(void)setAssistanceCase:(JDLCase *)assistanceCase{
    if (assistanceCase==nil) {
        [self postData:nil];
    }
    else{
        _assistanceCase=assistanceCase;
        [self postData:@{@"intBranchIndex":assistanceCase.branch_index}];
    }
}

-(void)postData:(NSDictionary  *)dict{
    
    [MBProgressHUD showMessage:@"提交受援人信息" toView:self.view];
    NSString *postUrl=[NSString stringWithFormat:@"%@GetLawyerInfoJson",CONFIG_SERVICEURL];
    ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:postUrl]];
    [request addPostValue:[JDLRequestString nilToString:dict[@"intBranchIndex"] andEmptyStringTo0:YES] forKey:@"intBranchIndex"];
    [request addPostValue:[JDLRequestString nilToString:dict[@"intLawyerIndex"] andEmptyStringTo0:YES]  forKey:@"intLawyerIndex"];
    [request addPostValue:[JDLRequestString nilToString:dict[@"strName"] andEmptyStringTo0:NO]  forKey:@"strName"];
    [request addPostValue:[JDLRequestString nilToString:dict[@"intCertifiedKind"] andEmptyStringTo0:YES]  forKey:@"intCertifiedKind"];
    [request addPostValue:[JDLRequestString nilToString:dict[@"strUnit"] andEmptyStringTo0:NO]  forKey:@"strUnit"];
    [request addPostValue:[JDLRequestString nilToString:dict[@"strSpecialty"] andEmptyStringTo0:NO]   forKey:@"strSpecialty"];
    __weak ASIFormDataRequest *requst1=request;
    
    
    [request setCompletionBlock:^{
        [self requestFinished:requst1];
        
    }];
    [request setFailedBlock:^{
        [self requestFailed:requst1];
    }];
    

    
    [request startAsynchronous];
    
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    [MBProgressHUD showSuccess:@"数据加载成功" toView:self.view];
    NSString *responseString = [JDLConversion SetLegaCaseApplyPersonParse:[request responseString]];
    NSArray *data= [JDLConversion jsonToid:responseString];
    JDLAssistanceLawyers *assistanceLay= [[JDLAssistanceLawyers alloc] initWidthArray:data];
    self.lawyers=[assistanceLay getLawyers];
    self.tableView.hidden=NO;
    [self.tableView reloadData];
}

-(void)requestFailed:(ASIHTTPRequest *)request{
    
    [MBProgressHUD showError:@"数据加载失败" toView:self.view];
    
    NSLog(@" error=%@",[request error].userInfo);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.lawyers.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JDLAssistanceLawyersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.tag=indexPath.row;
    cell.lawyer=self.lawyers[indexPath.row];
    
    return cell;
}


#pragma mark  textFieldDelegage
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if (self.assistanceCase.branch_index!=nil) {
        [self postData:@{@"intBranchIndex":self.assistanceCase.branch_index,@"strName":textField.text}];
    }
    else{
        [self postData:@{@"strName":textField.text}];
    }
    
    return YES;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JDLLawyerContentTableViewController *lawyerContent=[[JDLLawyerContentTableViewController alloc] init];
    lawyerContent.lawyer=self.lawyers[indexPath.row];
    lawyerContent.assistanceCase=self.assistanceCase;
    [self.navigationController pushViewController:lawyerContent animated:YES];
}

-(NSMutableArray *)lawyers{
    if (!_lawyers) {
        _lawyers=[NSMutableArray new];
    }
    return _lawyers;
}

-(JDLLoadView *)jdloadView{
    if (!_jdloadView) {
        _jdloadView=[[JDLLoadView alloc] initWithFrame:self.view.frame];
    }
    return _jdloadView;
}

-(JDLDescribeView *)describeView{
    if (!_describeView) {
        _describeView=[[JDLDescribeView alloc] init];
        _describeView.frame=CGRectMake(0, 0, self.view.frame.size.width, 50);
        [_describeView setDescribeText:@"本界面仅展示可选择点援的律师信息，选择律师必须在法律援助案件申请受理后方可操作。"];
    }
    return _describeView;
}

-(UIView *)headerView{
    if (!_headerView) {
        _headerView=[[UIView alloc] init];
        _headerView.frame=CGRectMake(0, 0, self.view.frame.size.width, 81);
        [_headerView addSubview:self.describeView];
        
        self.textField=[[JDLSearchTextField alloc] initWidthDelegate:self];
        //self.textField.text=@"张";
        [_headerView addSubview:self.textField];
        
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, self.describeView.frame.size.height+self.textField.frame.size.height+1, _headerView.frame.size.width, 1)];
        view.backgroundColor=[UIColor colorWithHex:0xcecece andAlpha:1.0];
        [_headerView addSubview:view];
        
        
    }
    return _headerView;
}



@end
