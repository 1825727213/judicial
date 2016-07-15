//
//  JDLCaseTableViewController.m
//  judicial
//
//  Created by zjsos on 16/6/11.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import "JDLCaseTableViewController.h"
#import "JDLCaseTableViewCell.h"
#import "JDLLargeTextTableViewCell.h"
#import "JDLRegCell.h"
#import "JDLCase.h"
#import "JDLField.h"
#import "JDLTextViewController.h"
#import "JDLTools.h"
#import "JDLConversion.h"
#import "JDLRequestString.h"
#import "ASIHTTPRequest.h"
#import "config.h"
#import "ASIFormDataRequest.h"
#import "JDLPictrue.h"
#import "MBProgressHUD+MJ.h"
#import "JDLGeneralButton.h"
#import "JDLHistoryCaseTableViewController.h"
#import "JDLTextTableViewCell.h"
#import "JDLAttachmentViewController.h"
#import "JDLPromptedViewController.h"
#import "JDLLawyerController.h"
#import "JDLDescribeView.h"
@interface JDLCaseTableViewController ()<ASIHTTPRequestDelegate>


@property (nonatomic,strong)NSMutableDictionary *allSelecteds;
@property (nonatomic,strong)NSMutableArray *cases;
@property (nonatomic,strong)NSArray *allRegCells;
@property (nonatomic,strong)NSMutableArray *pictures;

@property (nonatomic,strong)NSDictionary  *postDict;

@property (nonatomic,assign)NSInteger postIndex;

@property (nonatomic,strong)UIButton  *submitCaseBtn;

@property (nonatomic,strong)JDLDescribeView *describeView;


@end

@implementation JDLCaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableHeaderView=self.describeView;
    self.view.backgroundColor=[UIColor whiteColor];
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView setTableFooterView:v];
    
    
    [JDLRegCell regCell:self.tableView Class:self.allRegCells];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"已申请案件" style:UIBarButtonItemStylePlain target:self action:@selector(goToHistoryCase)];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    self.tableView.tableFooterView=self.submitCaseBtn;

}

-(void)goToHistoryCase{
    JDLHistoryCaseTableViewController *historyCase=[[JDLHistoryCaseTableViewController alloc] init];
    historyCase.card=self.userInfo[@"idnum"];
    historyCase.title=@"已申请案件";
    [self.navigationController pushViewController:historyCase animated:YES];
}


/**
 *  设置政府服务网的用户信息
 *
 *  @param userInfo 用户信息
 */
-(void)setUserInfo:(NSDictionary *)userInfo{
    _userInfo=userInfo;
    NSLog(@"userInfo=%@",userInfo);
    for (JDLField *field in self.cases) {
        //name,card,,phone,address
        if ([field.fieldMark isEqualToString:@"name"]) {
            field.fieldContent=userInfo[@"username"];
        }
        else if ([field.fieldMark isEqualToString:@"card"]){
            field.fieldContent=userInfo[@"idnum"];
        }
        else if ([field.fieldMark isEqualToString:@"phone"]){
            field.fieldContent=userInfo[@"mobile"];
        }
        else if ([field.fieldMark isEqualToString:@"address"]){
            field.fieldContent=userInfo[@"homeaddress"];
        }
        else if ([field.fieldMark isEqualToString:@"sex"]){
            field.fieldContent=[userInfo[@"sex"] isEqualToString:@"1"]?@"男":@"女";
        }
    }
    [self.tableView reloadData];
}

#pragma mark 案件提交

-(void)submit:(UIButton *)item{
    NSMutableDictionary *dict=[NSMutableDictionary new];
    BOOL flog=YES;
    for (JDLField *filed in self.cases) {
        if (filed.fieldContent.length<1 && ![filed.fieldMark isEqualToString:@"address"]) {
            flog=NO;
        }
        else{
            [dict setObject:filed.fieldContent forKey:filed.fieldMark];
        }
    }
    if (flog) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提醒" message:@"案件提交需提交图片材料，上传过程中会产生流量信息" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self postRecipie:dict];
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提醒" message:@"你的信息没有填写完整" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }

}

/**
 *  提交受援信息
 *
 *  @param dict 页面上的全部内容
 */
-(void)postRecipie:(NSDictionary *)dict{
    [MBProgressHUD showMessage:@"提交受援人信息" toView:self.view];
    NSString *postUrl=[NSString stringWithFormat:@"%@SetLegaCaseApplyPerson",CONFIG_SERVICEURL];
    ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:postUrl]];
    NSInteger intBranchIndex=[[JDLLawyerController sharedSupport] getLawyerNameToBranchId:dict[@"center"]];
    [request addPostValue:[NSNumber numberWithInteger:intBranchIndex] forKey:@"intBranchIndex"];
    [request addPostValue:dict[@"name"] forKey:@"strPersonName"];
    [request addPostValue:dict[@"card"] forKey:@"strIdNo"];
    [request addPostValue:dict[@"phone"] forKey:@"strLinkTel"];
    [request addPostValue:dict[@"address"] forKey:@"strAdress"];
    NSString *strSex=[dict[@"address"] isEqualToString:@"女"]?@"2":@"1";
    NSNumber *sex=[NSNumber numberWithInteger:[strSex integerValue]];
    [request addPostValue:sex forKey:@"intSex"];
    __weak ASIFormDataRequest *requst1=request;
    //__weak NSDictionary *newDict=dict;
    
    [request setCompletionBlock:^{
        NSLog(@"受援人requst1=%@",[requst1 responseString]);
        NSString *responseString = [requst1 responseString];
        NSString *caseid= [JDLConversion SetLegaCaseApplyPersonParse:responseString];
        if (caseid.length>0) {
            [self postCase:dict andIntBranchIndex:intBranchIndex andCaseid:caseid];
        }
        else{
            [MBProgressHUD showError:@"受援人提交失败" toView:self.view];
        }
       
    }];
    [request setFailedBlock:^{
       [MBProgressHUD showError:@"受援人提交失败" toView:self.view];
    }];
    [request startAsynchronous];

}

/**
 *  提交案件信息
 *
 *  @param dict           页面上的全部内容
 *  @param intBranchIndex 选择的区域
 *  @param caseid         案件编号
 */
-(void)postCase:(NSDictionary *)dict andIntBranchIndex:(NSInteger )intBranchIndex andCaseid:(NSString *)caseid{
    NSLog(@"dict=%@",dict);
    [MBProgressHUD showMessage:@"提交案件信息" toView:self.view];
    NSString *postUrl=[NSString stringWithFormat:@"%@SetLegaCaseApplyInfo",CONFIG_SERVICEURL];
    ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:postUrl]];
    [request addPostValue:[NSNumber numberWithInteger:intBranchIndex] forKey:@"intBranchIndex"];
    [request addPostValue:caseid forKey:@"intCaseIndex"];
    
    [request addPostValue:dict[@"title"] forKey:@"strCaseReason"];
    [request addPostValue:dict[@"content"] forKey:@"strCaseTruth"];
    __weak ASIFormDataRequest *requst1=request;
    
    [request setCompletionBlock:^{
        NSLog(@"案件requst1=%@",[requst1 responseString]);
        self.postIndex=0;
        [MBProgressHUD showMessage:[NSString stringWithFormat:@"稍等，还剩下%lu张图片", (long)self.pictures.count-self.postIndex] toView:self.view];
        for (JDLPictrue * picture in self.pictures) {
            [self postPicture:picture andIntBranchIndex:intBranchIndex andCaseid:caseid];
        }
        
    }];
    [request setFailedBlock:^{
        [MBProgressHUD showError:@"案件提交失败" toView:self.view];
    }];
    [request startAsynchronous];
    
}

/**
 *  上传图片
 *
 *  @param picture        图片对象
 *  @param intBranchIndex 选择的区域
 *  @param caseid         案件编号
 */
-(void)postPicture:(JDLPictrue *)picture andIntBranchIndex:(NSInteger )intBranchIndex andCaseid:(NSString *)caseid{
    ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:POSTIMAGEURL]];
    [request setUploadProgressDelegate:self];
    [request addPostValue:picture.type forKey:@"DatumName"];
    [request addPostValue:[NSNumber numberWithInteger:intBranchIndex] forKey:@"intBranchIndex"];
    [request addPostValue:caseid forKey:@"intCaseIndex"];
    [request addPostValue:[picture.thumbnailPath lastPathComponent] forKey:@"strFileName"];
    [request addPostValue:@"31" forKey:@"intKind"];
    [request addFile:picture.thumbnailPath forKey:@"data"];
    
    __weak ASIFormDataRequest *requst1=request;
    [request setCompletionBlock:^{
        NSLog(@"图片requst1=%@",[requst1 responseString]);
        [self setHUD];
    }];
    [request setFailedBlock:^{
        
    }];
    [request startAsynchronous];
}

/**
 *  上传信息控制
 */
-(void)setHUD{
    self.postIndex++;
    if (self.postIndex<self.pictures.count) {
        [MBProgressHUD showMessage:[NSString stringWithFormat:@"稍等，还剩下%lu张图片",self.pictures.count-self.postIndex] toView:self.view];
    }
    else{
        NSMutableDictionary *dict=[NSMutableDictionary new];
        BOOL flog=YES;
        for (JDLField *filed in self.cases) {
            if (filed.fieldContent.length<1 && ![filed.fieldMark isEqualToString:@"address"]) {
                flog=NO;
            }
            else{
                [dict setObject:filed.fieldContent forKey:filed.fieldMark];
            }
        }
        JDLPromptedViewController *pormptedVC=[[JDLPromptedViewController alloc] init];
        pormptedVC.userInfo=dict;
        [self.navigationController pushViewController:pormptedVC animated:YES];
    }
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cases.count;
}


-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    JDLField *field=self.cases[indexPath.row];
    return field.fieldHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JDLField *field=self.cases[indexPath.row];
    JDLCaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%@Cell",field.identifier] forIndexPath:indexPath];
    cell.field=field;
    cell.tag=indexPath.row;
    return cell;
}

//选中某一行时调用
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    JDLField *field=self.cases[indexPath.row];
    
    if (field.fieldType==1){
        JDLAttachmentViewController *attachmentVC=[[JDLAttachmentViewController alloc] init];
        attachmentVC.BeforeArray=self.pictures;
        __weak NSMutableArray *newArr=self.pictures;
        attachmentVC.choosePic=^(NSArray *pictures){
            field.fieldContent=[NSString stringWithFormat:@"已选择%ld张图片",(unsigned long)pictures.count];
            [newArr removeAllObjects];
            [newArr addObjectsFromArray:pictures];
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        };
        [self.navigationController pushViewController:attachmentVC animated:YES];
    }
    else if (field.fieldType==0 ){
        JDLTextViewController *textViewController=[[JDLTextViewController alloc] init];
        
        textViewController.field=field;
        textViewController.returnText=^(JDLTextViewController*textView, NSString *text){
            field.fieldContent=text;
            textView.field=field;
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        };
        [self.navigationController pushViewController:textViewController animated:YES];
    }
    
}

#pragma mark 懒加载

-(UIButton *)submitCaseBtn{
    if (!_submitCaseBtn) {
        _submitCaseBtn=[JDLGeneralButton buttonWithType:UIButtonTypeRoundedRect];
        [_submitCaseBtn setTitle:@"提交" forState:UIControlStateNormal];
        _submitCaseBtn.frame=CGRectMake(0, 0, self.view.frame.size.width-80, 44);
        [_submitCaseBtn addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitCaseBtn;
}

-(JDLDescribeView *)describeView{
    if (!_describeView) {
        _describeView=[[JDLDescribeView alloc] init];
        _describeView.frame=CGRectMake(0, 0, self.view.frame.size.width, 100);
        [_describeView setDescribeText:@"在线申请法律援助前，请认真阅读首页的使用须知.通过本软件提交的法律援助申请,我们进行预审,预审通过后将会通知您携带相关资料到相关法律援助中心进行现场审核.填写内容和上传材料,请注意相关页面的提示,以保障您申请的成功率."];
    }
    return _describeView;
}

/**
 *  初始化案件内容
 *
 *  @return <#return value description#>
 */
-(NSMutableArray *)cases{
    if (!_cases) {
        _cases=[NSMutableArray new];
        
        [_cases addObject:[JDLField initWithCaseFieldNmae:@"姓名" fieldType:4 fieldContent:nil andFieldMark:@"name" andFieldRadioValue:nil]];
        [_cases addObject:[JDLField initWithCaseFieldNmae:@"性别" fieldType:4 fieldContent:nil andFieldMark:@"sex" andFieldRadioValue:nil]];
        [_cases addObject:[JDLField initWithCaseFieldNmae:@"身份证" fieldType:4 fieldContent:nil andFieldMark:@"card" andFieldRadioValue:nil]];
        [_cases addObject:[JDLField initWithCaseFieldNmae:@"联系电话" fieldType:4 fieldContent:nil andFieldMark:@"phone" andFieldRadioValue:nil]];
        [_cases addObject:[JDLField initWithCaseFieldNmae:@"联系地址" fieldType:0 fieldContent:nil andFieldMark:@"address" andFieldRadioValue:nil]];
        
        JDLField *fieldOne=[JDLField initWithCaseFieldNmae:@"案件发生地" fieldType:2 fieldContent:nil andFieldMark:@"region" andFieldRadioValue:@[@"市中心",@"地区"]];
        
        
        JDLField *fieldTwo=[JDLField initWithFieldNmae:@"援助中心" fieldType:3 fieldContent:@"温州市法律援助中心"];
        fieldTwo.fieldMark=@"center";
        
        fieldTwo.clickMethods=^(NSString *value){
            NSLog(@"value==%@",value);
            fieldOne.fieldContent=value;
            fieldOne.fieldRadioValue=@[@"市中心",value];
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:5 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        };
        
        //ndexPathForRow=援助中心在数组中的个数
        NSIndexPath *indexpath=[NSIndexPath indexPathForRow:6 inSection:0];
        
        __weak JDLField *fieldOne1=fieldOne;
        
        fieldOne.clickMethods=^(NSString *value){
            JDLTextTableViewCell *cell=[self.tableView cellForRowAtIndexPath:indexpath];
            if (![value isEqualToString:@"市中心"]) {
                [cell.textFiled becomeFirstResponder];
            }
            else{
                cell.textFiled.text=@"温州市法律援助中心";
                fieldOne1.fieldContent=@"市中心";
                fieldOne1.fieldRadioValue=@[@"市中心",@"地区"];
                [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:5 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                fieldTwo.fieldContent=cell.textFiled.text;
                [cell.textFiled resignFirstResponder];
            }
        };
        [_cases addObject:fieldOne];
        [_cases addObject:fieldTwo];
        
        [_cases addObject:[JDLField initWithCaseFieldNmae:@"案件标题" fieldType:0 fieldContent:nil andFieldMark:@"title" andFieldRadioValue:nil]];
       
        
        
        
        JDLField *fieldThere=[JDLField initWithFieldNmae:@"案件内容" fieldType:0 fieldContent:nil];
        fieldThere.fieldMark=@"content";
        fieldThere.prompted=@"时间、地点、人物、事件、结果和申请要求";
        fieldThere.example=@"模板一：我是温州市XXXX公司员工。2016年X月X日，我在单位工作过程中，被机器压伤右手，经诊断为右手中指外伤等。2016年X月X日，经XXX人力资源和社会保障局认定为工伤。2016年X月X日，经温州市劳动能力鉴定委员会鉴定为因工致残十级。因赔偿事宜与公司协商不成，现在我想起劳动仲裁要求工伤损害赔偿。我因为家庭经济困难，无力聘请律师，特申请法律援助。\r\n \r\n模板二：2016年X月X日，我在XX道路过马路时被司机XXX驾驶小汽车撞伤。2016年X月X日，道路交通事故认定书认定驾司机ＸＸ应承担事故的全部责任。因索赔事宜与司机XX协商不成，我想提起民事诉讼，要求对方赔偿损失。我因家庭经济困难，无力聘请律师，特申请法律援助。";
        [_cases addObject:fieldThere];
        
        JDLField *fieldFour=[JDLField initWithCaseFieldNmae:@"材料上传" fieldType:1 fieldContent:nil andFieldMark:@"cailiao" andFieldRadioValue:nil];
        fieldFour.fieldHeight=60;
        [_cases addObject:fieldFour];
    }
    return _cases;
}

-(NSMutableArray *)pictures{
    if (!_pictures) {
        _pictures=[NSMutableArray new];
    }
    return _pictures;
}

-(NSArray *)allRegCells{
    if(!_allRegCells)
    {
        _allRegCells=[JDLTools repeatFieldIdentifierArrayContent:self.cases];
    }
    return _allRegCells;
}


@end
