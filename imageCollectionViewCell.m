//
//  imageCollectionViewCell.m
//  tu_bar
//
//  Created by 肖准 on 15/9/29.
//  Copyright (c) 2015年 肖准. All rights reserved.
//

#import "imageCollectionViewCell.h"

@implementation imageCollectionViewCell


-(instancetype)initWithFrame:(CGRect)frame{
    
    if(self==[super initWithFrame:frame]){
        self.pic=[[UIImageView alloc]initWithFrame:self.bounds];
        [self.contentView addSubview:self.pic];
        [self.pic addSubview:self.bacview];
    }
    return self;
}
-(UIView*)bacview{
    if(_bacview==nil){
        _bacview=[[UIView alloc]initWithFrame:CGRectZero];
        _bacview.bounds=CGRectMake(0, 0, self.bounds.size.width/2, 20);
        _bacview.center=CGPointMake(self.bounds.size.width/4*3, self.bounds.size.height-10);
        _bacview.backgroundColor=[UIColor colorWithWhite:1.000 alpha:0.500];
        self.countlb=[[UILabel alloc]initWithFrame:CGRectZero];
        self.countlb.bounds=CGRectMake(0, 0, self.bounds.size.width/3, 20);
        self.countlb.center=CGPointMake(_bacview.frame.size.width/2, _bacview.frame.size.height/2);
        self.countlb.text=@"12";
        self.countlb.font=[UIFont systemFontOfSize:10];
        [_bacview addSubview:self.countlb];
        self.icon=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"heart.png"]];
        self.icon.bounds=CGRectMake(0,0 , 20, 20);
        self.icon.center=CGPointMake(_bacview.frame.size.width/4*3, _bacview.frame.size.height/2);
        [_bacview addSubview:self.icon];
    }
    return _bacview;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.pic.frame=CGRectInset(self.bounds, 0, 0);
    self.bacview.frame=CGRectMake(self.bounds.size.width/2, self.bounds.size.height-20, self.bounds.size.width/2, 20);
    
}
@end
