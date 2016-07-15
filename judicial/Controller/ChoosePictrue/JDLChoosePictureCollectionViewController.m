//
//  JDLChoosePictureCollectionViewController.m
//  judicial
//
//  Created by zjsos on 16/6/23.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import "JDLChoosePictureCollectionViewController.h"
#import "JDLPictureCollectionViewCell.h"
#import "JDLPictrue.h"
#import "QBImagePickerController.h"
#import "UIImage+save.h"
#import "JDLPictrueShowViewController.h"
#import "MBProgressHUD+MJ.h"
#import "JDLTools.h"
#define PICTURETYPE @"jpg"

@interface JDLChoosePictureCollectionViewController ()<QBImagePickerControllerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong)NSMutableArray *allImages;

@end

@implementation JDLChoosePictureCollectionViewController



static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backClick:)];
    self.navigationItem.backBarButtonItem = item;
    self.title=@"图片选择";
    
    self.navigationItem.rightBarButtonItem= [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(getAllImages)];
    self.collectionView.backgroundColor=[UIColor whiteColor];
    //自定义
    [self.collectionView registerClass:[JDLPictureCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

-(void)backClick:(UIBarButtonItem *)item{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提醒" message:@"点击返回则不保存刚才的操作,是否继续返回" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)getAllImages{
    if (self.allImages.count>1) {
        self.cosPicture([JDLTools removeIndex0Item:self.allImages],self.type);
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提醒" message:@"当前没有选择图片" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}


-(void)setBeforeArray:(NSMutableArray *)BeforeArray{
    _BeforeArray=BeforeArray;
    [self.allImages addObjectsFromArray:BeforeArray];
     [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.allImages.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JDLPictureCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.pictrue=self.allImages[indexPath.row];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        [self selectSheet];
    }
    else{
        JDLPictrueShowViewController *pictrueShowVC=[[JDLPictrueShowViewController alloc] init];
        __weak UICollectionView *colVC=self.collectionView;
        __weak NSMutableArray *newArr=self.allImages;
        pictrueShowVC.delImage=^(NSInteger index){
            if (newArr.count>1) {
                [newArr removeObjectAtIndex:index];
                NSIndexPath *indexPath=[NSIndexPath indexPathForRow:index inSection:0];
                [colVC deleteItemsAtIndexPaths:@[indexPath]];
            }
            else{
                [newArr removeAllObjects];
                [colVC reloadData];
            }
           
        };
        [pictrueShowVC setImages:self.allImages andIndex:indexPath.row];
        [self.navigationController pushViewController:pictrueShowVC animated:YES ];
    }
}

#pragma mark - UIActionSheetDelegate和打开相机
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            NSLog(@"打开系统相机");
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {//如果有相机
                UIImagePickerController *picker = [[UIImagePickerController alloc]init];
                picker.delegate = self; //设置代理
                picker.allowsEditing = YES; //设置拍照后为可编辑状态
                picker.sourceType = UIImagePickerControllerSourceTypeCamera; //UIImagePicker选择器的类型
                [self presentViewController:picker animated:YES completion:nil];
            }else{//没有相机的情况
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"当前设备没有摄像头。" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alertView show];
            }
            break;
            
        case 1:
        {
            [self openPhotoAlbum];
            break;
        }
        default:
            NSLog(@"取消");
            break;
    }
}




-(void)addImages:(NSArray *)paths{
    for (NSString *path in paths) {
        [self.allImages addObject:[JDLPictrue initWithThumbnailPath:path  andPicturnPath:path andType:self.type] ];
    }
    [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
}

-(void)selectSheet{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"照相机" otherButtonTitles:@"图片库", nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showFromRect:self.view.bounds inView:self.view animated:YES];
}

//打开相机
-(void)openPhotoAlbum{
    QBImagePickerController  *qbImage=[[QBImagePickerController alloc] init];
    //设置代理
    qbImage.delegate=self;
    //最少选择3张
    //qbImage.minimumNumberOfSelection = 3;
    //最多选择6张
    //qbImage.maximumNumberOfSelection = 6;
    //是否开启选择  如果只是选择一张的话 设置为false
    qbImage.allowsMultipleSelection=true;
    qbImage.title=@"选择图片";
    UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:qbImage];
    [self presentViewController:nav animated:YES completion:nil];
}


#pragma mark QBImagePickerControllerDelegate
//拍照调用
- (void) imagePickerController: (UIImagePickerController*) reader didFinishPickingMediaWithInfo: (NSDictionary*) info{
    NSString *path= [UIImage XSLSaveImage:[info objectForKey:UIImagePickerControllerOriginalImage] Type:PICTURETYPE andIndex:0];
    [self addImages:@[path]];
    [self dismissImagePickerController];
}
//单张的时候调用
- (void)imagePickerController:(QBImagePickerController *)imagePickerController didSelectAsset:(ALAsset *)asset
{
    [self addImages: @[[UIImage XSLSaveImage:[UIImage fullResolutionImageFromALAsset:asset] Type:PICTURETYPE andIndex:0]]];
    [self dismissImagePickerController];
}
//多选时调用
- (void)imagePickerController:(QBImagePickerController *)imagePickerController didSelectAssets:(NSArray *)assets
{
    [MBProgressHUD showMessage:@"图片加载中..." toView:self.view];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       
        NSMutableArray *arr=[NSMutableArray new];
        int i=0;
        for (ALAsset * asset in assets) {
           [arr addObject:[UIImage XSLSaveImage:[UIImage fullResolutionImageFromALAsset:asset] Type:PICTURETYPE andIndex:i]] ;
            i++;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self addImages:arr];
            //[AppHelper removeHUD];
            [MBProgressHUD showSuccess:@"加载完毕..." toView:self.view];
        });
    });
    [self dismissImagePickerController];
}
//点击Cancel时调用
- (void)imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController
{
    [self dismissImagePickerController];
}

- (void)dismissImagePickerController
{
    if (self.presentedViewController) {
        [self dismissViewControllerAnimated:YES completion:NULL];
    } else {
        [self.navigationController popToViewController:self animated:YES];
    }
}

#pragma mark 懒加载

-(NSMutableArray *)allImages{
    if (!_allImages) {
        _allImages=[NSMutableArray new];
        NSString *path=[[NSBundle mainBundle] pathForResource:@"icon_addpic_focused" ofType:@"png"];
        [_allImages addObject:[JDLPictrue initWithThumbnailPath:path andPicturnPath:path andType:@""]];
    }
    return  _allImages;
}


@end
