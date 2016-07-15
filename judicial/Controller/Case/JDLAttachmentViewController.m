//
//  JDLAttachmentViewController.m
//  judicial
//
//  Created by zjsos on 16/6/27.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import "JDLAttachmentViewController.h"
#import "UIColor+Art.h"
#import "JDLGeneralButton.h"
#import "JDLChoosePictureCollectionViewController.h"
#import "JDLChoosePictureLayout.h"
#import "config.h"
#import "JDLPictrue.h"
#import "JDLDescribeLabel.h"
#import "JDLHelppageViewController.h"   
@interface JDLAttachmentViewController ()

@property (nonatomic,strong)NSArray *allType;
@property (nonatomic,strong)NSArray *allTypeName;

@property (nonatomic,strong)NSMutableArray *allPictrues;

@property (nonatomic,strong)JDLDescribeLabel *helpageLabel;
@property (nonatomic,strong)UIImageView *imageView;

@end

@implementation JDLAttachmentViewController

-(instancetype)init{
    self=[super init];
    if (self) {
        self.view.backgroundColor=[UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backClick:)];
    self.navigationItem.leftBarButtonItem=item;
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(submitAttachment:)];
    self.title=@"材料上传";
    [self addElementAdd];
}

-(void)viewDidLayoutSubviews{
    int y=self.topLayoutGuide.length,width=self.view.frame.size.width,labelHeight=40;
    self.helpageLabel.frame=CGRectMake(0, y, width, labelHeight);
    self.imageView.frame=CGRectMake(10, y+10, 20, 20);
}

-(void)backClick:(UIBarButtonItem *)item{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"不保存返回？" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)submitAttachment:(UIBarButtonItem *)item{
    NSLog(@"submitAttachment");
    self.choosePic([self.allPictrues copy]);
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)clickBtn:(UIButton *)btn{
    //清空文件夹的历史图片
    //[[NSFileManager defaultManager] removeItemAtPath:[CACHEPATH stringByAppendingPathComponent:@"Image"] error:nil];
    JDLChoosePictureCollectionViewController *choosePictureViewController=[[JDLChoosePictureCollectionViewController alloc] initWithCollectionViewLayout:[[JDLChoosePictureLayout alloc] init]];
    
    choosePictureViewController.BeforeArray=[self getTypeArray:self.allPictrues andType:self.allType[btn.tag]];
    __weak NSMutableArray *newAllPictures=self.allPictrues;
    __weak JDLAttachmentViewController *ahmVC=self;
    choosePictureViewController.cosPicture=^(NSArray *pictures,NSString *type){
        [ahmVC delTypeArray:newAllPictures andType:type];
        [newAllPictures addObjectsFromArray:pictures];
    };
    choosePictureViewController.type=self.allType[btn.tag];
    [self.navigationController pushViewController:choosePictureViewController animated:YES];
}

-(void)setBeforeArray:(NSArray *)BeforeArray{
    _BeforeArray=BeforeArray;
    [self.allPictrues addObjectsFromArray:BeforeArray];
}

/**
 *  删除数组中某个类别的全部图片
 *
 *  @param arr  数组
 *  @param type 类别
 *
 *  @return 新的数组
 */
-(void)delTypeArray:(NSMutableArray *)arr andType:(NSString *)type{
    NSMutableArray *newArr=[NSMutableArray new];
    for (NSInteger i=arr.count-1; i>=0; i--) {
        JDLPictrue *picture=arr[i];
        if (![picture.type isEqualToString:type]) {
            [newArr addObject:picture];
        }
    }
    [arr removeAllObjects];
    [arr addObjectsFromArray:newArr];
}

/**
 *  获取数组中某个类别的全部图片
 *
 *  @param arr  数组
 *  @param type 类别
 *
 *  @return 新的数组
 */
-(NSMutableArray *)getTypeArray:(NSMutableArray *)arr andType:(NSString *)type{
    NSMutableArray *newArr=[NSMutableArray new];
    for (int i=0; i<arr.count; i++) {
        JDLPictrue *picture=arr[i];
        if ([picture.type isEqualToString:type]) {
            [newArr addObject:picture];
        }
    }
    return newArr;
}



/**
 *  添加上传材料按钮
 */
-(void)addElementAdd{
    int y=150,x=40,width=self.view.frame.size.width,height=40;
    for (int i=0; i<self.allType.count ; i++) {
        JDLGeneralButton *btn=[JDLGeneralButton buttonWithType:UIButtonTypeRoundedRect];
        [btn setTitle:self.allTypeName[i] forState:UIControlStateNormal];
        btn.frame=CGRectMake(x, y, width-x*2, height);
        btn.tag=i;
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        y+=80;
        [self.view addSubview:btn];
    }
    [self.view addSubview:self.helpageLabel];
    [self.view addSubview:self.imageView];
}

-(NSArray *)allType{
    if (!_allType) {
        _allType=@[@"身份证",@"经济困难证明材料",@"事实材料"];
    }
    return _allType;
}

-(NSArray *)allTypeName{
    if (!_allTypeName) {
        _allTypeName=@[@"身份证上传",@"经济困难证明材料上传",@"事实材料上传"];
    }
    return _allTypeName;
}

-(NSMutableArray *)allPictrues{
    if (!_allPictrues) {
        _allPictrues=[NSMutableArray new];
    }
    return _allPictrues;
}

-(void)clickLabel{
    JDLHelppageViewController *helpVc=[[JDLHelppageViewController alloc] init];
    helpVc.title=@"上传材料说明";
    helpVc.docmentName=@"Materialspecification.docx";
    [self.navigationController pushViewController:helpVc animated:YES];
}

-(JDLDescribeLabel *)helpageLabel{
    if (!_helpageLabel) {
        _helpageLabel=[[JDLDescribeLabel alloc] init];
        _helpageLabel.text=@"上传材料说明";
        _helpageLabel.userInteractionEnabled=YES;
        UITapGestureRecognizer *tagGr=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickLabel)];
        [_helpageLabel addGestureRecognizer:tagGr];
    }
    return _helpageLabel;
}

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"alert"]];
    }
    return _imageView;
}

@end
