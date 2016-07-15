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
#import "JDLTools.h"
#import "JDLConversion.h"

@interface JDLRecipient ()

@property (nonatomic,strong)NSArray *allAttributes;



@end

@implementation JDLRecipient


+(instancetype)createWithDict:(NSDictionary *)dict{
    JDLRecipient *recipient=[[JDLRecipient alloc] init];
    int i=[JDLTools updateReciptentAttributes:recipient :dict];
    if (i>0) {
        return recipient;
    }
    return nil;
}

-(int)updateReciptentAttributes:(NSDictionary *)dict{
    return [JDLTools updateReciptentAttributes:self :dict];
}

+(instancetype)createWithJson:(NSString *)json{
    return  [self createWithDict:[JDLConversion jsonToid:json]];
}

-(NSString *)toJsonObject{
    return  [JDLConversion objtoJson:self Attributes:self.allAttributes];
}

-(NSString *)description{
    return [self toJsonObject];
}



#pragma mark 懒加载

-(NSArray *)allAttributes{
    if (!_allAttributes) {
        _allAttributes=@[@"name",@"phone",@"card",@"region",@"address",@"sex",@"center",@"caseid"];
    }
    return _allAttributes;
}

@end
