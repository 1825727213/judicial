//
//  UIImage+save.h
//  Lovesickness
//
//  Created by w gq on 15/8/7.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
@interface UIImage (save)
///保存图片
+(NSString *)XSLSaveImage:(UIImage *)image Type:(NSString *)type  andIndex:(NSInteger )index;
///获取图片
+(UIImage *)XSLGetImage:(NSString *)filename;
///制作原型图片
+(UIImage *)roundImage:(UIImage *)image;
///ALAsset转UIImage
+ (UIImage *)fullResolutionImageFromALAsset:(ALAsset *)asset;
@end
