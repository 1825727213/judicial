//
//  JDLField.m
//  judicial
//
//  Created by zjsos on 16/6/12.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import "JDLField.h"
#import "JDLTools.h"
#import "JDLConversion.h"
@implementation JDLField

#pragma mark 创建对象


+(instancetype)initWithHistortCaseFieldNmae:(NSString *)fieldNmae fieldType:(NSInteger)fieldType fieldContent:(NSString *)fieldContent{
    JDLField *field= [[self alloc] initWithFieldNmae:fieldNmae fieldType:fieldType fieldContent:fieldContent];
    field.prompted=@"";
    return field;
}

+(instancetype)initWithCaseFieldNmae:(NSString *)fieldNmae fieldType:(NSInteger)fieldType fieldContent:(NSString *)fieldContent andFieldMark:(NSString *)fieldMark andFieldRadioValue:(NSArray *)fieldRadioValue{
    JDLField *field= [[self alloc] initWithFieldNmae:fieldNmae fieldType:fieldType fieldContent:fieldContent];
    field.fieldRadioValue=fieldRadioValue;
    field.fieldMark=fieldMark;
    return field;
}

+(instancetype)initWithFieldNmae:(NSString *)fieldNmae fieldType:(NSInteger)fieldType fieldContent:(NSString *)fieldContent{
    return [[self alloc] initWithFieldNmae:fieldNmae fieldType:fieldType fieldContent:fieldContent];
}

-(instancetype)initWithFieldNmae:(NSString *)fieldNmae fieldType:(NSInteger)fieldType fieldContent:(NSString *)fieldContent{
    self=[super init];
    if (self) {
        self.fieldNmae=fieldNmae;
        self.fieldType=fieldType;
        self.fieldContent=fieldContent;
        self.prompted=[NSString stringWithFormat:@"请输入%@",fieldNmae];
    }
    return self;
}


+(NSDictionary *)setAllFields:(NSArray *)allFields{
    NSMutableDictionary *dict=[NSMutableDictionary new];
    for (JDLField *fld in allFields) {
        [dict setObject:fld.fieldContent forKey:fld.fieldMark];
    }
    return [dict copy];
}

#pragma mark 设置常用属性
-(void)setFieldType:(NSInteger)fieldType{
    _fieldType=fieldType;
    self.identifier=[self returnIdentifier];
}

-(void)setFieldRadioValue:(NSArray *)fieldRadioValue{
    _fieldRadioValue=fieldRadioValue;
    //self.fieldContent=fieldRadioValue[0];
}

-(NSString *)fieldContent{
    if (!_fieldContent) {
        _fieldContent=@"";
    }
    return _fieldContent;
}

-(NSString *)returnIdentifier{
    NSString *ident=@"";
    if (self.fieldType==0) {
        ident=@"JDLLargeTextTableViewCell";
    }
    if (self.fieldType==1) {
        ident=@"JDLCaseTableViewCell";
    }
    if (self.fieldType==2) {
        ident=@"JDLRadioTableViewCell";
    }
    if (self.fieldType==3) {
        ident=@"JDLTextTableViewCell";
    }
    if (self.fieldType==4) {
        ident=@"JDLLargeTextTableViewCell";
    }
    return ident;
}
/**
 *  设置默认提示文本
 *
 *  @return <#return value description#>
 */
-(NSString *)prompted{
    if (!_prompted) {
        _prompted=@"此项是必填项";
    }
    return _prompted;
}
/**
 *  设置默认高度
 *
 *  @return <#return value description#>
 */
-(CGFloat)fieldHeight{
    if (!_fieldHeight) {
        _fieldHeight=44;
    }
    return _fieldHeight;
}

@end
