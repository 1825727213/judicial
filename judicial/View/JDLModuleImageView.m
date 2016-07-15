//
//  JDLModuleImageView.m
//  judicial
//
//  Created by zjsos on 16/6/9.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import "JDLModuleImageView.h"



#define LEFTSPACE 20
#define TOPSPACE 10
#define RIGHTSPACE 20
#define WIDTHMIDDLESPACE 15
#define HEIGHTMIDDLESPACE 10
#define MIDDLEDEVIATION 10
#define LABELHEIGHT 30

@interface JDLModuleImageView ()

@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,assign)NSInteger iconWidthProprotion;
@property (nonatomic,assign)NSInteger imageWidthProprotion;

@property (nonatomic,assign)CGFloat iconWidth;
@property (nonatomic,assign)CGFloat iconHeight;

@property (nonatomic,assign)CGFloat logoWidth;
@property (nonatomic,assign)CGFloat logoHeight;

@property (nonatomic,assign)CGFloat fontSize;

@end

@implementation JDLModuleImageView

-(instancetype)init
{
    
    self=[super init];
    if (self) {
        self.contentMode=UIViewContentModeScaleAspectFit;
        self.userInteractionEnabled=YES;
        
        [self addSubview:self.imageView];
        [self addSubview:self.titleLabel];
        UITapGestureRecognizer *tapGR=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        //tapGR.numberOfTouchesRequired=1;
        [self addGestureRecognizer:tapGR];
    }
    return self;
}


-(void)tap:(UITapGestureRecognizer *)gr{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"mianClickImageView" object:nil userInfo:@{@"tag":[NSNumber numberWithLong:self.tag]}];
}


-(void)typeOne{
    self.imageView.image=[UIImage imageNamed:@"online_apply"];
    self.imageView.frame=CGRectMake(LEFTSPACE, TOPSPACE, self.iconWidth, self.iconHeight);
    self.titleLabel.text=@"在线申请";
    self.titleLabel.frame=CGRectMake(LEFTSPACE-15, TOPSPACE +self.imageView.frame.size.height, self.imageView.frame.size.width +10, LABELHEIGHT);
}

-(void)typeTwo{
    self.imageView.image=[UIImage imageNamed:@"legal_advice"];
    self.imageView.frame=CGRectMake(self.frame.size.width-self.iconWidth-RIGHTSPACE, TOPSPACE, self.iconWidth, self.iconHeight);
    self.titleLabel.text=@"法律咨询";
    self.titleLabel.frame=CGRectMake(self.frame.size.width-self.imageView.frame.size.width-RIGHTSPACE+5, TOPSPACE+self.imageView.frame.size.height, self.imageView.frame.size.width + 10, LABELHEIGHT);
}

-(void)typeThree{
    self.imageView.image=[UIImage imageNamed:@"click_help"];
    self.imageView.frame=CGRectMake(LEFTSPACE, self.frame.size.height-self.iconHeight-TOPSPACE, self.iconWidth, self.iconHeight);
    self.titleLabel.text=@"律师点援";
    self.titleLabel.frame=CGRectMake(LEFTSPACE-15, self.frame.size.height-self.imageView.frame.size.height-TOPSPACE-LABELHEIGHT, self.imageView.frame.size.width + 10 , LABELHEIGHT);
}

-(void)typeFour{
    //NSLog(@"iconWidth=%f iconHeight=%f",self.iconWidth,self.iconHeight);
    self.imageView.image=[UIImage imageNamed:@"handle_process"];
    self.imageView.frame=CGRectMake(self.frame.size.width-self.iconWidth-RIGHTSPACE, self.frame.size.height-self.iconHeight-TOPSPACE, self.iconWidth, self.iconHeight);
    self.titleLabel.text=@"办案助手";
    self.titleLabel.frame=CGRectMake(self.frame.size.width-self.imageView.frame.size.width-RIGHTSPACE+5, self.frame.size.height-self.imageView.frame.size.height-TOPSPACE-LABELHEIGHT, self.imageView.frame.size.width + 10 , LABELHEIGHT);
}

-(void)typeFive{
    self.imageView.image=[UIImage imageNamed:@"logo"];
    self.imageView.frame=CGRectMake((self.frame.size.width-self.logoWidth)/2, (self.frame.size.height-self.logoHeight)/2, self.logoWidth, self.logoHeight );
    self.titleLabel.text=@"";
  
}
-(void)setModuleType:(NSInteger)moduleType
{
    _moduleType=moduleType;
    self.tag=moduleType;
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    _iconHeight=42.0/107.0 * self.frame.size.height;
    _iconWidth=35.0 / 96.0 * self.frame.size.width;
    _logoWidth=61.0/96.0 * self.frame.size.width;
    _logoHeight=78.0/107.0 * self.frame.size.height;
    CGFloat proportion= 1;
    if ([[UIScreen mainScreen]bounds ].size.width ==320 && [[UIScreen mainScreen]bounds ].size.height == 480 ) {
        proportion=0.9;
    }
    else if ([[UIScreen mainScreen]bounds ].size.width ==375 && [[UIScreen mainScreen]bounds ].size.height == 667 ){
        proportion=1.2;
    }
    else if ([[UIScreen mainScreen]bounds ].size.width ==414 && [[UIScreen mainScreen]bounds ].size.height == 736 ){
        proportion=1.5;
    }
    _fontSize=11.7 * proportion ;
    switch (self.moduleType) {
        case 0:
            [self typeOne];
            break;
        case 1:
            [self typeTwo];
            break;
        case 2:
            [self typeThree];
            break;
        case 3:
            [self typeFour];
            break;
        default:
            [self typeFive];
            break;
    }
}

-(UIImageView *)imageView
{
    if (!_imageView) {
        _imageView=[[UIImageView alloc] init];
    }
    return _imageView;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel=[[UILabel alloc] init];
        // 6s * 1.3
        _titleLabel.font=[UIFont systemFontOfSize:self.fontSize];
        _titleLabel.textColor=[UIColor whiteColor];
        _titleLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end
