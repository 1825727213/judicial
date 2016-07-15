//
//  JDLConversion.m
//  judicial
//
//  Created by zjsos on 16/6/5.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import "JDLConversion.h"
#import "config.h"
#import "SoapXmlParseHelper.h"
@implementation JDLConversion


+(NSString *)encryptCard:(NSString *)card{
    NSMutableString *newStr=[NSMutableString new];
    for (int i=0; i<card.length; i++) {
        if (i<6 || i>card.length-5) {
            [newStr appendString:[card substringWithRange:NSMakeRange (i, 1)]];
        }
        else{
            [newStr appendString:@"*"];
        }
    }
    return newStr;
}

+(NSInteger)scoreToStar:(NSInteger)star{
    if (star >=90) {
        return 5;
    }
    else if (star >=80)
    {
        return 4;
    }
    else if (star>=70)
    {
        return 3;
    }
    else if (star>=60)
    {
        return 2;
    }
    return 1;
}



+(NSString *)SetLegaCaseApplyPersonParse:(id)xml{
    NSArray *arr=[SoapXmlParseHelper XmlToArray:xml];
    if (arr.count>0) {
        return  [SoapXmlParseHelper XmlToArray:xml][0][@"text"];
    }
    return nil;
}


+(id)jsonToid:(NSString *)json
{
    if (json==nil)  return nil;

    json = [json stringByReplacingOccurrencesOfString:@"	" withString:@""];
    NSData* data = [json dataUsingEncoding:NSUTF8StringEncoding];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

+(NSString *)arrToString:(NSArray *)arr{
    if (arr==nil || arr.count<1) {
        return @"";
    }
    NSMutableString *str=[NSMutableString new];
    for (int i=0; i<arr.count; i++) {
        [str appendString:arr[i]];
        [str appendString:@","];
    }
    return [str substringToIndex:[str length]-1];
}




+(NSString *)objtoJson:(id)obj Attributes:(NSArray *)attributes{
    NSMutableString *jsonStr=[NSMutableString new];
    [jsonStr appendString:@"{"];
    for (NSString *attribute in attributes) {
        SEL getValue=NSSelectorFromString(attribute);
        if ([obj respondsToSelector:getValue]) {
            NSString *value =@"";
            SuppressPerformSelectorLeakWarning(value=[obj performSelector:getValue ]);
            [jsonStr appendFormat:@"\"%@\":\"%@\",",attribute,value];
        }
    }
    jsonStr=[NSMutableString stringWithString:[jsonStr substringToIndex:[jsonStr length]-1]];
    [jsonStr appendString:@"}"];
    return [jsonStr copy];
}

@end
