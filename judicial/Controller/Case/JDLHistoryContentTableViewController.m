//
//  JDLHistoryContentTableViewController.m
//  judicial
//
//  Created by zjsos on 16/7/2.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import "JDLHistoryContentTableViewController.h"
#import "JDLCase.h"
#import "JDLRegCell.h"
#import "JDLTools.h"
#import "JDLField.h"
#import "JDLCaseTableViewCell.h"
@interface JDLHistoryContentTableViewController ()

@property (nonatomic,strong)NSMutableArray * showArr;
@property (nonatomic,strong)NSArray *allRegCells;
@end

@implementation JDLHistoryContentTableViewController

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


-(void)setHistortCase:(JDLCase *)histortCase{
    _histortCase=histortCase;
    self.showArr=[histortCase histortCaseContent];
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
