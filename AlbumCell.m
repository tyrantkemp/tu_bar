//
//  AlbumCell.m
//  tu_bar
//
//  Created by 肖准 on 15/11/28.
//  Copyright © 2015年 肖准. All rights reserved.
//

#import "AlbumCell.h"

@implementation AlbumCell
-(instancetype)initWithStyleAndAlbumInfo:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier album:(Album*)al{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        UIImage* img=[Utils getImageByimageId:al.holderimgid];
        self.icon=[[UIImageView alloc]initWithImage:img];
        self.icon.frame =CGRectMake(0, 0, 50, 50);
        [self.contentView addSubview:self.icon];
        
        self.albumname = [[UILabel alloc]initWithFrame:CGRectMake(55, 5, 100, 25)];
        self.albumname.text=al.albumname;
        self.albumname.font=[UIFont systemFontOfSize:13];
        [self.contentView addSubview:self.albumname];
        
        self.albunmnumber = [[UILabel alloc]initWithFrame:CGRectMake(55, 30, 100, 20)];
        NSArray* ar  = [al.imgids componentsSeparatedByString:@"&"];
        
        self.albunmnumber.text = [NSString stringWithFormat:@"%d",ar.count ];
       // self.albunmnumber.text=@"0";
        
        self.albunmnumber.font=[UIFont systemFontOfSize:11];
        [self.contentView addSubview:self.albunmnumber];
        
    }
    return  self;
}
@end
