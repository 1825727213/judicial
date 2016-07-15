//
//  UIImage+save.m
//  Lovesickness
//
//  Created by w gq on 15/8/7.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import "UIImage+save.h"
#import "config.h"
#import "NSDate+Expand.h"
@implementation UIImage (save)

+(UIImage *)XSLGetImage:(NSString *)filename
{

    NSString *path=[CACHEPATH stringByAppendingPathComponent:filename];
    NSData *data=[NSData dataWithContentsOfFile:path];
    
    UIImage *image=[UIImage imageWithData:data];
    return image;
}


+(NSString *)XSLSaveImage:(UIImage *)image Type:(NSString *)type andIndex:(NSInteger )index
{
    NSString *directro=[@"Image" stringByAppendingPathComponent:[NSDate XSLCurrentDate]];
    NSString *fileName=[NSString stringWithFormat:@"%@%ld",[NSDate XSLCurrentTime],(long)index];
    NSData *data=nil;
    if ([type isEqualToString:@"png"]) {
        fileName=[fileName stringByAppendingString:@".png"];
        data=UIImagePNGRepresentation(image);
    }
    else
    {
        fileName=[fileName stringByAppendingString:@".jpg"];
        data=UIImageJPEGRepresentation(image, 0.5);
    }

    NSString *savePath=[CACHEPATH stringByAppendingPathComponent:directro];

    if (![[NSFileManager defaultManager] fileExistsAtPath:savePath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:savePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    savePath=[savePath stringByAppendingPathComponent:fileName];
    
    [[NSFileManager defaultManager] createFileAtPath:savePath contents:data attributes:nil];
    //NSLog(@"%@", savePath);
    //NSLog(@"%@", [directro stringByAppendingPathComponent:fileName]);
    
    //return [directro stringByAppendingPathComponent:fileName];
    return savePath;
}


+(UIImage *)roundImage:(UIImage *)image{
    
    //申请一块空白的正方形画布
    UIGraphicsBeginImageContext(CGSizeMake(80, 80));
    //在begin和end之间这个特殊的区域内就可以编写
    //与绘图有关的代码了
    //就是说只有在这个区域内才能写core graphics或者是 UIBezierPath
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 80, 80)];
    [path addClip];
    [image drawInRect:CGRectMake(0, 0, 80, 80)];
    UIImage *tempImage = UIGraphicsGetImageFromCurrentImageContext();
    //portrait.image = tempImage;
    UIGraphicsEndImageContext();
    return tempImage;
}

+ (UIImage *)fullResolutionImageFromALAsset:(ALAsset *)asset
{
    ALAssetRepresentation *assetRep = [asset defaultRepresentation];
    CGImageRef imgRef = [assetRep fullResolutionImage];
    UIImage *img = [UIImage imageWithCGImage:imgRef
                                       scale:assetRep.scale
                                 orientation:(UIImageOrientation)assetRep.orientation];
    return img;
}

@end
