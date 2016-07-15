//
//  JDLValidation.h
//  judicial
//
//  Created by zjsos on 16/6/16.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface JDLValidation : NSObject

+(BOOL)phoneValidation:(NSString *)phone;
+ (BOOL)validateIDCardNumber:(NSString *)value;
@end
