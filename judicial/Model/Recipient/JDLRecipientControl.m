//
//  JDLRecipientControl.m
//  judicial
//
//  Created by zjsos on 16/6/5.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import "JDLRecipientControl.h"
#import "JDLRecipient.h"
#import "config.h"
#import "JDLTools.h"
@interface JDLRecipientControl ()

@property (nonatomic,strong)NSMutableArray *allRecipients;

@end
static JDLRecipientControl  *sharedStore=nil;

@implementation JDLRecipientControl

+(instancetype)sharedSupport
{
    //加锁使之线程安全
    @synchronized(self){
        if (!sharedStore) {
            sharedStore=[[self alloc] init];
        }
    }
    return sharedStore;
}

+(void)updateRecipient:(NSString *)card newRecipient:(NSDictionary *)newRecipient
{
    [[JDLRecipientControl sharedSupport] updateRecipient:card newRecipient:newRecipient];
}

+(NSInteger)selectRecipient:(NSString *)card{
    return [[JDLRecipientControl sharedSupport] selectRecipient:card];
}

+(JDLRecipient *)selectRecipientName:(NSString *)name{
    return [[JDLRecipientControl sharedSupport] selectRecipientName:name];
}

+(void)deleteRecipient:(JDLRecipient *)recipient{
    NSLog(@"recipient=%@",[recipient description]);
    [[JDLRecipientControl sharedSupport] deleteRecipient:recipient.card];
}

+(BOOL)addRecipient:(NSDictionary *)dict{
    return  [[JDLRecipientControl sharedSupport] addRecipient:dict];
}

+(NSMutableArray *)recipients{
    return [[self sharedSupport] allRecipients];
}


///修改
-(BOOL)updateRecipient:(NSString *)card newRecipient:(NSDictionary *)newRecipient{
    NSInteger index=[self selectRecipient:card];
    if (index >-1) {
        JDLRecipient *recipient=[self.allRecipients objectAtIndex:index];
        [recipient updateReciptentAttributes:newRecipient];
        [self saveRecipients];
        return YES;
    }
    return NO;
    
}
///添加
-(BOOL)addRecipient:(NSDictionary *)dict{
    if ([self selectRecipient:dict[@"card"]]==-1) {
        [self.allRecipients addObject:[JDLRecipient createWithDict:dict]];
        [self saveRecipients];
        return YES;
    }
    return NO;
}

///查询
-(JDLRecipient *)selectRecipientName:(NSString *)name{
    NSInteger index=[JDLTools selectObjWithArray:self.allRecipients andKey:@"name" andValue:name];
    if (index>-1 && index <self.allRecipients.count) {
        return self.allRecipients[index];
    }
    return nil;
}

///查询
-(NSInteger)selectRecipient:(NSString *)card{
    return [JDLTools selectObjWithArray:self.allRecipients andKey:@"card" andValue:card];
}


///删除受援人员并保存
-(BOOL)deleteRecipient:(NSString *)card{
    NSInteger index=[self selectRecipient:card];
    if (index>-1) {
        [self.allRecipients removeObjectAtIndex:index];
        [self saveRecipients];
        return YES;
    }
    return NO;
}

///读取受援人员
-(NSMutableArray *)allRecipients
{
    if (!_allRecipients) {
        _allRecipients=[NSMutableArray new];
        NSString *path=[CACHEPATH stringByAppendingPathComponent:@"Recipient.plist"];
        NSArray *arr=[NSMutableArray arrayWithContentsOfFile:path];
        for (NSString *str in arr) {
            [_allRecipients addObject:[JDLRecipient createWithJson:str]];
        }
    }
    return _allRecipients;
}
///保存受援人员
-(void)saveRecipients{
    NSString *path=[CACHEPATH stringByAppendingPathComponent:@"Recipient.plist"];
    NSMutableArray *arr=[NSMutableArray new];
    for (JDLRecipient *recipient in self.allRecipients) {
        [arr addObject:[recipient toJsonObject]];
    }
    [arr writeToFile:path atomically:YES];
}

@end
