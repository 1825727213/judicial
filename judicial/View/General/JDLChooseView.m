//
//  JDLChooseView.m
//  judicial
//
//  Created by zjsos on 16/6/16.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import "JDLChooseView.h"

#define kWinSize [UIScreen mainScreen].bounds.size

@interface JDLChooseView ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic,strong)NSArray *pickerData;
@property (nonatomic,strong)UIPickerView *pickerView;
@end

@implementation JDLChooseView

- (instancetype)initWithFrame:(CGRect)frame andArray:(NSArray *)pickerDate
{
    self = [super initWithFrame:frame];
    if (self) {
        self.pickerData=pickerDate;
        CGRect datePickerFrame;
        
        self.frame = CGRectMake(0.0, 0.0, kWinSize.width, 260.0);
        datePickerFrame = CGRectMake(0.0, 44.5, self.frame.size.width, 216.0);
        UIToolbar *toolbar = [[UIToolbar alloc]
                              initWithFrame: CGRectMake(0.0, 0.0, self.frame.size.width, datePickerFrame.origin.y - 0.5)];
        
        //NSLog(@"宽：%f，高：%f",self.frame.size.width,datePickerFrame.origin.y - 0.5);
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(_cancel)];
        
        UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace
                                      target: self
                                      action: nil];
        UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(_cancel)];
        
        
        
        [toolbar setItems: @[cancelButton, flexSpace, doneBtn]
                 animated: YES];
        [self addSubview: toolbar];
        
        self.pickerView=[[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, 320,254)];
        self.pickerView.delegate=self;
        
        self.pickerView.showsSelectionIndicator=YES;
        [self addSubview:self.pickerView];
        
        
    }
    return self;
}

-(void)_cancel{
    self.clickValue();
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.chooseValue([self.pickerData objectAtIndex:row]);
}


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.pickerData.count;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.pickerData objectAtIndex:row];
}


@end
