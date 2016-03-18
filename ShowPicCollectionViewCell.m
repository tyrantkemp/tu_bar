//
//  ShowPicCollectionViewCell.m
//  tu_bar
//
//  Created by 肖准 on 15/10/14.
//  Copyright © 2015年 肖准. All rights reserved.
//

#import "ShowPicCollectionViewCell.h"

@implementation ShowPicCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if(self==[super initWithFrame:frame]){
        
        self.pic=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-30)];
        self.pic.backgroundColor=[UIColor greenColor];
        
        self.up=[[UILabel alloc]initWithFrame:CGRectMake(5, frame.size.height-30, frame.size.width/2, 30)];
        self.up.backgroundColor=[UIColor grayColor];
        
        self.speech=[[UILabel alloc]initWithFrame:CGRectMake(frame.size.width/2, frame.size.height-30, frame.size.width/2, 30)];
        self.speech.backgroundColor=[UIColor grayColor];
        [self.contentView addSubview:self.pic];
        [self.contentView addSubview:self.up];
        [self.contentView addSubview:self.speech];

    }
    return self;
}
@end
