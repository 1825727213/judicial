//
//  JDLRecipient.m
//  judicial
//
//  Created by zjsos on 16/6/5.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import "JDLRecipient.h"
#import "JDLConversion.h"
#import "NSDate+Expand.h"
@interface JDLRecipient ()

@property (nonatomic,strong)NSArray *allAttributes;

//

@end

@implementation JDLRecipient




//NSDictionary *dict1=[NSDictionary dictionaryWithObjectsAndKeys:@"jhh",@"name",@"15258697353",@"phone",@"330382199206187156",@"card",@"温州",@"region", nil];
//JDLRecipient *recipient1=[JDLRecipient createRecipient:dict1];
+(instancetype)createWithDict:(NSDictionary *)dict{
    JDLRecipient *recipient=[[JDLRecipient alloc] init];
    //recipient.createData=
    int i=[recipient updateReciptentAttributes:dict];
    if (i>0) {
        return recipient;
    }
    return nil;
}

-(int)updateReciptentAttributes:(NSDictionary *)dict{
    int i=0;
    for (NSString *key in dict) {
        NSString *selStr=[NSString stringWithFormat:@"set%@:",[key capitalizedString]];
        SEL setValue=NSSelectorFromString(selStr);
        if ([self respondsToSelector:setValue]) {
            [self performSelector:setValue withObject:dict[key]];
            i++;
        }
    }
    return i;
}

+(instancetype)createWithJson:(NSString *)json{
    return  [self createWithDict:[JDLConversion jsonToid:json]];
}


-(NSString *)toJsonObject{
    NSMutableString *jsonStr=[NSMutableString new];
    [jsonStr appendString:@"{"];
    for (NSString *attributes in self.allAttributes) {
        SEL getValue=NSSelectorFromString(attributes);
        if ([self respondsToSelector:getValue]) {
            NSString *value = [self performSelector:getValue ];
            [jsonStr appendFormat:@"\"%@\":\"%@\",",attributes,value];
        }
    }
    jsonStr=[NSMutableString stringWithString:[jsonStr substringToIndex:[jsonStr length]-1]];
    [jsonStr appendString:@"}"];
    
    return [jsonStr copy];
    
}

-(NSString *)description{
    return [NSString stringWithFormat:@"name=%@,phone=%@,card=%@,region=%@",_name,_phone,_card,_region];
}

#pragma mark 懒加载

-(NSArray *)allAttributes{
    if (!_allAttributes) {
        _allAttributes=@[@"name",@"phone",@"card",@"region"];
    }
    return _allAttributes;
}

@end
