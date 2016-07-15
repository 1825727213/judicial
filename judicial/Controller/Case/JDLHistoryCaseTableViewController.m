//
//  JDLHistoryCaseTableViewController.m
//  judicial
//
//  Created by zjsos on 16/6/30.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import "JDLHistoryCaseTableViewController.h"
#import "JDLCase.h"
#import "MBProgressHUD+MJ.h"
#import "ASIHTTPRequest.h"
#import "JDLRequestString.h"
#import "config.h"
#import "JDLConversion.h"
#import "JDLAdviceViewController.h"
#import "JDLHistoryTableViewCell.h"
#import "NSString+JDLFrame.h"
#import "JDLHistoryContentTableViewController.h"
@interface JDLHistoryCaseTableViewController ()<ASIHTTPRequestDelegate>

@property (nonatomic,strong)NSMutableArray *cases;

@end

@implementation JDLHistoryCaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    [self.tableView registerClass:[JDLHistoryTableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.cases.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    JDLCase *newCase= self.cases[indexPath.row];
    CGFloat titleHeight=[newCase.case_reason getShowHeight:self.view.frame.size.width-40 font:[UIFont systemFontOfSize:14]];
    if (titleHeight<44) {
        titleHeight=44;
    }
    return  titleHeight + 10 +20+5;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JDLHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.onCase=self.cases[indexPath.row];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    JDLCase *ce=self.cases[indexPath.row];
    if (![ce.case_case_index isEqualToString:@"0"]) {
        JDLAdviceViewController *adviceViewController=[[JDLAdviceViewController alloc] init];
        adviceViewController.postURL=[NSString stringWithFormat:@"http://61.153.49.14:8110/SFMO/LA/CA/CAPersonApprove.aspx?CaseIndex=%@",ce.case_case_index];
        
        adviceViewController.assistanceCase=ce;;
        [self.navigationController pushViewController:adviceViewController animated:YES];
    }
//    else if(![ce.status isEqualToString:@"5"]){
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提醒" message:@"此条申请为非正常申请" preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//        [alertController addAction:cancelAction];
//        [self presentViewController:alertController animated:YES completion:nil];
//    }
    else{
        JDLHistoryContentTableViewController *historyContent=[[JDLHistoryContentTableViewController alloc] init];
        historyContent.histortCase=ce;
        [self. navigationController pushViewController:historyContent animated:YES];

    }
    
}


-(void)setCard:(NSString *)card{
    _card=card;
    [self postData:card];
}

-(void)postData:(NSString *)card{
    [MBProgressHUD showMessage:@"加载中..." toView:self.view];
    NSString *postStr= [JDLRequestString createGetApplyJson:card andIntCaseIndex:@""];
    ASIHTTPRequest *aRequest = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:postStr]];
    [aRequest startAsynchronous];
    [aRequest setDelegate:self];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
   
    NSString *responseString = [JDLConversion SetLegaCaseApplyPersonParse:[request responseString]];
    NSArray *data= [JDLConversion jsonToid:responseString];
    if (data!=nil) {
        [MBProgressHUD showSuccess:@"数据加载成功" toView:self.view];
        for (int i=0; i<data.count; i++) {
            [self.cases addObject:[JDLCase initWidthDict:data[i]]];
        }
        [self.tableView reloadData];
    }
    else{
        [MBProgressHUD showError:@"数据加载失败" toView:self.view];
    }
    
}

-(void)requestFailed:(ASIHTTPRequest *)request{
    [MBProgressHUD showError:@"数据加载失败" toView:self.view];
}

-(NSMutableArray *)cases{
    if (!_cases) {
        _cases=[NSMutableArray new];
    }
    return _cases;
}


@end
