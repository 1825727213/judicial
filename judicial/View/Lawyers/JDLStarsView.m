//
//  JDLStarsView.m
//  judicial
//
//  Created by zjsos on 16/6/29.
//  Copyright © 2016年 zjsos. All rights reserved.
//

#import "JDLStarsView.h"

#define STARSCOUNT 5

@interface JDLStarsView ()

@property (nonatomic,strong)NSMutableArray *stars;

@end

@implementation JDLStarsView


-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        for (int i=0; i<STARSCOUNT; i++) {
            UIImageView *imageView= [[UIImageView alloc] init];
            [self.stars addObject:imageView];
        }
    }
    return self;
}

-(void)setStarsCount:(NSInteger )count{
    int width=self.frame.size.width/STARSCOUNT;
    for (int i=0; i<STARSCOUNT; i++) {
        UIImageView *imageView=self.stars[i];
        imageView.frame= CGRectMake(width*i, 0, width, width);
        if (i<count) {
            imageView.image=[UIImage imageNamed:@"loveRad"];
        }
        else{
            imageView.image=[UIImage imageNamed:@"lovegGray"];
        }
        [self addSubview:imageView];
    }
}




-(NSMutableArray *)stars{
    if (!_stars) {
        _stars=[NSMutableArray new];
    }
    return _stars;
}

@end
