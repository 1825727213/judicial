//
//  JDLTextViewController.m
//  judicial
//
//  Created by zjsos on 16/6/13.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import "JDLTextViewController.h"
#import "UIView+Shortcut.h"
#import "JDLField.h"
#import "JDLDescribeLabel.h"
#import "JDLConversion.h"
#import "UIColor+Art.h"
#import "JDLValidation.h"
#import "JDLTools.h"
@interface JDLTextViewController ()<UITextViewDelegate>

@property (nonatomic,strong)JDLDescribeLabel *describeLabel;
@property (nonatomic,strong)UIImageView *imageView;

@property (nonatomic,strong)UITextView *textView;



@property (nonatomic,strong)UILabel *exampleLaebl;



@end

@implementation JDLTextViewController

-(instancetype)init{
    self=[super init];
    if (self) {
        self.view.backgroundColor=[UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self mainElementAdd];
    [self.textView becomeFirstResponder];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(selectRecipient:)];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.textView resignFirstResponder];
}

-(void)selectRecipient:(UIBarButtonItem *)item{
    
    BOOL isflog=YES;
    if ([self.field.fieldNmae isEqualToString:@"身份证"] ) {
        isflog= [JDLValidation validateIDCardNumber:self.textView.text];
    }
    else if ([self.field.fieldNmae isEqualToString:@"联系电话"]){
        isflog= [JDLValidation phoneValidation:self.textView.text];
    }
    if(isflog ){
        [self pushPopViewController];
    }
    else{
        [self alertLabel];
    }
    
}

-(void)pushPopViewController{
    self.returnText(self,self.textView.text);
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)alertLabel{
    self.describeLabel.text=[NSString stringWithFormat:@"这个%@不是有效的",self.field.fieldNmae];
    self.describeLabel.textColor=[UIColor redColor];
    self.textView.layer.borderColor=[UIColor redColor].CGColor;
}

-(void)viewDidLayoutSubviews{
    int y=self.topLayoutGuide.length,width=self.view.frame.size.width,labelHeight=40;
    self.describeLabel.frame=CGRectMake(0, y, width, labelHeight);
    self.imageView.frame=CGRectMake(10, y+10, 20, 20);
    y=y+labelHeight+20;
    self.textView.frame=CGRectMake(20, y , width-40,100);
    self.exampleLaebl.frame=CGRectMake(20, y+=100, width-40, self.view.frame.size.height-y);
}

-(void)mainElementAdd{
    [self.view addSubview:self.describeLabel];
    [self.view addSubview:self.textView];
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.exampleLaebl];
}


-(UILabel *)describeLabel{
    if (!_describeLabel) {
        _describeLabel=[[JDLDescribeLabel alloc] init];
    }
    return _describeLabel;
}
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"alert"]];
    }
    return _imageView;
}

-(UITextView *)textView{
    if (!_textView) {
        _textView=[[UITextView alloc] init];
        _textView.layer.borderWidth =1.0;
        _textView.layer.borderColor=[UIColor colorWithHex:0xdddddd andAlpha:1.0].CGColor;
        _textView.autocorrectionType = UITextAutocorrectionTypeNo;
    }
    return _textView;
}

-(void)setField:(JDLField *)field{
    _field=field;
    self.title=field.fieldNmae;
    self.describeLabel.text=field.prompted;
    self.textView.text=field.fieldContent;
    self.exampleLaebl.text=field.example;
}



-(UILabel *)exampleLaebl{
    if (!_exampleLaebl) {
        _exampleLaebl=[[UILabel   alloc] init];
        _exampleLaebl.numberOfLines=0;
        _exampleLaebl.font=[UIFont systemFontOfSize:12];
        //_exampleLaebl.text=@"模板一：我是温州市XXXX公司员工。2016年X月X日，我在单位工作过程中，被机器压伤右手，经诊断为右手中指外伤等。2016年X月X日，经XXX人力资源和社会保障局认定为工伤。2016年X月X日，经温州市劳动能力鉴定委员会鉴定为因工致残十级。因赔偿事宜与公司协商不成，现在我想起劳动仲裁要求工伤损害赔偿。我因为家庭经济困难，无力聘请律师，特申请法律援助。\r\n \r\n模板二：2016年X月X日，我在XX道路过马路时被司机XXX驾驶小汽车撞伤。2016年X月X日，道路交通事故认定书认定驾司机ＸＸ应承担事故的全部责任。因索赔事宜与司机XX协商不成，我想提起民事诉讼，要求对方赔偿损失。我因家庭经济困难，无力聘请律师，特申请法律援助。";
    }
    return _exampleLaebl;
}

@end
