//
//  JDLChooseView.h
//  judicial
//
//  Created by zjsos on 16/6/16.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^returnChooseValue)(NSString *value);

typedef void(^clickDone)();

@interface JDLChooseView : UIView

@property (nonatomic,strong)returnChooseValue chooseValue;

@property (nonatomic,strong)clickDone clickValue;

- (instancetype)initWithFrame:(CGRect)frame andArray:(NSArray *)pickerDate;
@end
