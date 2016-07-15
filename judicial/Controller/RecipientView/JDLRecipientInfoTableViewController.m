//
//  JDLRecipientInfoTableViewController.m
//  judicial
//
//  Created by zjsos on 16/6/10.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import "JDLRecipientInfoTableViewController.h"
#import "JDLInfoTableViewCell.h"
#import "JDLField.h"
#import "JDLConversion.h"
#import "JDLRecipient.h"
#import "JDLTextViewController.h"
#import "JDLRecipientControl.h"
#import "JDLRegCell.h"
#import "config.h"
#import "JDLTools.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "JDLRequestString.h"
#import "JDLTextTableViewCell.h"
#import "SoapXmlParseHelper.h"
#import "JDLLawyerController.h"
#import "MBProgressHUD+MJ.h"
@interface JDLRecipientInfoTableViewController ()<ASIHTTPRequestDelegate>

@property (nonatomic,strong)NSMutableArray * allFields;
@property (nonatomic,strong)NSArray *allRegCells;

@end

@implementation JDLRecipientInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [JDLRegCell regCell:self.tableView Class:self.allRegCells];
    //[self.tableView registerClass:[JDLInfoTableViewCell class] forCellReuseIdentifier:@"cell"];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveRecipient:)];
    self.navigationItem.rightBarButtonItem = saveItem;
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView setTableFooterView:v];
}

/**
 *  新增受援人
 *
 *  @param item
 */
-(void)saveRecipient:(UIBarButtonItem *)item{
    
   NSDictionary *dict=[JDLField setAllFields:self.allFields];
    if (self.recipient!=nil) {
        [JDLRecipientControl updateRecipient:self.recipient.card newRecipient:dict];
        self.saveBtn();
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        [MBProgressHUD showMessage:@"数据提交中..." toView:self.view];
        NSString *postUrl=[NSString stringWithFormat:@"%@SetLegaCaseApplyPerson",CONFIG_SERVICEURL];
        ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:postUrl]];
        
        [request addPostValue:[NSNumber numberWithInteger:[[JDLLawyerController sharedSupport] getLawyerNameToBranchId:dict[@"center"]]] forKey:@"intBranchIndex"];
        [request addPostValue:dict[@"name"] forKey:@"strPersonName"];
        [request addPostValue:dict[@"card"] forKey:@"strIdNo"];
        [request addPostValue:dict[@"phone"] forKey:@"strLinkTel"];
        [request addPostValue:dict[@"address"] forKey:@"strAdress"];
        NSString *strSex=[dict[@"address"] isEqualToString:@"女"]?@"2":@"1";
        NSNumber *sex=[NSNumber numberWithInteger:[strSex integerValue]];
        [request addPostValue:sex forKey:@"intSex"];
        __weak ASIFormDataRequest *requst1=request;
        
        [request setCompletionBlock:^{
           [MBProgressHUD showSuccess:@"提交成功" toView:self.view];
            NSString *responseString = [requst1 responseString];
            NSString *caseid= [JDLConversion SetLegaCaseApplyPersonParse:responseString];
            NSMutableDictionary *dictNew=[NSMutableDictionary dictionaryWithDictionary:[JDLField setAllFields:self.allFields]];
            [dictNew setObject:caseid forKey:@"caseid"];
            [self dataDeal:[dictNew copy]];
        }];
        [request setFailedBlock:^{
            [MBProgressHUD showError:@"提交成功" toView:self.view];
            NSLog(@"失败");
            NSLog(@"asi error: %@",requst1.error.debugDescription);
        }];
        [request startAsynchronous];

    }
}

/**
 *  根据传入的recipient判断是更新还是新增
 *
 *  @param dict
 */
-(void)dataDeal:(NSDictionary *)dict{
    [JDLRecipientControl addRecipient:dict];
    self.saveBtn();
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];
    NSString *caseid= [JDLConversion SetLegaCaseApplyPersonParse:responseString];
    NSMutableDictionary *dictNew=[NSMutableDictionary dictionaryWithDictionary:[JDLField setAllFields:self.allFields]];
    [dictNew setObject:caseid forKey:@"caseid"];
    [self dataDeal:[dictNew copy]];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"error=%@",error.userInfo);
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allFields.count;
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    JDLField *field=self.allFields[indexPath.row];
    return field.fieldHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JDLField *field=self.allFields[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%@Cell",field.identifier] forIndexPath:indexPath];
    [JDLTools setValue:cell SelName:@"setField:" withObject:field];
    return cell;
}

//选中某一行时调用
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    JDLField *field= self.allFields[indexPath.row];
    if(field.fieldType==0){
        JDLTextViewController *textVc=[[JDLTextViewController alloc] init];
        textVc.field=field;
        textVc.returnText=^(JDLTextViewController *textView,NSString *text){
            field.fieldContent=text;
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        };
        [self.navigationController pushViewController:textVc animated:YES];
    }
    
}

-(void)setRecipient:(JDLRecipient *)recipient{
    _recipient=recipient;
    for (JDLField *field in self.allFields) {
        field.fieldContent=[JDLTools getValue:recipient SelName:field.fieldMark withObject:nil];
    }
    [self.tableView reloadData];
}

-(NSArray *)allRegCells{
    if(!_allRegCells)
    {
        _allRegCells=[JDLTools repeatFieldIdentifierArrayContent:self.allFields];
    }
    return _allRegCells;
}

-(NSMutableArray *)allFields{
    if (!_allFields) {
        _allFields=[NSMutableArray new];
        JDLField *fieldOne=[JDLField initWithFieldNmae:@"案件发生地" fieldType:2 fieldContent:@""];
        fieldOne.fieldMark=@"region";
        fieldOne.fieldRadioValue=@[@"市中心",@"地区"];
        JDLField *fieldTwo=[JDLField initWithFieldNmae:@"救援中心" fieldType:3 fieldContent:@"温州市法律援助中心"];
        fieldTwo.fieldMark=@"center";
        /**
         *  设置点击事件
         */
        fieldOne.clickMethods=^(NSString *value){
            JDLTextTableViewCell *cell=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
            if ([value isEqualToString:@"地区"]) {
                [cell.textFiled becomeFirstResponder];
            }
            else{
                cell.textFiled.text=@"温州市法律援助中心";
                fieldTwo.fieldContent=cell.textFiled.text;
                [cell.textFiled resignFirstResponder];
            }
        };
        JDLField *fieldThree=[JDLField initWithFieldNmae:@"姓名" fieldType:0 fieldContent:@""];
        fieldThree.fieldMark=@"name";
        JDLField *fieldFour=[JDLField initWithFieldNmae:@"性别" fieldType:2 fieldContent:@""];
        fieldFour.fieldMark=@"sex";
        fieldFour.fieldRadioValue=@[@"男",@"女"];
        JDLField *fieldFive=[JDLField initWithFieldNmae:@"身份证" fieldType:0 fieldContent:@""];
        fieldFive.fieldMark=@"card";
        JDLField *fieldSix=[JDLField initWithFieldNmae:@"联系电话" fieldType:0 fieldContent:@""];
        fieldSix.fieldMark=@"phone";
        JDLField *fieldSeven=[JDLField initWithFieldNmae:@"联系地址" fieldType:0 fieldContent:@""];
        fieldSeven.fieldMark=@"address";
        [_allFields addObject:fieldOne];
        [_allFields addObject:fieldTwo];
        [_allFields addObject:fieldThree];
        [_allFields addObject:fieldFour];
        [_allFields addObject:fieldFive];
        [_allFields addObject:fieldSix];
        [_allFields addObject:fieldSeven];
    }
    return _allFields;
}




@end
