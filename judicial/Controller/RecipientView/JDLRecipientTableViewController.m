//
//  JDLPartiesTableViewController.m
//  judicial
//
//  Created by zjsos on 16/6/9.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import "JDLRecipientTableViewController.h"
#import "JDLRecipientControl.h"
#import "JDLRecipient.h"
#import "JDLRecipientTableViewCell.h"
#import "JDLRecipientInfoTableViewController.h"
#import "JDLGeneralButton.h"
#import "JDLField.h"
#import "JDLConversion.h"
@interface JDLRecipientTableViewController ()

@property (nonatomic,strong)NSMutableArray *allRecipients;
@property (nonatomic,strong)UIButton *addBtn;
@property (nonatomic,strong)NSMutableDictionary *allSelecteds;
@end

@implementation JDLRecipientTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     *  添加受援人按钮
     */
    //self.tableView.tableFooterView=self.addBtn;

    [self.tableView registerClass:[JDLRecipientTableViewCell class] forCellReuseIdentifier:@"cell"];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"新增" style:UIBarButtonItemStylePlain target:self action:@selector(addRecipient:)];
    
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"选择" style:UIBarButtonItemStylePlain target:self action:@selector(selectRecipient:)];
}

-(void)viewDidLayoutSubviews{
    //NSLog(@"frame=%@",NSStringFromCGRect(self.tableView.frame));
}
/**
 *  选择按钮点击事件，传递选择人员，并后退
 *
 *  @param item
 */
-(void)selectRecipient:(UIBarButtonItem *)item{
    self.selectedRecipient([JDLConversion arrToString:[self getAllSelecteds]] );
    [self.navigationController popViewControllerAnimated:YES];
}
/**
 *  获取全部选中的人员
 *
 *  @return 返回选中的人的名称
 */
-(NSArray *)getAllSelecteds{
    NSMutableArray *arr=[NSMutableArray new];
    for (NSString *key in self.allSelecteds) {
        if ([self.allSelecteds[key] boolValue]) {
            [arr addObject:key];
        }
    }
    return [arr copy];
}

-(void)addRecipient:(UIBarButtonItem *)btn{
    JDLRecipientInfoTableViewController *recipientInfo=[[JDLRecipientInfoTableViewController alloc] init];
    recipientInfo.title=@"新增受援人";
    recipientInfo.saveBtn=^(){
        self.allRecipients=[JDLRecipientControl  recipients];
        [self.tableView reloadData];
    };
    [self.navigationController pushViewController:recipientInfo animated:YES];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allRecipients.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JDLRecipientTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.recipient=self.allRecipients[indexPath.row];
    cell.tag=indexPath.row;
    cell.allSelectRecipients=[self.allSelecteds allKeys];
    cell.cellIndexPath=indexPath;
    cell.clickBtn=^(NSIndexPath *indexPath){
        [self changeCheck:indexPath];
    };
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self changeCheck:indexPath];
}

-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JDLRecipient *selectRecipient=self.allRecipients[indexPath.row];
    UITableViewRowAction *deleteRowAction=[UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [JDLRecipientControl deleteRecipient:self.allRecipients[indexPath.row]];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
    }];
    UITableViewRowAction    *editRowAction=[UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"编辑" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"编辑");
        JDLRecipientInfoTableViewController *recipientInfo=[[JDLRecipientInfoTableViewController alloc] init];
        recipientInfo.saveBtn=^(){
             [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        };
        recipientInfo.title=[NSString stringWithFormat:@"%@的信息",selectRecipient.name];
        recipientInfo.recipient=self.allRecipients[indexPath.row];
        [self.navigationController pushViewController:recipientInfo animated:YES];
        
    }];
    return @[deleteRowAction,editRowAction];
}

-(void)changeCheck:(NSIndexPath *)indexPath{
    JDLRecipient *selectRecipient=self.allRecipients[indexPath.row];
    //JDLRecipientTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    //[cell.btn setSelected:!cell.btn.selected];
    //[self.allSelecteds setObject:[NSNumber numberWithBool:cell.btn.selected]forKey:selectRecipient.name];
    //[self selectRecipient:nil];
    self.selectedRecipient(selectRecipient.name);
    [self.navigationController popViewControllerAnimated:YES];
}





#pragma mark 懒加载

-(void)setCaseRecipients:(NSArray *)caseRecipients{
    _caseRecipients=caseRecipients;
    for (NSString *name in caseRecipients) {
        if (![name isEqualToString:@""]) {
            [self.allSelecteds setObject:[NSNumber numberWithBool:YES] forKey:name];
        }
    }
}
-(void)setField:(JDLField *)field{
    _field=field;
    self.title=field.fieldNmae;
    self.caseRecipients=[field.fieldContent componentsSeparatedByString:@","]; 
}

-(NSMutableArray *)allRecipients{
    if (!_allRecipients) {
        _allRecipients=[JDLRecipientControl  recipients];
    }
    return _allRecipients;
}

-(NSMutableDictionary *)allSelecteds{
    if (!_allSelecteds) {
        _allSelecteds=[NSMutableDictionary new];
    }
    return _allSelecteds;
}

-(UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn=[JDLGeneralButton buttonWithType:UIButtonTypeRoundedRect];
        [_addBtn setTitle:@"新增受援人" forState:UIControlStateNormal];
        _addBtn.frame=CGRectMake(0, 0, self.tableView.frame.size.width-80, 50);
        [_addBtn addTarget:self action:@selector(addRecipient:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}

@end
