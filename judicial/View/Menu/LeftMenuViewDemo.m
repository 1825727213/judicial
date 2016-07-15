//
//  LeftMenuViewDemo.m
//  MenuDemo
//
//  Created by Lying on 16/6/12.
//  Copyright © 2016年 Lying. All rights reserved.
//
#define ImageviewWidth    18
#define Frame_Width       self.frame.size.width//200

#import "LeftMenuViewDemo.h"
#import "JDLMenu.h"
#import "UIColor+Art.h"
@interface LeftMenuViewDemo ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,strong)UITableView    *contentTableView;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)NSArray *menus;

@end

@implementation LeftMenuViewDemo

 
-(instancetype)initWithFrame:(CGRect)frame{

    if(self = [super initWithFrame:frame]){
        [self initView];
    }
    return  self;
}

-(void)initView{
    
    //添加头部
    UIView *headerView     = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Frame_Width, 90)];
    
    UITapGestureRecognizer *tapGR=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [headerView addGestureRecognizer:tapGR];
    
    [headerView setBackgroundColor:[UIColor colorWithHex:0xcb414a andAlpha:1.0]];
    CGFloat width          = 90/2;
    
    CGFloat yheight=10;
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(12, (90 - width) / 2, width, width)];
//    [imageview setBackgroundColor:[UIColor redColor]];
    imageview.layer.cornerRadius = imageview.frame.size.width / 2;
    imageview.layer.masksToBounds = YES;
    [imageview setImage:[UIImage imageNamed:@"HeadIcon"]];
    [headerView addSubview:imageview];
    
    
    width                  = 15;
    UIImageView *arrow     = [[UIImageView alloc]initWithFrame:CGRectMake(Frame_Width - width - 10, (90 - width)/2, width, width)];
    arrow.contentMode      = UIViewContentModeScaleAspectFit;
    [arrow setImage:[UIImage imageNamed:@"person-icon0"]];
    [headerView addSubview:arrow];
    
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageview.frame.size.width + imageview.frame.origin.x * 2, imageview.frame.origin.y , 90, imageview.frame.size.height)];
    self.nameLabel.textColor=[UIColor whiteColor];
    //[self.nameLabel setText:@"隔壁老王"];
    [headerView addSubview:self.nameLabel];
    
    [self addSubview:headerView];
    
    
    //中间tableview
    UITableView *contentTableView        = [[UITableView alloc]initWithFrame:CGRectMake(0, headerView.frame.size.height, Frame_Width, self.frame.size.height)
                                                                       style:UITableViewStylePlain];
    [contentTableView setBackgroundColor:[UIColor whiteColor]];
    contentTableView.dataSource          = self;
    contentTableView.delegate            = self;
    contentTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [contentTableView setBackgroundColor:[UIColor whiteColor]];
    contentTableView.separatorStyle      = UITableViewCellSeparatorStyleNone;
    contentTableView.tableFooterView = [UIView new];
    self.contentTableView = contentTableView;
    [self addSubview:contentTableView];
    
    
    
    //添加尾部
    //width              = 90;
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 40, Frame_Width, 40)];
    [footerView setBackgroundColor:[UIColor lightGrayColor]];
    
    
    UIImageView *LoginImageview = [[UIImageView alloc]initWithFrame:CGRectMake(8 + 5, (40 - ImageviewWidth)/2, ImageviewWidth, ImageviewWidth)];
    [LoginImageview setImage:[UIImage imageNamed:@"person-icon8"]];
    [footerView addSubview:LoginImageview];
    UILabel *logoutLabel=[[UILabel alloc] initWithFrame:CGRectMake(8 + 5+ImageviewWidth+5, (40 - ImageviewWidth)/2,Frame_Width - 8 + 5+ImageviewWidth+5 , ImageviewWidth)];
    logoutLabel.font=[UIFont systemFontOfSize:12.0];
    logoutLabel.textColor=[UIColor whiteColor];
    logoutLabel.text=@"退出登录";
    [footerView addSubview:logoutLabel];
    //width = 30;

    UITapGestureRecognizer *logoutTapGR=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(logoutTapGR:)];
    [footerView addGestureRecognizer:logoutTapGR];
    
    [self addSubview:footerView];
}

-(void)logoutTapGR:(UITapGestureRecognizer *)gr{
    if([self.customDelegate respondsToSelector:@selector(LeftMenuViewClick:)]){
        [self.customDelegate LeftMenuViewClick:88];
    }
}


-(void)tap:(UITapGestureRecognizer *)gr{
    if([self.customDelegate respondsToSelector:@selector(LeftMenuViewClick:)]){
        [self.customDelegate LeftMenuViewClick:99];
    }
}



#pragma mark - tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.menus.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 45 ;
}


-(void)setUserName:(NSString *)userName {
    self.nameLabel.text=userName;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = [NSString stringWithFormat:@"LeftView%li",indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];

    }
    [cell setBackgroundColor:[UIColor whiteColor]];
    [cell.textLabel setTextColor:[UIColor grayColor]];
    JDLMenu *menu=self.menus[indexPath.row];
    
    [cell.imageView setImage:[UIImage imageNamed:menu.imageName]];
    [cell.textLabel setText:menu.title];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if([self.customDelegate respondsToSelector:@selector(LeftMenuViewClick:)]){
        [self.customDelegate LeftMenuViewClick:indexPath.row];
    }
    
}

-(NSArray *)menus{
    if (!_menus) {
        _menus=[JDLMenu defaultMenu];
    }
    return _menus;
}

@end
