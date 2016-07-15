//
//  JDLUserInfoTableViewController.m
//  judicial
//
//  Created by zjsos on 16/7/14.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import "JDLUserInfoTableViewController.h"
#import "JDLCase.h"
#import "JDLRegCell.h"
#import "JDLTools.h"
#import "JDLField.h"
#import "JDLConversion.h"
#import "JDLCaseTableViewCell.h"
@interface JDLUserInfoTableViewController ()

@property (nonatomic,strong)NSMutableArray * showArr;
@property (nonatomic,strong)NSArray *allRegCells;

@end

@implementation JDLUserInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [JDLRegCell regCell:self.tableView Class:self.allRegCells];
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView setTableFooterView:v];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    self.title=@"案件信息";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.showArr.count;
}


-(void)setUserInfo:(NSDictionary *)userInfo{
    self.showArr=[NSMutableArray new];
    [self.showArr addObject:[JDLField initWithHistortCaseFieldNmae:@"姓名" fieldType:0 fieldContent:userInfo[@"username"]]];
    [self.showArr addObject:[JDLField initWithHistortCaseFieldNmae:@"登录名" fieldType:0 fieldContent:userInfo[@"loginname"]]];
    [self.showArr addObject:[JDLField initWithHistortCaseFieldNmae:@"手机号" fieldType:0 fieldContent:userInfo[@"mobile"]]];
    
    [self.showArr addObject:[JDLField initWithHistortCaseFieldNmae:@"身份证" fieldType:0 fieldContent:[JDLConversion encryptCard:userInfo[@"idnum"]]]];
    NSString *sex=[userInfo[@"sex"] isEqualToString:@"1"]?@"男" :@"女";
    [self.showArr addObject:[JDLField initWithHistortCaseFieldNmae:@"性别" fieldType:0 fieldContent:sex]];

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
        [_showArr addObject:[JDLField initWithFieldNmae:@"名字" fieldType:0 fieldContent:nil]];
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



@end
