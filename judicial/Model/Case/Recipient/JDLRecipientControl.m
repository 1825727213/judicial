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

-(NSInteger)selectRecipient:(NSString *)card{
    
    for (int i=0; i<self.allRecipients.count; i++) {
        JDLRecipient *recipient=[self.allRecipients objectAtIndex:i];
        if ([recipient.card isEqualToString:card]) {
            return i;
        }
    }
    return -1;
}

-(void)deleteRecipient:(NSString *)card{
    NSInteger index=[self selectRecipient:card];
    if (index>-1) {
        [self.allRecipients removeObjectAtIndex:index];
        [self saveRecipients];
    }
}

+(void)deleteRecipient:(JDLRecipient *)recipient{
    NSLog(@"recipient=%@",[recipient description]);
    [[JDLRecipientControl sharedSupport] deleteRecipient:recipient.card];
}

+(BOOL)addRecipient:(NSDictionary *)dict{
    return  [[JDLRecipientControl sharedSupport] addRecipient:dict];
}

-(void)updateRecipient:(NSString *)card newRecipient:(NSDictionary *)newRecipient{
    NSInteger index=[self selectRecipient:card];
    if (index >-1) {
        JDLRecipient *recipient=[self.allRecipients objectAtIndex:index];
        [recipient updateReciptentAttributes:newRecipient];
        [self saveRecipients];
    }
    
}

-(BOOL)addRecipient:(NSDictionary *)dict{
    if ([self selectRecipient:dict[@"card"]]==-1) {
        [self.allRecipients addObject:[JDLRecipient createWithDict:dict]];
        [self saveRecipients];
        return YES;
    }
    return NO;
}
+(NSMutableArray *)recipients{
    return [[self sharedSupport] allRecipients];
}
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

-(void)saveRecipients{
    NSString *path=[CACHEPATH stringByAppendingPathComponent:@"Recipient.plist"];
    NSMutableArray *arr=[NSMutableArray new];
    for (JDLRecipient *recipient in self.allRecipients) {
        [arr addObject:[recipient toJsonObject]];
    }
    [arr writeToFile:path atomically:YES];
}

@end
