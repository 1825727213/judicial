//
//  JDLField.h
//  judicial
//
//  Created by zjsos on 16/6/12.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef void (^ClickMethods)(NSString *value);

@interface JDLField : NSObject
/**
 *   标题
 */
@property (nonatomic,strong)NSString *fieldNmae;
/*
    fieldType  0 正常  左边标题 右边内容
               1 选择  右边多了一个选择箭头
               2 单选框 
               3 文本框
               4 不可编辑
*/
@property (nonatomic,assign)NSInteger fieldType;
/**
 *  内容
 */
@property (nonatomic,strong)NSString *fieldContent;
/**
 *  行高
 */
@property (nonatomic,assign)CGFloat fieldHeight;
/**
 *  cell的类名
 */
@property (nonatomic,strong)NSString *identifier;
/**
 *  说明信息
 */
@property (nonatomic,strong)NSString *prompted;
/**
 *  标示
 */
@property (nonatomic,strong)NSString *fieldMark;
/**
 *  单选框的值
 */
@property (nonatomic,strong)NSArray *fieldRadioValue;
/**
 *  事件block块
 */
/**
 *  事例
 */
@property(nonatomic,strong)NSString *example;

@property (nonatomic,strong)NSString *defaultRadioValue;

@property (nonatomic,strong)ClickMethods clickMethods;

+(instancetype)initWithFieldNmae:(NSString *)fieldNmae fieldType:(NSInteger)fieldType fieldContent:(NSString *)fieldContent;
+(instancetype)initWithHistortCaseFieldNmae:(NSString *)fieldNmae fieldType:(NSInteger)fieldType fieldContent:(NSString *)fieldContent;
+(instancetype)initWithCaseFieldNmae:(NSString *)fieldNmae fieldType:(NSInteger)fieldType fieldContent:(NSString *)fieldContent andFieldMark:(NSString *)fieldMark andFieldRadioValue:(NSArray *)fieldRadioValue;
+(NSDictionary *)setAllFields:(NSArray *)allFields;

@end
