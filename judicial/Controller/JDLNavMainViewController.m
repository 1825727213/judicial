//
//  JDLNavMainViewController.m
//  judicial
//
//  Created by zjsos on 16/6/11.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import "JDLNavMainViewController.h"

@interface JDLNavMainViewController ()

@end

@implementation JDLNavMainViewController

-(instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    self= [super initWithRootViewController:rootViewController];
    if (self) {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"返回";
    self.navigationItem.backBarButtonItem = backItem;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
