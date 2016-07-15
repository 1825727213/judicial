//
//  JDLLawyerContentTableViewController.m
//  judicial
//
//  Created by zjsos on 16/6/28.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import "JDLLawyerContentTableViewController.h"
#import "JDLAssistanceLawyer.h"
#import "JDLCase.h"
#import "JDLRegCell.h"
#import "JDLTools.h"
#import "JDLField.h"
#import "JDLCaseTableViewCell.h"
#import "JDLCase.h"
#import "ASIFormDataRequest.h"
#import "JDLConversion.h"
#import "MBProgressHUD+MJ.h"
#import "JDLRequestString.h"
#import "JDLPromptedViewController.h"
#import "JDLStatisticalNetWordRequest.h"
@interface JDLLawyerContentTableViewController ()

@property (nonatomic,strong)NSMutableArray * showArr;
@property (nonatomic,strong)NSArray *allRegCells;
@property (nonatomic,strong)UIBarButtonItem *chooseItem;

@end

@implementation JDLLawyerContentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [JDLRegCell regCell:self.tableView Class:self.allRegCells];
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView setTableFooterView:v];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)chooseLawyer{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提醒" message:@"确定选择该律师援助?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [MBProgressHUD showMessage:@"提交数据中..." toView:self.view];
        NSString *postURL=[JDLRequestString createGetCaseLawyerJson:self.assistanceCase.case_case_index andIntLawyerIndex:self.lawyer.lawyer_index];
        ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:postURL]];
        [request setRequestMethod:@"get"];
        //__weak ASIFormDataRequest *requst1=request;
        [request setCompletionBlock:^{
            JDLPromptedViewController *pormptedVC=[[JDLPromptedViewController alloc] init];
            pormptedVC.promptedType=@"点援";
            [JDLStatisticalNetWordRequest submitUserinfo:nil andOperAtion:@"assistance"];
            [self.navigationController pushViewController:pormptedVC animated:YES];
            //[self presentViewController:pormptedVC animated:YES completion:nil];
        }];
        [request setFailedBlock:^{
            [MBProgressHUD showError:@"网络失败!" toView:self.view];
        }];
        [request startAsynchronous];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)setAssistanceCase:(JDLCase *)assistanceCase{
    _assistanceCase=assistanceCase;
    if (assistanceCase.case_index.length>0) {
        self.navigationItem.rightBarButtonItem=self.chooseItem;
    }
    else{
        self.navigationItem.rightBarButtonItem=nil;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.showArr.count;
}

-(void)setLawyer:(JDLAssistanceLawyer *)lawyer{
    _lawyer=lawyer;
    //self.title=[NSString stringWithFormat:@"%@的信息",lawyer.operator_name];
    self.title=@"律师信息";
    self.showArr=[NSMutableArray new];
    for (NSDictionary *dict in [lawyer showArray]) {
        JDLField *fieldOne=[JDLField initWithFieldNmae:dict[@"showName"] fieldType:0 fieldContent:dict[@"showValue"]];
        fieldOne.prompted=@"";
        [self.showArr addObject:fieldOne];
    }
    [self.tableView reloadData];
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JDLField *field=self.showArr[indexPath.row];
    JDLCaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%@Cell",field.identifier] forIndexPath:indexPath];
    cell.field=field;
    cell.tag=indexPath.row;
    return cell;
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    JDLField *field=self.showArr[indexPath.row];
    return field.fieldHeight;
}

-(NSMutableArray *)showArr{
    if (!_showArr) {
        _showArr=[NSMutableArray new];
        JDLField *fieldOne=[JDLField initWithFieldNmae:@"名字" fieldType:0 fieldContent:nil];
        JDLField *fieldTwo=[JDLField initWithFieldNmae:@"分数" fieldType:0 fieldContent:nil];
        [_showArr addObject:fieldOne];
        [_showArr addObject:fieldTwo];
    }
    return _showArr;
}

-(NSArray *)allRegCells{
    if(!_allRegCells)
    {
        _allRegCells=[JDLTools repeatFieldIdentifierArrayContent:self.showArr];
    }
    return _allRegCells;
}


-(UIBarButtonItem *)chooseItem{
    if (!_chooseItem) {
        _chooseItem=[[UIBarButtonItem alloc] initWithTitle:@"选择" style:UIBarButtonItemStylePlain target:self action:@selector(chooseLawyer)];
    }
    return _chooseItem;
}

@end
